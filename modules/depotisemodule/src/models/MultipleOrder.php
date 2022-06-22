<?php

namespace modules\depotisemodule\models;

use craft\base\Model;
use craft\commerce\elements\Order;
use craft\commerce\models\Address;
use craft\commerce\models\Customer;
use craft\commerce\Plugin;
use craft\elements\User;
use DateTime;
use modules\depotisemodule\DepotiseModule;
use modules\depotisemodule\records\MultipleOrder as MultipleOrderRecord;
use Craft;
use yii\base\InvalidConfigException;

class MultipleOrder extends Model
{
	public $id;
	public $number;
	public $isCompleted;
	public $email;
	public $currency = 'PHP';
	public $reference;
	public $couponCode;
	public $dateOrdered;
	public $datePaid;
	public $dateAuthorized;
	public $gatewayId;
	public $lastIp;
	public $message;
	public $returnUrl;
	public $cancelUrl;
	public $orderStatusId;
	public $orderLanguage;
	public $origin;
	public $billingAddressId;
	public $shippingAddressId;
	public $makePrimaryShippingAddress;
	public $makePrimaryBillingAddress;
	public $shippingSameAsBilling;
	public $billingSameAsShipping;
	public $estimatedBillingAddressId;
	public $estimatedShippingAddressId;
	public $estimatedBillingSameAsShipping;
	public $shippingMethodHandle;
	public $customerId;
	public $registerUserOnOrderComplete;
	public $paymentSourceId;
	public $storedTotalPrice;
	public $storedTotalPaid;
	public $storedItemTotal;
	public $storedTotalShippingCost;
	public $storedTotalDiscount;
	public $storedTotalTax;
	public $storedTotalTaxIncluded;
	private $_shippingAddress;
	private $_billingAddress;
	private $_estimatedShippingAddress;
	private $_estimatedBillingAddress;

	public $shippingAddress;

	public function getRecord()
	{
		$record = new MultipleOrderRecord();

		$record->setAttributes($this->getAttributes(), false);

		return $record;
	}

	/**
	 * @return array
	 * @throws \craft\errors\SiteNotFoundException
	 */
	public function getActiveOrders($lineItemsOnly = false)
	{
		$record = $this->getRecord();

		/**
		 * @var \craft\commerce\records\Order[] $orderRecords
		 */
		$orderRecords = $record->getActiveOrders();

		$activeOrders = [];

		if (count($orderRecords) > 0) {
			$i = 0;
			$currentSiteId = Craft::$app->sites->getCurrentSite()->id;

			foreach ($orderRecords as $key => $orderRecord) {

				$siteIds = Craft::$app->elements->getEnabledSiteIdsForElement($orderRecord->id);
				$siteId = $siteIds[0];
				/**
				 * @var Order $order
				 */
				//$order = Craft::$app->getElements()->getElementById($orderRecord->id, Order::class, $siteIds[0]);

				$order = DepotiseModule::$app->orders->cartOrder($siteId, $orderRecord->number, $lineItemsOnly);

				if ($order === null) {
					continue;
				}

				// Exclude main site
				if ($order !== null && $order['siteId'] === Craft::$app->sites->getPrimarySite()->id) {
					continue;
				}

				$activeOrders[$i]['order']  = $order;
				$activeOrders[$i]['site']   = $order['siteId'] ?? 'site missing: ' . $orderRecord->id;

				$i++;
			}

			// Reverted because cartToJson has setCurrentSite for every cart
			Craft::$app->sites->setCurrentSite($currentSiteId);
		}

		return $activeOrders;
	}

	public function getShippingAddress()
	{
		if (null === $this->_shippingAddress && $this->shippingAddressId) {
			$this->_shippingAddress = Plugin::getInstance()->getAddresses()->getAddressById($this->shippingAddressId);
		}

		return $this->_shippingAddress;
	}

	/**
	 * @param Address|array $address
	 */
	public function setShippingAddress($address)
	{
		if (!$address instanceof Address) {
			$address = new Address($address);
		}

		$this->shippingAddressId = $address->id;
		$this->_shippingAddress = $address;
	}

	/**
	 * @return Address|null
	 * @since 2.2
	 */
	public function getEstimatedShippingAddress()
	{
		if (null === $this->_estimatedShippingAddress && $this->estimatedShippingAddressId) {
			$this->_estimatedShippingAddress = Plugin::getInstance()->getAddresses()->getAddressById($this->estimatedShippingAddressId);
		}

		return $this->_estimatedShippingAddress;
	}

	/**
	 * @param Address|array $address
	 * @since 2.2
	 */
	public function setEstimatedShippingAddress($address)
	{
		if (!$address instanceof Address) {
			$address = new Address($address);
		}
		$address->isEstimated = true;

		$this->estimatedShippingAddressId = $address->id;
		$this->_estimatedShippingAddress = $address;
	}

	/**
	 * @param Address|array $address
	 * @since 2.2
	 */
	public function setEstimatedBillingAddress($address)
	{
		if (!$address instanceof Address) {
			$address = new Address($address);
		}
		$address->isEstimated = true;

		$this->estimatedBillingAddressId = $address->id;
		$this->_estimatedBillingAddress = $address;
	}

	/**
	 * @return Address|null
	 */
	public function getBillingAddress()
	{
		if (null === $this->_billingAddress && $this->billingAddressId) {
			$this->_billingAddress = Plugin::getInstance()->getAddresses()->getAddressById($this->billingAddressId);
		}

		return $this->_billingAddress;
	}

	/**
	 * @param Address|array $address
	 */
	public function setBillingAddress($address)
	{
		if (!$address instanceof Address) {
			$address = new Address($address);
		}

		$this->billingAddressId = $address->id;
		$this->_billingAddress = $address;
	}

	/**
	 * @return Address|null
	 * @since 2.2
	 */
	public function getEstimatedBillingAddress()
	{
		if (null === $this->_estimatedBillingAddress && $this->estimatedBillingAddressId) {
			$this->_estimatedBillingAddress = Plugin::getInstance()->getAddresses()->getAddressById($this->estimatedBillingAddressId);
		}

		return $this->_estimatedBillingAddress;
	}


	public function saveAddress()
	{
		$orderRecord = $this->getRecord();
		// Make sure addresses are set before recalculation so that on the next page load
		// the correct adjustments and totals are shown
		if ($this->shippingSameAsBilling) {
			$this->setShippingAddress($this->getBillingAddress());
		}

		if ($this->billingSameAsShipping) {
			$this->setBillingAddress($this->getShippingAddress());
		}

		$customer = $this->getCustomer();
		$existingAddresses = $customer ? $customer->getAddresses() : [];

		$customerUser = $customer->getUser();
		$currentUser = Craft::$app->getUser()->getIdentity();
		$noCustomerUserOrCurrentUser = ($customerUser == null && $currentUser == null);
		$currentUserDoesntMatchCustomerUser = ($currentUser && ($customerUser == null || $currentUser->id != $customerUser->id));

		// Save shipping address, it has already been validated.
		if ($shippingAddress = $this->getShippingAddress()) {
			// We need to only save the address to the customers address book while it is a cart and not being edited by another user
			if ($customer && ($noCustomerUserOrCurrentUser || !$currentUserDoesntMatchCustomerUser) && !$this->isCompleted) {
				Plugin::getInstance()->getCustomers()->saveAddress($shippingAddress, $customer, false);
			} else {
				Plugin::getInstance()->getAddresses()->saveAddress($shippingAddress, false);
			}

			$orderRecord->shippingAddressId = $shippingAddress->id;
			$this->setShippingAddress($shippingAddress);
		}

		// Save billing address, it has already been validated.
		if ($billingAddress = $this->getBillingAddress()) {
			// We need to only save the address to the customers address book while it is a cart and not being edited by another user
			if ($customer && ($noCustomerUserOrCurrentUser || !$currentUserDoesntMatchCustomerUser) && !$this->isCompleted) {
				Plugin::getInstance()->getCustomers()->saveAddress($billingAddress, $customer, false);
			} else {
				Plugin::getInstance()->getAddresses()->saveAddress($billingAddress, false);
			}

			$orderRecord->billingAddressId = $billingAddress->id;
			$this->setBillingAddress($billingAddress);
		}

		if ($estimatedShippingAddress = $this->getEstimatedShippingAddress()) {
			Plugin::getInstance()->getAddresses()->saveAddress($estimatedShippingAddress, false);

			$orderRecord->estimatedShippingAddressId = $estimatedShippingAddress->id;
			$this->setEstimatedShippingAddress($estimatedShippingAddress);

			// If estimate billing same as shipping set it here
			if ($this->estimatedBillingSameAsShipping) {
				$orderRecord->estimatedBillingAddressId = $estimatedShippingAddress->id;
				$this->setEstimatedBillingAddress($estimatedShippingAddress);
			}
		}

		if (!$this->estimatedBillingSameAsShipping && $estimatedBillingAddress = $this->getEstimatedBillingAddress()) {
			Plugin::getInstance()->getAddresses()->saveAddress($estimatedBillingAddress, false);

			$orderRecord->estimatedBillingAddressId = $estimatedBillingAddress->id;
			$this->setEstimatedBillingAddress($estimatedBillingAddress);
		}

		return $this;
	}

	public function setEmail()
	{
		$customer = Plugin::getInstance()->getCustomers()->getCustomerById($this->customerId);
		if ($customer && $email = $customer->getEmail()) {
			$this->_email = $email;
		}
	}

	public function getEmail()
	{
		if ($this->getCustomer() && $this->getCustomer()->getUser()) {
			$this->setEmail($this->getCustomer()->getUser()->email);
		}

		return $this->_email ?? null;
	}

	/**
	 * @return Customer|null
	 */
	public function getCustomer()
	{
		if ($this->customerId) {
			return Plugin::getInstance()->getCustomers()->getCustomerById($this->customerId);
		}

		return null;
	}

	/**
	 * @return User|null
	 * @throws InvalidConfigException
	 */
	public function getUser()
	{
		return $this->getCustomer() ? $this->getCustomer()->getUser() : null;
	}

	public function getCustomerId()
	{
		return Plugin::getInstance()->getCustomers()->getCustomerId();
	}
}
