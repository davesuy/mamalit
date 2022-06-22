<?php

namespace modules\depotisemodule\controllers;

use craft\commerce\elements\Product;
use craft\elements\Category;
use Craft;
use craft\commerce\elements\Order;
use craft\commerce\errors\PaymentException;
use craft\commerce\models\PaymentSource;
use craft\commerce\records\Order as OrderRecord;
use craft\helpers\Db;
use craft\helpers\Html;
use craft\helpers\Json;
use craft\web\Controller;
use DateTime;
use Exception;
use GuzzleHttp\Client;
use modules\depotisemodule\DepotiseModule;
use craft\commerce\Plugin;
use modules\depotisemodule\elements\MultipleOrder;
use yii\web\BadRequestHttpException;


class CartController extends Controller
{

	protected $allowAnonymous = ['index', 'get-multiple-cart', 'get-multiple-cart-shipping',
		'get-multiple-cart-payment', 'get-multiple-cart-line-items', 'get-cart', 'update-cart',
		'update-cart-email', 'update-address', 'update-shipping', 'get-cart-and-payment',
		'add-cart', 'make-payment', 'make-all-payment', 'success-pay-mongo-payment', 'line-item-count',
		'submit-payment'
	];
	private $_cartVariableName;


	public function init()
	{
		$this->_cartVariableName = Plugin::getInstance()->getSettings()->cartVariable;

		parent::init();
	}

	/**
	 * @return int|\yii\console\Response|\yii\web\Response|null
	 * @throws \yii\base\InvalidRouteException
	 * @throws \yii\console\Exception
	 */
	public function actionAddCart()
	{
		$request = Craft::$app->getRequest();

		if (($siteId = $request->getParam('siteId')) !== null) {
			Craft::$app->sites->setCurrentSite($siteId);
		}
		return Craft::$app->runAction('commerce/cart/update-cart');
	}

//
//	public function actionMakePayment()
//	{
//		$request = Craft::$app->getRequest();
//
//		if (($siteId = $request->getParam('siteId')) !== null) {
//			Craft::$app->sites->setCurrentSite($siteId);
//		}
//
//		return Craft::$app->runAction('commerce/payments/pay');
//	}

	public function actionMakeCardPayment()
	{
		$request = Craft::$app->getRequest();
		$paymentMethod = $request->getParam('paymentMethod');

		if ($paymentMethod) {

			$bodyParams = $request->getBodyParams();
			$cardDetails = $bodyParams['cardDetails'];

			try {
				$response = $this->payMongoRequest('payment_methods', [
					'attributes' => [
						'type' => 'card',
						'details' => [
							'card_number' => $cardDetails['number'],
							'exp_month' => (int)$cardDetails['month'],
							'exp_year' => (int)$cardDetails['year'],
							'cvc' => $cardDetails['cvc']
						]
					]
				]);

				$paymentMethodContent = Json::decode($response->getBody()->getContents());
				$paymentMethodId = $paymentMethodContent['data']['id'];

				$amount = DepotiseModule::$app->carts->getActiveOrdersTotal('totalPrice', true);

				$amount = number_format($amount, 2, '', '');


				$response = $this->payMongoRequest('payment_intents', [
					'attributes' => [
						'amount' => (int)$amount,
						'payment_method_allowed' => ['card'],
						'currency' => 'PHP'
					]
				]);


				$paymentIntentContent = Json::decode($response->getBody()->getContents());;
				$paymentIntentId = $paymentIntentContent['data']['id'];
				$paymentIntentClientKey = $paymentIntentContent['data']['attributes']['client_key'];

				$response = $this->payMongoRequest('payment_intents/' . $paymentIntentId . '/attach', [
					'attributes' => [
						'payment_method' => $paymentMethodId
					]
				]);
				$apiKey = getenv('PAYMONGO_API_KEY');
				$attachContent = Json::decode($response->getBody()->getContents());
				$attachContent['paymentIntentId'] = $paymentIntentId;
				$attachContent['paymentIntentClientKey'] = $paymentIntentClientKey;
				$attachContent['apiKey'] = $apiKey;

				$status = $attachContent['data']['attributes']['status'];

				if ($status === 'succeeded') {
					return $this->submitAllPay();
				}

				return $this->asJson($attachContent);
			} catch (\Exception $e) {

				return $this->returnAsError($e);
			}
		}
	}

	public function actionSubmitPayment()
	{
		return $this->submitAllPay();
	}

	public function submitAllPay()
	{
		$responses = [];
		$success = true;
		$activeOrder = DepotiseModule::$app->carts->getActiveOrders();

		if (count($activeOrder) > 0) {
			$transaction = Craft::$app->getDb()->beginTransaction();

			try {
				foreach ($activeOrder as $order) {

					Craft::$app->sites->setCurrentSite($order['site']);

					$response = $this->submitPay($order['order']['number']);

					$dataSuccess = $response->data['success'] ?? null;
					if ($dataSuccess === null || $dataSuccess === false) {
						$transaction->rollBack();
						$success = false;
					}

					$responses[] = $response->data;
				}

				if ($success == true) {
					$multipleCart = DepotiseModule::$app->carts->getCart();
					$multipleCart->isCompleted = 1;
					$multipleCart->dateOrdered = Db::prepareDateForDb(new DateTime());

					Craft::$app->elements->saveElement($multipleCart);

					if (getenv('ENVIRONMENT') === 'production') {
						$email = Craft::$app->getConfig()->getGeneral()->newOrderEmail;

						$html = "There is a new order. Checkout <a href='" .
							Craft::$app->getConfig()->getGeneral()->siteUrl . '/' .
							Craft::$app->getConfig()->getGeneral()->cpTrigger . "/depotise-module/multiple-order'>View Orders</a>";

						$this->sendMail($html, "Mamalit New Orders", $email);
					}

					$transaction->commit();
				}
			} catch (\Throwable $e) {
				$transaction->rollBack();
				throw $e;
			}
		}

		return $this->asJson([
			'success' => $success,
			'data' => $responses
		]);
	}

	public function sendMail(string $html, string $subject, $mail): bool
	{
		return Craft::$app
			->getMailer()
			->compose()
			->setTo($mail)
			->setSubject($subject)
			->setHtmlBody($html)
			->send();
	}


	/**
	 * @param $number
	 * @return \yii\web\Response|null
	 * @throws BadRequestHttpException
	 * @throws \Throwable
	 * @throws \craft\commerce\errors\PaymentSourceException
	 * @throws \craft\errors\ElementNotFoundException
	 * @throws \craft\errors\MissingComponentException
	 * @throws \yii\base\Exception
	 * @throws \yii\base\InvalidConfigException
	 * @throws \yii\base\NotSupportedException
	 */
	private function submitPay($number)
	{
		$customError = '';

		/** @var Plugin $plugin */
		$plugin = Plugin::getInstance();
		$request = Craft::$app->getRequest();
		$session = Craft::$app->getSession();
		$currentUser = Craft::$app->getUser()->getIdentity();

		/** @var Order $order */
		$order = $plugin->getOrders()->getOrderByNumber($number);

		if ($plugin->getSettings()->requireShippingAddressAtCheckout && !$order->shippingAddressId) {
			$error = Plugin::t('Shipping address required.');

			if ($request->getAcceptsJson()) {
				return $this->asErrorJson($error);
			}

			$session->setError($error);

			return null;
		}

		if ($plugin->getSettings()->requireBillingAddressAtCheckout && !$order->billingAddressId) {
			$error = Plugin::t('Billing address required.');

			if ($request->getAcceptsJson()) {
				return $this->asErrorJson($error);
			}

			$session->setError($error);

			return null;
		}

		if (!$plugin->getSettings()->allowEmptyCartOnCheckout && $order->getIsEmpty()) {
			$error = Plugin::t('Order can not be empty.');

			if ($request->getAcceptsJson()) {
				return $this->asErrorJson($error);
			}

			$session->setError($error);

			return null;
		}

		// These are used to compare if the order changed during its final
		// recalculation before payment.
		$originalTotalPrice = $order->getOutstandingBalance();
		$originalTotalQty = $order->getTotalQty();
		$originalTotalAdjustments = count($order->getAdjustments());

		// This will return the gateway to be used. The orders gateway ID could be null, but it will know the gateway from the paymentSource ID
		$gateway = $order->getGateway();

		if (!$gateway || !$gateway->availableForUseWithOrder($order)) {
			$error = Plugin::t('There is no gateway or payment source available for this order.');

			if ($request->getAcceptsJson()) {
				return $this->asErrorJson($error);
			}

			if ($order->gatewayId) {
				$order->addError('gatewayId', $error);
			}

			if ($order->paymentSourceId) {
				$order->addError('paymentSourceId', $error);
			}

			$session->setError($error);

			return null;
		}

		// We need the payment form whether we are populating it from the request or from the payment source.
		$paymentForm = $gateway->getPaymentFormModel();

		/**
		 *
		 * Are we paying with:
		 *
		 * 1) The current order paymentSourceId
		 * OR
		 * 2) The current order gatewayId and a payment form populated from the request
		 *
		 */

		// 1) Paying with the current order paymentSourceId
		if ($order->paymentSourceId) {
			/** @var PaymentSource $paymentSource */
			$paymentSource = $order->getPaymentSource();
			if ($gateway->supportsPaymentSources()) {
				$paymentForm->populateFromPaymentSource($paymentSource);
			}
		}

		// 2) Paying with the current order gatewayId and a payment form populated from the request
		if ($order->gatewayId && !$order->paymentSourceId) {

			// Populate the payment form from the params
			$paymentForm->setAttributes($request->getBodyParams(), false);

			// Does the user want to save this card as a payment source?
			if ($currentUser && $request->getBodyParam('savePaymentSource') && $gateway->supportsPaymentSources()) {
				$paymentSource = $plugin->getPaymentSources()->createPaymentSource($currentUser->id, $gateway, $paymentForm);
				$order->setPaymentSource($paymentSource);
				$paymentForm->populateFromPaymentSource($paymentSource);
			}
		}

		// Check email address exists on order.
		if (!$order->email) {
			$customError = Plugin::t('No customer email address exists on this cart.');

			if ($request->getAcceptsJson()) {
				return $this->asJson(['error' => $customError, 'paymentFormErrors' => $paymentForm->getErrors(), 'orderErrors' => $order->getErrors()]);
			}

			$session->setError($customError);
			Craft::$app->getUrlManager()->setRouteParams(['paymentForm' => $paymentForm, $this->_cartVariableName => $order]);

			return null;
		}

		// Does the order require shipping
		if ($plugin->getSettings()->requireShippingMethodSelectionAtCheckout && !$order->getShippingMethod()) {
			$customError = Plugin::t('There is no shipping method selected for this order.');

			if ($request->getAcceptsJson()) {
				return $this->asErrorJson($customError);
			}

			$session->setError($customError);
			Craft::$app->getUrlManager()->setRouteParams(compact('paymentForm'));

			return null;
		}

		// Save the return and cancel URLs to the order
		$returnUrl = $request->getValidatedBodyParam('redirect');
		$cancelUrl = $request->getValidatedBodyParam('cancelUrl');

		if ($returnUrl !== null && $cancelUrl !== null) {
			$view = $this->getView();
			$order->returnUrl = $view->renderObjectTemplate($returnUrl, $order);
			$order->cancelUrl = $view->renderObjectTemplate($cancelUrl, $order);
		}

		// Do one final save to confirm the price does not change out from under the customer. Also removes any out of stock items etc.
		// This also confirms the products are available and discounts are current.
		$order->recalculate();
		// Save the orders new values.

		$totalPriceChanged = $originalTotalPrice != $order->getOutstandingBalance();
		$totalQtyChanged = $originalTotalQty != $order->getTotalQty();
		$totalAdjustmentsChanged = $originalTotalAdjustments != count($order->getAdjustments());

		if (Craft::$app->getElements()->saveElement($order)) {
			// Has the order changed in a significant way?
			if ($totalPriceChanged || $totalQtyChanged || $totalAdjustmentsChanged) {
				if ($totalPriceChanged) {
					$order->addError('totalPrice', Plugin::t('The total price of the order changed.'));
				}

				if ($totalQtyChanged) {
					$order->addError('totalQty', Plugin::t('The total quantity of items within the order changed.'));
				}

				if ($totalAdjustmentsChanged) {
					$order->addError('totalAdjustments', Plugin::t('The total number of order adjustments changed.'));
				}

				$customError = Plugin::t('Something changed with the order before payment, please review your order and submit payment again.');

				if ($request->getAcceptsJson()) {
					return $this->asJson(['error' => $customError, 'paymentFormErrors' => $paymentForm->getErrors(), 'orderErrors' => $order->getErrors()]);
				}

				$session->setError($customError);
				Craft::$app->getUrlManager()->setRouteParams(['paymentForm' => $paymentForm, $this->_cartVariableName => $order]);

				return null;
			}
		}

		$redirect = '';
		$transaction = null;
		$paymentForm->validate();

		if (!$paymentForm->hasErrors() && !$order->hasErrors()) {
			try {
				$plugin->getPayments()->processPayment($order, $paymentForm, $redirect, $transaction);
				$success = true;
			} catch (PaymentException $exception) {
				$customError = $exception->getMessage();
				$success = false;
			}
		} else {
			$customError = Plugin::t('Invalid payment or order. Please review.');
			$success = false;
		}

		if (!$success) {
			if ($request->getAcceptsJson()) {
				return $this->asJson(['error' => $customError, 'paymentFormErrors' => $paymentForm->getErrors(), 'orderErrors' => $order->getErrors()]);
			}

			$session->setError($customError);

			Craft::$app->getUrlManager()->setRouteParams(['paymentForm' => $paymentForm, $this->_cartVariableName => $order]);

			return null;
		}

		if ($request->getAcceptsJson()) {
			$response = ['success' => true, $this->_cartVariableName => $order->toArray()];

			if ($redirect) {
				$response['redirect'] = $redirect;
			}

			if ($transaction) {
				/** @var Transaction $transaction */
				$response['transactionId'] = $transaction->reference;
				$response['transactionHash'] = $transaction->hash;
			}

			return $this->asJson($response);
		}
	}

	private function returnAsError(Exception $e)
	{
		$content = $e->getResponse()->getBody()->getContents();

		$json = Json::decode($content);

		if (count($json['errors']) > 0) {
			$message = $json['errors'][0]['detail'];

			$code = $json['errors'][0]['code'];

			if ($code === 'parameter_below_minimum') {
				$primaryCurrency = Plugin::getInstance()->getPaymentCurrencies()->getPrimaryPaymentCurrency();

				$symbol = Craft::$app->getLocale()->getCurrencySymbol($primaryCurrency);
				$message = "Your order amount total cannot be less than $symbol" . number_format(100.00, 2);
			}

			throw new BadRequestHttpException($message);
		}

		return $this->asJson($json);
	}

	public function actionSuccessPayMongoPayment()
	{
		return $this->submitAllPay();
	}

	private function payMongoRequest($endpoint, $attributes)
	{
		$secretKey = getenv('PAYMONGO_SECRET_KEY');

		$data = [
			'data' => $attributes
		];
		$credentials = base64_encode($secretKey);
		$client = new Client(['base_uri' => 'https://api.paymongo.com/v1']);
		$response = $client->post('/' . $endpoint, [
			'headers' => [
				'Authorization' => 'Basic ' . $credentials,
				'Content-Type' => 'application/json'
			],
			'json' => $data
		]);

		return $response;
	}

	/**
	 * @return \yii\web\Response
	 * @throws \craft\errors\MissingComponentException
	 * @throws \yii\base\Exception
	 *
	 */
	public function actionGetMultipleCart()
	{
		return $this->asJson(DepotiseModule::$app->carts->getMultipleCart());
	}

	public function actionGetMultipleCartShipping()
	{
		$multipleCart = DepotiseModule::$app->carts->getMultipleCart();

		$multipleOrders = $multipleCart['orders'];
		if (count($multipleOrders) > 0) {
			foreach ($multipleOrders as $multipleOrder) {
				$order = $multipleOrder['order'];

				$this->_setPrimaryShippingAddress($multipleCart['multipleOrder'], $order);

				$shippingHandles = array_keys($order['availableShippingMethods']);
			}

			if (count($shippingHandles) > 0) {
				foreach ($shippingHandles as $shippingHandle) {
					$multipleCart['shipping'][$shippingHandle] = Plugin::getInstance()->getShippingMethods()->getShippingMethodByHandle($shippingHandle);
				}
			}
		}

		$multipleCart['shippingMethodHandle'] = 'standardDelivery';

		return $this->asJson($multipleCart);
	}


	/**
	 * @return \yii\web\Response
	 */
	public function actionGetMultipleCartPayment()
	{
		$multipleCart = DepotiseModule::$app->carts->getMultipleCart(true);

		$multipleOrders = $multipleCart['orders'];
		if (count($multipleOrders) > 0) {
			foreach ($multipleOrders as $multipleOrder) {
				$order = $multipleOrder['order'];

				$this->_setPrimaryShippingAddress($multipleCart['multipleOrder'], $order);
			}
		}

		$multipleCart['payments'] = DepotiseModule::$app->carts->getPayments();;

		return $this->asJson($multipleCart);
	}

	/**
	 * Set customer primary address if address page is skipped.
	 *
	 * @param $multipleCart
	 * @param $order
	 * @throws \Throwable
	 * @throws \craft\errors\ElementNotFoundException
	 * @throws \yii\base\Exception
	 */
	private function _setPrimaryShippingAddress($multipleCart, $order)
	{
		if ($order['shippingAddressId'] === null) {
			$shippingAddressId = $multipleCart->shippingAddressId;

			$order = Plugin::getInstance()->getOrders()->getOrderById($order['id']);
			$order->shippingAddressId = $shippingAddressId;
			$order->billingAddressId = $shippingAddressId;

			Craft::$app->getElements()->saveElement($order, false);
		}
	}

	/**
	 * @return \yii\web\Response
	 * @throws \craft\errors\MissingComponentException
	 * @throws \craft\errors\SiteNotFoundException
	 * @throws \yii\base\Exception
	 */
	public function actionGetCart()
	{
		$activeOrders = DepotiseModule::$app->carts->getActiveOrders();

		$carts = [];
		if (count($activeOrders) > 0) {
			foreach ($activeOrders as $key => $activeOrder) {
				$number = $activeOrder['number'];
				$siteId = $activeOrder['site'];

				$element = Order::find()->siteId($siteId)->number($number)->one();

				$carts[$key]['site'] = Craft::$app->sites->getSiteById($siteId);
				$carts[$key]['order'] = $element;
			}
		}

		return $this->renderTemplate('cart', [
			'carts' => []
		]);
	}

	/**
	 * @return \yii\web\Response|null
	 * @throws \craft\errors\MissingComponentException
	 * @throws \yii\base\Exception
	 * @throws \yii\web\BadRequestHttpException
	 */
	public function actionUpdateCartEmail()
	{
		$request = Craft::$app->getRequest();

		$multipleOrderCart = DepotiseModule::$app->carts->getCart();
		$multipleOrderCartRecord = $multipleOrderCart->getRecord();
		$email = $request->getParam('email');
		$multipleOrderCart->email = $email;

		if (Craft::$app->elements->saveElement($multipleOrderCart)) {
			$activeOrders = $multipleOrderCartRecord->getActiveOrders();
			if (count($activeOrders) > 0) {
				foreach ($activeOrders as $key => $record) {
					$record->email = $email;

					$record->save();
				}
			}
		}

		$errors = [];

		$cartVariable = Plugin::getInstance()->getSettings()->cartVariable;
		if ($multipleOrderCartRecord !== null && count($errors) > 0) {
			$error = Plugin::t('Unable to update cart.');

			if ($request->getAcceptsJson()) {
				return $this->asJson([
					'error' => $error,
					'errors' => $errors,
					'success' => false
				]);
			}

			Craft::$app->getUrlManager()->setRouteParams([
				$cartVariable => $multipleOrderCartRecord
			]);

			Craft::$app->getSession()->setError($error);

			return null;
		}

		if (($cartUpdatedNotice = $request->getParam('cartUpdatedNotice')) !== null) {
			Craft::$app->getSession()->setNotice(Html::encode($cartUpdatedNotice));
		} else {
			Craft::$app->getSession()->setNotice(Plugin::t('Cart updated.'));
		}

		if ($multipleOrderCartRecord !== null) {
			Craft::$app->getUrlManager()->setRouteParams([
				$cartVariable => $multipleOrderCartRecord
			]);
		}

		return $this->redirectToPostedUrl();
	}

	/**
	 * @return \yii\web\Response
	 * @throws \craft\errors\MissingComponentException
	 * @throws \yii\base\Exception
	 * @throws \yii\web\BadRequestHttpException
	 */
	public function actionUpdateAddress()
	{
		$request = Craft::$app->getRequest();

		$multipleOrderCart = DepotiseModule::$app->carts->getCart();

		$multipleOrderCartRecord = $multipleOrderCart->getRecord();

		$this->_setAddresses($multipleOrderCart);

		$multipleOrderCart->saveAddress();

		$multipleOrderCartRecord->shippingAddressId = $multipleOrderCart->shippingAddressId;
		$multipleOrderCartRecord->billingAddressId = $multipleOrderCart->billingAddressId;

		if (Craft::$app->elements->saveElement($multipleOrderCart)) {
			$activeOrders = $multipleOrderCartRecord->getActiveOrders();
			if (count($activeOrders) > 0) {
				foreach ($activeOrders as $key => $record) {
					$record->shippingAddressId = $multipleOrderCart->shippingAddressId;
					$record->billingAddressId = $multipleOrderCart->billingAddressId;
					$record->save();
				}
			}
		}

		if (($cartUpdatedNotice = $request->getParam('cartUpdatedNotice')) !== null) {
			Craft::$app->getSession()->setNotice(Html::encode($cartUpdatedNotice));
		} else {
			Craft::$app->getSession()->setNotice(Plugin::t('Cart updated.'));
		}
		$cartVariable = Plugin::getInstance()->getSettings()->cartVariable;

		$return = [
			$cartVariable => $multipleOrderCart
		];

		if ($multipleOrderCart !== null) {
			Craft::$app->getUrlManager()->setRouteParams($return);
		}

		if ($request->getAcceptsJson()) {
			return $this->asJson($return);
		}
		return $this->redirectToPostedUrl();
	}

	private function _setAddresses(MultipleOrder $cart)
	{
		// Address updating
		$request = Craft::$app->getRequest();

		$shippingIsBilling = $request->getParam('shippingAddressSameAsBilling');
		$billingIsShipping = $request->getParam('billingAddressSameAsShipping');
		$estimatedBillingIsShipping = $request->getParam('estimatedBillingAddressSameAsShipping');
		$shippingAddress = $request->getParam('shippingAddress');
		$estimatedShippingAddress = $request->getParam('estimatedShippingAddress');
		$billingAddress = $request->getParam('billingAddress');
		$estimatedBillingAddress = $request->getParam('estimatedBillingAddress');

		// Override billing address with a particular ID
		$shippingAddressId = $request->getParam('shippingAddressId');
		$billingAddressId = $request->getParam('billingAddressId');

		// Shipping address
		if ($shippingAddressId && !$shippingIsBilling) {
			$address = Plugin::getInstance()->getAddresses()->getAddressByIdAndCustomerId($shippingAddressId, $cart->customerId);

			$cart->setShippingAddress($address);
		} else if ($shippingAddress && !$shippingIsBilling) {
			$cart->setShippingAddress($shippingAddress);
		}

		// Billing address
		if ($billingAddressId && !$billingIsShipping) {
			$address = Plugin::getInstance()->getAddresses()->getAddressByIdAndCustomerId($billingAddressId, $cart->customerId);

			$cart->setBillingAddress($address);
		} else if ($billingAddress && !$billingIsShipping) {
			$cart->setBillingAddress($billingAddress);
		}

		// Estimated Shipping Address
		if ($estimatedShippingAddress) {
			if ($cart->estimatedShippingAddressId) {
				$address = Plugin::getInstance()->getAddresses()->getAddressById($cart->estimatedShippingAddressId);
				$address->setAttributes($estimatedShippingAddress, false);
				$estimatedShippingAddress = $address;
			}

			$cart->setEstimatedShippingAddress($estimatedShippingAddress);
		}

		// Estimated Billing Address
		if ($estimatedBillingAddress && !$estimatedBillingIsShipping) {
			if ($cart->estimatedBillingAddressId && ($cart->estimatedBillingAddressId != $cart->estimatedShippingAddressId)) {
				$address = Plugin::getInstance()->getAddresses()->getAddressById($cart->estimatedBillingAddressId);
				$address->setAttributes($estimatedBillingAddress, false);
				$estimatedBillingAddress = $address;
			}

			$cart->setEstimatedBillingAddress($estimatedBillingAddress);
		}

		$cart->billingSameAsShipping = (bool)$billingIsShipping;
		$cart->shippingSameAsBilling = (bool)$shippingIsBilling;
		$cart->estimatedBillingSameAsShipping = (bool)$estimatedBillingIsShipping;

		// Set primary addresses
		if ($request->getBodyParam('makePrimaryShippingAddress')) {
			$cart->makePrimaryShippingAddress = true;
		}

		if ($request->getBodyParam('makePrimaryBillingAddress')) {
			$cart->makePrimaryBillingAddress = true;
		}

		// Shipping
		if ($shippingAddressId && !$shippingIsBilling && $billingIsShipping) {
			$cart->billingAddressId = $shippingAddressId;
		}

		// Billing
		if ($billingAddressId && !$billingIsShipping && $shippingIsBilling) {
			$cart->shippingAddressId = $billingAddressId;
		}
	}

	/**
	 * @return \yii\web\Response
	 * @throws \craft\errors\MissingComponentException
	 * @throws \yii\base\Exception
	 * @throws \yii\base\InvalidConfigException
	 * @throws \yii\web\BadRequestHttpException
	 */
	public function actionUpdateShipping()
	{
		$request = Craft::$app->getRequest();

		$orders = $request->getBodyParam('orders');
		if ($orders) {
			foreach ($orders as $number => $order) {
				$shippingMethodHandle = $order['shippingMethodHandle'];

				$record = OrderRecord::find()->where(['number' => $number])->one();

				$record->shippingMethodHandle = $shippingMethodHandle;

				$record->save();
			}
		}

		return $this->redirectToPostedUrl();
	}

	public function actionLineItemCount()
	{
		return $this->asJson(['qty' => DepotiseModule::$app->carts->getAllLineItemCount()]);
	}

	public function actionAddBundle()
	{
		$app = Craft::$app;

		if (($siteId = $app->getRequest()->getParam('siteId')) !== null) {

		}

		$slug = Craft::$app->getRequest()->getBodyParam('slug');

		$bundle = Category::find()->group('bundles')->slug($slug)->one();

		$products = Product::find()->site('*')->type('products')->relatedTo($bundle)->all();

		$csrfName = Craft::$app->getConfig()->getGeneral()->csrfTokenName;
		$token = Craft::$app->getRequest()->getBodyParam($csrfName);

		if (count($products) > 0) {
			foreach ($products as $key => $product) {
			//	$app->sites->setCurrentSite($product->siteId);

				$app->getRequest()->setBodyParams([
					$csrfName => $token,
					'qty' => 1,
					'purchasableId' => $product->defaultVariantId
				]);

				$app->runAction('commerce/cart/update-cart');
			}
		}


		return $this->redirectToPostedUrl();
	}
}
