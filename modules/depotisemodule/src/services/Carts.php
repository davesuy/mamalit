<?php
namespace modules\depotisemodule\services;

use Craft;
use craft\base\Component;
use craft\commerce\controllers\BaseFrontEndController;
use craft\commerce\db\Table;
use craft\commerce\elements\Order;
use craft\commerce\events\ModifyCartInfoEvent;
use craft\commerce\Plugin;
use craft\config\GeneralConfig;
use craft\db\Query;
use craft\elements\db\AssetQuery;
use craft\elements\User;
use craft\helpers\Json;
use modules\depotisemodule\DepotiseModule;
use modules\depotisemodule\elements\MultipleOrder as MultipleOrderElement;
use modules\depotisemodule\models\MultipleOrder;
use modules\depotisemodule\records\MultipleOrder as MultipleOrderRecord;
use yii\db\Expression;


class Carts extends Component
{
	/**
	 * @var string Session key for storing the cart number
	 */
	protected $cartName = 'commerce_multiple_cart';

	/**
	 * @var MultipleOrder
	 */
	private $_cart;

	protected $cartRecord;

	private $_getCartRecord;


	/**
	 * @return array|MultipleOrderElement|MultipleOrder|\yii\db\ActiveRecord|null
	 * @throws \Throwable
	 * @throws \craft\errors\ElementNotFoundException
	 * @throws \craft\errors\MissingComponentException
	 * @throws \yii\base\Exception
	 * @throws \yii\base\InvalidConfigException
	 */
	public function getCart()
	{
		// If there is no cart set for this request, and we can't get a cart from session, create one.
		if (null === $this->_cart && !$this->_cart = $this->_getCart()) {
			$this->forgetCart(); // Remove the cart number from session if there was one.
			$record = new MultipleOrderRecord();
//			$record->number = $this->getSessionCartNumber();
//			$record->save();

			$element = new MultipleOrderElement();
			$element->siteId = Craft::$app->sites->getPrimarySite()->id;
			$element->number = $this->getSessionCartNumber();

			$this->_cart = $element;
		}

		$originalCustomerId = $this->_cart->customerId;

		$this->_cart->customerId = Plugin::getInstance()->getCustomers()->getCustomer()->id;

		$changedCustomerId = $originalCustomerId != $this->_cart->customerId;

		if ($changedCustomerId) {
			$customer = Plugin::getInstance()->getCustomers()->getCustomer();
			if ($customer !== null) {
/*				$multipleOrderCart = DepotiseModule::$app->carts->getModel($this->_cart);
				// Don't lose the data from the address, just drop the ID so when the order is saved, the address belongs to the new customer of the order
				if ($multipleOrderCart->billingAddressId && $billingAddress = Plugin::getInstance()->getAddresses()->getAddressById($multipleOrderCart->billingAddressId)) {
					$billingAddress->id = null;
					$multipleOrderCart->setBillingAddress($billingAddress);
				}
				// Don't lose the data from the address, just drop the ID so when the order is saved, the address belongs to the new customer of the order
				if ($multipleOrderCart->shippingAddressId && $shippingAddress = Plugin::getInstance()->getAddresses()->getAddressById($multipleOrderCart->shippingAddressId)) {
					$shippingAddress->id = null;
					$multipleOrderCart->setShippingAddress($shippingAddress);
				}

				$multipleOrderCart->saveAddress();
*/
				$this->_cart->shippingAddressId = null;
				$this->_cart->billingAddressId  = null;

				if (($user = $customer->getUser()) !== null) {
					$this->_cart->email = $user->email;
				}

				Craft::$app->elements->saveElement($this->_cart);
			}

			$activeOrders = $this->_cart->getRecord()->getActiveOrders();

			if (count($activeOrders) > 0) {
				foreach ($activeOrders as $key => $record) {
					// Prevent changed user from creating new addresses
					$record->shippingAddressId = null;
					$record->billingAddressId  = null;
					$record->save();
				}
			}
		}

		return $this->_cart;
	}

	/**
	 * @return array|\yii\db\ActiveRecord|null
	 * @throws \craft\errors\MissingComponentException
	 */
	private function _getCart()
	{
		$cart = null;

		$isNumberCartInSession = $this->getHasSessionCartNumber();

		// Load the current cart if there is a cart number in the session
		if ($isNumberCartInSession) {
			$number = $this->getSessionCartNumber();

			// Get the cart based on the number in the session.
			// It might be completed or trashed, but we still want to load it so we can determine this and forget it.
			$cartElement = MultipleOrderElement::find()->where(['number' => $number])->one();

			if ($cartElement !== null) {
				$cart = $cartElement;
			}
		}

		// If the cart is already completed or trashed, forget the cart and start again.
		if ($cart && $cart->isCompleted) {
			$this->forgetCart();

			$cart = null; // continue
		}

		return $cart;
	}

	/**
	 * @param $record
	 * @return MultipleOrderElement
	 */
	public function getModel($record)
	{
		$model = new MultipleOrderElement();

		$model->setAttributes($record->getAttributes(), false);

		$model->shippingAddress = $model->getShippingAddress();

		return $model;
	}

	/**
	 * @return bool
	 * @throws \craft\errors\MissingComponentException
	 */
	public function getHasSessionCartNumber(): bool
	{
		$session = Craft::$app->getSession();

		return ($session->getHasSessionId() || $session->getIsActive()) && $session->has($this->cartName);
	}

	/**
	 * @return string
	 * @throws \craft\errors\MissingComponentException
	 */
	private function getSessionCartNumber(): string
	{
		$session = Craft::$app->getSession();
		$cartNumber = $session->get($this->cartName);

		if (!$cartNumber) {
			$cartNumber = $this->generateCartNumber();
			$session->set($this->cartName, $cartNumber);
		}

		return $cartNumber;
	}

	public function generateCartNumber(): string
	{
		return md5(uniqid(mt_rand(), true));

	}

	/**
	 * @throws \craft\errors\MissingComponentException
	 */
	public function forgetCart()
	{
		$this->_cart = null;
		Craft::$app->getSession()->remove($this->cartName);

		$sites = Craft::$app->sites->getAllSites();

		if (count($sites)) {
			foreach ($sites as $site) {
				$uid = $site->uid;

				Craft::$app->getSession()->remove('commerce_cart:' . $uid);
			}
		}

	}

	public function getSiteCart()
	{
/*		$site = Craft::$app->sites->getCurrentSite();

		$cart = $this->getCart();

		$activeOrders = $cart->getActiveOrders();

		if (count($activeOrders) > 0) {
			foreach ($activeOrders as $activeOrder) {
				if ($site->id == $activeOrder['site']) {
					$number = $activeOrder['number'];
					return Order::find()->number($number)->one();
				}
			}
		}*/

		if (DepotiseModule::$app->isPrimarySite()) {
			return $this->getCart();
		}

		return Plugin::getInstance()->getCarts()->getCart();
	}

	public function onLoginRestoreUserCart()
	{
		$currentUser = Craft::$app->getUser()->getIdentity();
		$setLatestOrder = true;
		if ($currentUser !== null) {

			$multipleOrderNumber = Craft::$app->getSession()->get($this->cartName);

			if ($multipleOrderNumber !== null) {
				// Use existing cart session instead of latest order
				if ($this->hasSessionMultipleCartOrders($multipleOrderNumber) !== null) {
					$setLatestOrder = false;
				}
			}

			if ($setLatestOrder === true) {
				$this->setSessionCarts($currentUser);
			}
		}
	}

	public function getLatestMultipleOrder($customerId)
	{
		return \modules\depotisemodule\records\MultipleOrder::find()->where([
			'isCompleted' => NULL,
			'customerId' => $customerId])->andWhere([
			'exists',
			(new Query())
				->from('commerce_orders')
				->where(new Expression('[[commerce_orders.multipleOrderId]] = [[multiple_orders.id]]'))
		])->orderBy('id DESC')->one();
	}

	public function hasSessionMultipleCartOrders($number)
	{
		return \modules\depotisemodule\records\MultipleOrder::find()->where([
			'isCompleted' => NULL,
			'number' => $number])->andWhere([
			'exists',
			(new Query())
				->from('commerce_orders')
				->where(new Expression('[[commerce_orders.multipleOrderId]] = [[multiple_orders.id]]'))
		])->orderBy('id DESC')->one();
	}

	public function setSessionCarts($currentUser)
	{
		$customer = Plugin::getInstance()->getCustomers()->getCustomerByUserId($currentUser->id);

		$multipleOrder = $this->getLatestMultipleOrder($customer->id);

		if ($multipleOrder !== null) {
			$activeOrders = $multipleOrder->getActiveOrders();

			if (count($activeOrders) > 0) {
				Craft::$app->getSession()->set($this->cartName, $multipleOrder->number);

				foreach ($activeOrders as $activeOrder) {
					$order = Plugin::getInstance()->getOrders()->getOrderById($activeOrder->id);

					$session = Craft::$app->getSession();
					$session->set('commerce_cart:' . $order->site->uid , $order->number);
				}
			}
		}
	}

	/**
	 * @return array
	 * @throws \craft\errors\MissingComponentException
	 * @throws \craft\errors\SiteNotFoundException
	 * @throws \yii\base\Exception
	 */
	public function getActiveOrders()
	{
		$multipleOrderCart = DepotiseModule::$app->carts->getCart();

		return $multipleOrderCart->getActiveOrders();
	}

	public function hasActiveOrdersTotal()
	{
		if ($this->getActiveOrdersTotal('totalPrice', true) > 0) {
			return true;
		}

		return false;
	}

	public function getActiveOrdersTotal($column = 'totalPrice', $plain = false)
	{
		$activeOrders = $this->getActiveOrders();

		$totalPrice = 0;
		$orderNumbers = [];
		if (count($activeOrders) > 0) {
			foreach ($activeOrders as $activeOrder) {
				$number = $activeOrder['order']['number'];
				$orderNumbers[] = $number;
			}

			$totalPrice = \craft\commerce\records\Order::find()->where(['number' => $orderNumbers])->sum($column);
		}

		if ($plain === true) {
			return $totalPrice;
		}

		$currency  = Plugin::getInstance()->getPaymentCurrencies()->getPrimaryPaymentCurrency();
		if ($totalPrice !== null) {
			return Craft::$app->getFormatter()->asCurrency($totalPrice, $currency);
		}

		return null;
	}

	public function getAllLineItemCount()
	{
		$activeOrders = $this->getActiveOrders();

		$count = 0;
		if (count($activeOrders) > 0) {
			foreach ($activeOrders as $activeOrder) {
				$order = $activeOrder['order'];
				$count+= count($order['lineItems']);
			}
		}

		return $count;
	}

	public function getMultipleCart($lineItemsOnly = false)
	{
		$multipleOrderCart = $this->getCart();

		if (($shippingAddress = $multipleOrderCart->getShippingAddress()) !== null) {
			$shipping = $shippingAddress->toArray();
			$shipping['postCode'] = DepotiseModule::$app->getPostCode($shippingAddress->zipCode);
			$multipleOrderCart['shippingAddress'] = $shipping;
		}

		$activeOrders =  $multipleOrderCart->getActiveOrders($lineItemsOnly);

		$count = 0;
		$orders = [];
		if (count($activeOrders) > 0) {
			$i = 0;

			foreach ($activeOrders as $key => $activeOrder) {

				$order = $activeOrder['order'];
				$count+= count($order['lineItems']);

				$siteId = $activeOrder['site'];
				$orders[$i]['order'] = $activeOrder['order'];
				$orders[$i]['site']  = Craft::$app->sites->getSiteById($siteId)->toArray();
				$orders[$i]['payments'] = DepotiseModule::$app->carts->getPayments();
				$orders[$i]['success'] = null;
				$orders[$i]['loading'] = false;
				$orders[$i]['updating'] = false;
				$orders[$i]['paymentResult'] = null;
				$orders[$i]['hide'] = true;
				$i++;
			}
		}

		$primaryCurrency = Plugin::getInstance()->getPaymentCurrencies()->getPrimaryPaymentCurrency();

		$customer = Plugin::getInstance()->customers->getCustomer();

		return [
			'orders' => $orders,
			'user' => $customer->getUser(),
			'multipleOrder' => $multipleOrderCart,
			'itemQty' => $count,
			'currency' => Craft::$app->getLocale()->getCurrencySymbol($primaryCurrency),
			'isFirstOrder' => $this->isFirstOrder($customer)
		];
	}

	public function isFirstOrder($customer)
	{
		if (Craft::$app->getConfig()->general->firstOrder !== 'free') {
			return false;
		}

		$multipleOrder = DepotiseModule::$app->orders->getLatestMultipleOrderByCustomerId($customer->id);

		if ($multipleOrder === null) {
			return true;
		}

		return false;
	}

	public function getPayments()
	{
		$options = [];
		$options['selected'] = null;
		$i = 0;
		$user = Craft::$app->getUser()->getIdentity();
		$storedCards = null;

		if ($user) {
			$storedCards = Plugin::getInstance()->paymentSources->getAllPaymentSourcesByUserId($user->id);
		}

		if ($storedCards) {
			foreach ($storedCards as $storedCard) {
				$options['items'][$i]['label'] = $storedCard->description;
				$options['items'][$i]['value'] = "paymentSourceId:". $storedCard->id;
				$options['items'][$i]['paymentMethod'] = "paymentSourceId";
				$i++;
			}
		}

		$gateways = Plugin::getInstance()->gateways->getAllCustomerEnabledGateways();

		if (count($gateways) > 0) {
			foreach ($gateways as $key => $gateway) {
				$options['items'][$i]['label'] = $gateway->name;
				$options['items'][$i]['handle'] = $gateway->handle;
				$options['items'][$i]['value'] = "gatewayId:" . $key;
				$options['items'][$i]['paymentMethod'] = "gatewayId";
				$options['items'][$i]['type'] = get_class($gateway);
				$options['items'][$i]['html'] = $gateway->getPaymentFormHtml([]);
				$i++;
			}

			$selectPayment = [
					'label' => 'Select Payment',
					'value' => null
			];

			array_unshift($options['items'], $selectPayment);
		}

		return $options;
	}

	public function cartArray(Order $cart)
	{
		// Typecast order attributes
		$cart->typeCastAttributes();
		$cart->paymentCurrency = Plugin::getInstance()->getPaymentCurrencies()->getPrimaryPaymentCurrency();
		$extraFields = [
			'lineItems.snapshot',
			'lineItems.productImages',
			'availableShippingMethods',
			'availableShippingMethodOptions',
			'totalTax',
			'totalTaxIncluded',
			'totalShippingCost',
			'totalDiscount'
		];

		Craft::$app->sites->setCurrentSite($cart->siteId);
		try {
			$cartInfo = $cart->toArray([], $extraFields);
		} catch (\Exception $e) {
			DepotiseModule::$app->carts->forgetCart();
			return null;
		}

		$cartInfo['lineItems'] = array_map(function($item) {
			$purchasableId = $item['purchasableId'];

			$purchasable = Plugin::getInstance()->purchasables->getPurchasableById($purchasableId);

			/**
			 * @var AssetQuery $query
			 */
			$query = $purchasable->productImages;

			$asset = $query->siteId('*')->one();

			if ($asset !== null) {
				$item['productImage'] = $asset->getUrl('thumbnail');
			}

			return $item;

		}, $cartInfo['lineItems']);

		// Fire a 'modifyCartContent' event
		$event = new ModifyCartInfoEvent([
			'cartInfo' => $cartInfo,
		]);

		$this->trigger(BaseFrontEndController::EVENT_MODIFY_CART_INFO, $event);

		return $event->cartInfo;
	}
}
