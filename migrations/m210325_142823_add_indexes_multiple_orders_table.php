<?php

namespace craft\contentmigrations;

use Craft;
use craft\db\Migration;
use modules\depotisemodule\records\MultipleOrder;

/**
 * m210325_142823_add_indexes_multiple_orders_table migration.
 */
class m210325_142823_add_indexes_multiple_orders_table extends Migration
{
    /**
     * @inheritdoc
     */
    public function safeUp()
    {
		$this->createIndex(null, MultipleOrder::Table, 'number', true);
		$this->createIndex(null, MultipleOrder::Table, 'reference', false);
		$this->createIndex(null, MultipleOrder::Table, 'billingAddressId', false);
		$this->createIndex(null, MultipleOrder::Table, 'shippingAddressId', false);
		$this->createIndex(null, MultipleOrder::Table, 'gatewayId', false);
		$this->createIndex(null, MultipleOrder::Table, 'customerId', false);
		$this->createIndex(null, MultipleOrder::Table, 'orderStatusId', false);
		$this->createIndex(null, MultipleOrder::Table, 'email', false);
    }

    /**
     * @inheritdoc
     */
    public function safeDown()
    {
        echo "m210325_142823_add_indexes_multiple_orders_table cannot be reverted.\n";
        return false;
    }
}
