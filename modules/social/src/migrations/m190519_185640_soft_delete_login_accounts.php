<?php

namespace modules\social\migrations;

use Craft;
use craft\db\Migration;
use craft\db\Query;
use craft\helpers\DateTimeHelper;
use craft\helpers\Db;
use modules\social\elements\LoginAccount;

/**
 * m190519_185640_soft_delete_login_accounts migration.
 */
class m190519_185640_soft_delete_login_accounts extends Migration
{
    /**
     * @inheritdoc
     */
    public function safeUp()
    {
        // List login accounts from trashed users
        $results = (new Query())
            ->select(['depotise_social_login_accounts.id', 'depotise_social_login_accounts.userId'])
            ->from(['{{%depotise_social_login_accounts}} depotise_social_login_accounts'])
            ->leftJoin('{{%elements}} userElements', '[[userElements.id]] = [[depotise_social_login_accounts.userId]]')
            ->leftJoin('{{%elements}} loginAccountElements', '[[loginAccountElements.id]] = [[depotise_social_login_accounts.userId]]')
            ->where('userElements.dateDeleted IS NOT NULL')
            ->all();

        // Set each login account element as trashed
        $date = DateTimeHelper::currentUTCDateTime();
        $dbDate = Db::prepareDateForDb($date);

        foreach ($results as $result) {
            $this->update('{{%elements}}', [
                'dateDeleted' => $dbDate
            ], ['id' => $result['id']]);
        }

        return true;
    }

    /**
     * @inheritdoc
     */
    public function safeDown()
    {
        echo "m190519_185640_soft_delete_login_accounts cannot be reverted.\n";
        return false;
    }
}
