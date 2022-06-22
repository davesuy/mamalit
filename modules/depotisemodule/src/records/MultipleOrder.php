<?php
namespace modules\depotisemodule\records;

use Craft;
use craft\commerce\records\Order;
use craft\db\ActiveRecord;
use yii\db\ActiveQueryInterface;

class MultipleOrder extends ActiveRecord
{
	const Table = '{{%multiple_orders}}';

	public static function tableName(): string
	{
		return static::Table;
	}

	public function getOrders(): ActiveQueryInterface
	{
		return $this->hasMany(Order::class, ['multipleOrderId' => 'id'])->innerJoin('{{%elements}} elements', '[[elements.id]] = [[commerce_orders.id]]');
	}

	/**
	 * @return array
	 */
	public function getActiveOrders()
	{
		return $this->getOrders()
			->where(['isCompleted' => false])
			->andWhere(['dateDeleted' => null])
			->andWhere(['!=', 'itemTotal', 0])->all();
	}
}
