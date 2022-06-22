<?php

namespace craft\contentmigrations;

use Craft;
use craft\db\Migration;

/**
 * m200425_064840_depotise_social migration.
 */
class m200425_064840_depotise_social extends Migration
{
	// Public Properties
	// =========================================================================

	/**
	 * @var string The database driver to use
	 */
	public $driver;

	// Public Methods
	// =========================================================================

	/**
	 * This method contains the logic to be executed when applying this migration.
	 * This method differs from [[up()]] in that the DB logic implemented here will
	 * be enclosed within a DB transaction.
	 * Child classes may implement this method instead of [[up()]] if the DB logic
	 * needs to be within a transaction.
	 *
	 * @return boolean return a false value to indicate the migration fails
	 * and should not proceed further. All other return values mean the migration succeeds.
	 */
	public function safeUp()
	{
		if ($this->getDb()->tableExists('{{%depotise_social_login_accounts}}') === true) return true;

		$this->driver = Craft::$app->getConfig()->getDb()->driver;
		$this->createTables();
		$this->createIndexes();
		$this->addForeignKeys();
		$this->insertDefaultData();

		return true;
	}

	/**
	 * This method contains the logic to be executed when removing this migration.
	 * This method differs from [[down()]] in that the DB logic implemented here will
	 * be enclosed within a DB transaction.
	 * Child classes may implement this method instead of [[down()]] if the DB logic
	 * needs to be within a transaction.
	 *
	 * @return boolean return a false value to indicate the migration fails
	 * and should not proceed further. All other return values mean the migration succeeds.
	 */
	public function safeDown()
	{
		$this->driver = Craft::$app->getConfig()->getDb()->driver;
		$this->removeIndexes();
		$this->removeTables();

		return true;
	}

	// Protected Methods
	// =========================================================================

	/**
	 * Creates the tables needed for the Records used by the plugin
	 *
	 * @return void
	 */
	protected function createTables()
	{
		$this->createTable(
			'{{%depotise_social_login_accounts}}',
			[
				'id' => $this->integer()->notNull(),
				'userId' => $this->integer()->notNull(),
				'providerHandle' => $this->string(255)->notNull(),
				'socialUid' => $this->string(255)->notNull(),

				'dateCreated' => $this->dateTime()->notNull(),
				'dateUpdated' => $this->dateTime()->notNull(),
				'uid' => $this->uid(),
				'PRIMARY KEY(id)',
			]
		);
	}

	/**
	 * Creates the indexes needed for the Records used by the plugin
	 *
	 * @return void
	 */
	protected function createIndexes()
	{
	}

	/**
	 * Creates the foreign keys needed for the Records used by the plugin
	 *
	 * @return void
	 */
	protected function addForeignKeys()
	{
		$this->addForeignKey($this->db->getForeignKeyName('{{%depotise_social_login_accounts}}', 'id'), '{{%depotise_social_login_accounts}}', 'id', '{{%elements}}', 'id', 'CASCADE', null);
		$this->addForeignKey($this->db->getForeignKeyName('{{%depotise_social_login_accounts}}', 'userId'), '{{%depotise_social_login_accounts}}', 'userId', '{{%users}}', 'id', 'CASCADE', null);
	}

	/**
	 * Populates the DB with the default data.
	 *
	 * @return void
	 */
	protected function insertDefaultData()
	{
	}

	/**
	 * Removes the tables needed for the Records used by the plugin
	 *
	 * @return void
	 */
	protected function removeTables()
	{
		$this->dropTable('{{%depotise_social_login_accounts}}');
	}

	/**
	 * Removes the indexes needed for the Records used by the plugin
	 *
	 * @return void
	 */
	protected function removeIndexes()
	{
	}
}
