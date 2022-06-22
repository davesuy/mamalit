<?php

namespace modules\depotisemodule\controllers;

use Craft;
use craft\commerce\Plugin;
use craft\web\Controller;
use modules\depotisemodule\DepotiseModule;


class CustomerController extends Controller
{

	protected $allowAnonymous = ['get-address'];

	public function actionGetAddress()
	{
		$addressId = Craft::$app->request->getBodyParam('addressId');
		$countryId = Plugin::getInstance()->countries->getCountryByIso('PH')->id;

		$shippingAddress = [
			'phone' => '',
			'alternativePhone' => '',
			'firstName' => '',
			'lastName' => '',
			'address1' => '',
			'address2' => '',
			'address3' => '',
			'stateValue' => Plugin::getInstance()->states->getStateByAbbreviation($countryId, 'CEB')->id,
			'countryId' => $countryId,
			'notes' => null,
			'zipCode' => null
		];

		$makePrimaryShippingAddress = false;

		if ($addressId !== 0) {
			$shippingAddress = Plugin::getInstance()->addresses->getAddressById($addressId);
			$primaryAddress = Plugin::getInstance()->customers->getCustomer()->getPrimaryShippingAddress();
			if ($shippingAddress->id === $primaryAddress->id) {
				$makePrimaryShippingAddress = true;
			}
		}

		return $this->asJson([
			'states' => DepotiseModule::$app->getProvinces(),
			'country' => Plugin::getInstance()->countries->getCountryByIso('PH'),
			'address' => $shippingAddress,
			'makePrimaryShippingAddress' => $makePrimaryShippingAddress,
			'postCodes' => DepotiseModule::$app->getPostCodes()
		]);
	}
}
