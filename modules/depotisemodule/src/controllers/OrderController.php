<?php

namespace modules\depotisemodule\controllers;

use craft\commerce\Plugin;
use craft\web\Controller;
use modules\depotisemodule\assetbundles\depotisemodule\DepotiseModuleAsset;
use modules\depotisemodule\DepotiseModule;
use modules\depotisemodule\elements\MultipleOrder;
use Craft;

class OrderController extends Controller
{
	public function actionEditMultipleOrder(int $multipleOrderId, MultipleOrder $multipleOrder = null)
	{
		Craft::$app->getView()->registerAssetBundle(DepotiseModuleAsset::class);
		if ($multipleOrder == null) {
			if ($multipleOrder == 'new') {
				$multipleOrder = new MultipleOrder();
			} else {
				$multipleOrder = Craft::$app->getElements()->getElementById($multipleOrderId, MultipleOrder::class);
			}

			if ($multipleOrder == null) {
				throw new \Exception("Invalid setup page");
			}
		}

		$data = [];

		$data['reference'] = $multipleOrder->id;

		$customer = Plugin::getInstance()->customers->getCustomerById($multipleOrder->customerId);
		$user = $customer->getUser();
		$data['firstName'] = $user->firstName;
		$data['lastName'] = $user->lastName;
		$data['customer'] = $customer->toArray();
		$shippingAddress = $multipleOrder->getShippingAddress();
		$data['shippingAddress'] = $shippingAddress !== null ? $shippingAddress->toArray() : null;

		return $this->renderTemplate('depotise-module/multiple-order/_edit', [
			'multipleOrder' => $multipleOrder
		]);
	}

	public function actionReceiptMultipleOrder(int $multipleOrderId, MultipleOrder $multipleOrder = null)
	{
		Craft::$app->getView()->registerAssetBundle(DepotiseModuleAsset::class);

		$multipleOrder = Craft::$app->getElements()->getElementById($multipleOrderId, MultipleOrder::class);
		if ($multipleOrder == null) {
			throw new \Exception("Invalid setup page");
		}

		$data = [];

		$data['reference'] = $multipleOrder->id;

		$customer = Plugin::getInstance()->customers->getCustomerById($multipleOrder->customerId);
		$user = $customer->getUser();
		$data['firstName'] = $user->firstName;
		$data['lastName'] = $user->lastName;
		$data['customer'] = $customer->toArray();
		$shippingAddress = $multipleOrder->getShippingAddress();
		$data['shippingAddress'] = $shippingAddress !== null ? $shippingAddress->toArray() : null;

		return $this->renderTemplate('depotise-module/multiple-order/_receipt', [
			'multipleOrder' => $multipleOrder
		]);
	}
}
