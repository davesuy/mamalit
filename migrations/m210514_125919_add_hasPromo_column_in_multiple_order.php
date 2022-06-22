<?php

namespace craft\contentmigrations;

use Craft;
use craft\db\Migration;
use modules\depotisemodule\records\MultipleOrder;

/**
 * m210514_125919_add_hasPromo_column_in_multiple_order migration.
 */
class m210514_125919_add_hasPromo_column_in_multiple_order extends Migration
{
    /**
     * @inheritdoc
     */
    public function safeUp()
    {
		if ($this->getDb()->tableExists(MultipleOrder::Table) === true) {
			$this->addColumn(MultipleOrder::Table, 'hasPromo', $this->boolean());
		}
    }

    /**
     * @inheritdoc
     */
    public function safeDown()
    {
        echo "m210514_125919_add_hasPromo_column_in_multiple_order cannot be reverted.\n";
        return false;
    }
}
