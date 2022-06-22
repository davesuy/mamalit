<?php

namespace craft\contentmigrations;

use craft\db\Migration;
use craft\db\Table;
use modules\depotisemodule\records\SitesRank;

/**
 * m201225_101645_sites_rank migration.
 */
class m201225_101645_sites_rank extends Migration
{
    /**
     * @inheritdoc
     */
    public function safeUp()
    {
		if ($this->getDb()->tableExists(SitesRank::Table) === false) {
			$this->createTable(SitesRank::Table, [
				'id' => $this->primaryKey(),
				'siteId' => $this->integer(),
				'rank' => $this->integer(),
			]);

			$this->createIndex(null, SitesRank::Table, ['siteId'], false);
			$this->addForeignKey(null, SitesRank::Table, ['siteId'], Table::SITES, ['id'], null);
		}
    }

    /**
     * @inheritdoc
     */
    public function safeDown()
    {
        echo "m201225_101645_sites_rank cannot be reverted.\n";
        return false;
    }
}
