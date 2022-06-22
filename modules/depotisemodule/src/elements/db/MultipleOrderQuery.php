<?php

namespace modules\depotisemodule\elements\db;

use craft\elements\db\ElementQuery;
use Craft;

class MultipleOrderQuery extends ElementQuery
{
	/**
	 * @inheritdoc
	 */
//	protected $defaultOrderBy = ['multiple_orders.dateCreated' => SORT_DESC];
	public $customerId;
	public $isCompleted;
	public $completed;
	/**
	 * @inheritdoc
	 */
	protected function beforePrepare(): bool
	{
		$this->joinElementTable('multiple_orders');

		$this->query->select([
				'multiple_orders.id',
				'multiple_orders.number',
				'multiple_orders.reference',
				'multiple_orders.couponCode',
				'multiple_orders.orderStatusId',
				'multiple_orders.dateOrdered',
				'multiple_orders.email',
				'multiple_orders.isCompleted',
				'multiple_orders.datePaid',
				'multiple_orders.currency',
				'multiple_orders.paymentCurrency',
				'multiple_orders.lastIp',
				'multiple_orders.orderLanguage',
				'multiple_orders.message',
				'multiple_orders.returnUrl',
				'multiple_orders.cancelUrl',
				'multiple_orders.billingAddressId',
				'multiple_orders.shippingAddressId',
				'multiple_orders.estimatedBillingAddressId',
				'multiple_orders.estimatedShippingAddressId',
				'multiple_orders.shippingMethodHandle',
				'multiple_orders.gatewayId',
				'multiple_orders.paymentSourceId',
				'multiple_orders.customerId',
				'multiple_orders.dateUpdated',
				'multiple_orders.hasPromo'
			]
		);


		if ($this->customerId !== null) {
			$this->subQuery->where([
				'customerId' => $this->customerId
			]);
		}

		if ($this->completed === false) {
			$this->subQuery->andWhere([
				'isCompleted' => null
			]);
		} else {
			if (Craft::$app->request->getIsCpRequest() || $this->completed === 1) {

				$this->subQuery->andWhere([
					'isCompleted' => 1
				]);

			}
		}

		return parent::beforePrepare();
	}

	public function completed($bool)
	{
		$this->completed = $bool;

		return $this;
	}

	public function customerId($customerId)
	{
		$this->customerId = $customerId;

		return $this;
	}
}
