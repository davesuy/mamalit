<?php

namespace craft\contentmigrations;

use Craft;
use craft\commerce\db\Table;
use craft\db\Migration;
use modules\depotisemodule\records\MultipleOrder;

/**
 * m200302_090120_create_multiple_orders migration.
 */
class m200302_090120_create_multiple_orders extends Migration
{
    /**
     * @inheritdoc
     */
    public function safeUp()
    {
    	if ($this->getDb()->tableExists(MultipleOrder::Table) === false) {
			$this->createTable(MultipleOrder::Table, [
				'id' => $this->primaryKey(),
				'number' => $this->string(32),
				'reference' => $this->string(),
				'totalPrice' => $this->decimal(14, 4)->defaultValue(0),
				'totalPaid' => $this->decimal(14, 4)->defaultValue(0),
				'dateCreated' => $this->dateTime()->notNull(),
				'dateUpdated' => $this->dateTime()->notNull(),
				'isCompleted' => $this->boolean(),
				'dateOrdered' => $this->dateTime(),
				'uid' => $this->uid(),
				'billingAddressId' => $this->integer(),
				'shippingAddressId' => $this->integer(),
				'estimatedBillingAddressId' => $this->integer(),
				'estimatedShippingAddressId' => $this->integer(),
				'gatewayId' => $this->integer(),
				'paymentSourceId' => $this->integer(),
				'customerId' => $this->integer(),
				'orderStatusId' => $this->integer(),
				'couponCode' => $this->string(),
				'itemTotal' => $this->decimal(14, 4)->defaultValue(0),
				'total' => $this->decimal(14, 4)->defaultValue(0),
				'totalDiscount' => $this->decimal(14, 4)->defaultValue(0),
				'totalTax' => $this->decimal(14, 4)->defaultValue(0),
				'totalTaxIncluded' => $this->decimal(14, 4)->defaultValue(0),
				'totalShippingCost' => $this->decimal(14, 4)->defaultValue(0),
				'paidStatus' => $this->enum('paidStatus', ['paid', 'partial', 'unpaid', 'overPaid']),
				'email' => $this->string(),
				'datePaid' => $this->dateTime(),
				'dateAuthorized' => $this->dateTime(),
				'currency' => $this->string(),
				'paymentCurrency' => $this->string(),
				'lastIp' => $this->string(),
				'orderLanguage' => $this->string(12),
				'origin' => $this->enum('origin', ['web', 'cp', 'remote'])->defaultValue('web'),
				'message' => $this->text(),
				'registerUserOnOrderComplete' => $this->boolean(),
				'recalculationMode' => $this->enum('recalculationMode', ['all', 'none', 'adjustmentsOnly'])->defaultValue('all'),
				'returnUrl' => $this->string(),
				'cancelUrl' => $this->string(),
				'shippingMethodHandle' => $this->string()
			]);
		}
        $this->addColumn(Table::ORDERS, 'multipleOrderId', $this->integer());

		$this->createIndex(null, Table::ORDERS, ['multipleOrderId'], false);

		$this->addForeignKey(null, Table::ORDERS, ['multipleOrderId'],
			MultipleOrder::Table, ['id'], 'CASCADE', 'RESTRICT');

		$this->addForeignKey(null, MultipleOrder::Table,
			['id'], '{{%elements}}', ['id'], 'CASCADE');
    }

    /**
     * @inheritdoc
     */
    public function safeDown()
    {
        echo "m200302_090120_create_multiple_orders cannot be reverted.\n";
        return false;
    }
}
