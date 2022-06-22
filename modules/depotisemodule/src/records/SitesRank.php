<?php
namespace modules\depotisemodule\records;

use craft\db\ActiveRecord;

class SitesRank extends ActiveRecord
{
	const Table = '{{%sites_rank}}';

	public static function tableName(): string
	{
		return static::Table;
	}
}
