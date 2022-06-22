<?php

namespace modules\depotisemodule\services;

use craft\base\Component;
use craft\commerce\elements\Order;
use Craft;
use craft\commerce\models\OrderAdjustment;
use craft\commerce\Plugin;
use craft\db\Query;
use craft\models\Site;
use modules\depotisemodule\DepotiseModule;
use modules\depotisemodule\elements\MultipleOrder;
use yii\web\ForbiddenHttpException;

class Orders extends Component
{
	public function setCurrentSiteIfAuthorize(int $orderId)
	{
		$siteIds = Craft::$app->elements->getEnabledSiteIdsForElement($orderId);

		if (count($siteIds) > 0) {
			$site = Craft::$app->sites->getSiteById($siteIds[0]);

			if (!Craft::$app->getUser()->checkPermission('editSite:' . $site->uid)) {
				throw new ForbiddenHttpException('User is not permitted to perform this action');
			}

			Craft::$app->sites->setCurrentSite($siteIds[0]);
		}
	}

	public function getOrderBySiteId(int $id, int $siteId = null)
	{
		if (!$id) {
			return null;
		}

		$query = Order::find();
		$query->id($id);

		if ($siteId !== null) {
			$query->siteId($siteId);
		}

		$query->status(null);

		return $query->one();
	}

	public function cartOrder($siteId, $number,  $lineItemsOnly)
	{
		$order['site']  = Craft::$app->sites->getSiteById($siteId)->toArray();

		Craft::$app->sites->setCurrentSite($siteId);

		$getCart = new \craft\commerce\services\Carts();

		$element = $getCart->getCart();

		//$element = Order::find()->siteId($siteId)->number($number)->one();

		if ($lineItemsOnly === true && count($element->lineItems) === 0) return null;

		return DepotiseModule::$app->carts->cartArray($element);
	}

	public function getMultipleOrderByCustomerId($customerId, $id)
	{
		return MultipleOrder::find()->id($id)->customerId($customerId)->completed(1)->one();
	}

	public function getLatestMultipleOrderByCustomerId($customerId)
	{
		return MultipleOrder::find()->customerId($customerId)->completed(1)->orderBy('id DESC')->one();
	}

	public function getCustomerOrderCount($customerId)
	{
		return MultipleOrder::find()->customerId($customerId)->completed(1)->orderBy('id DESC')->count();
	}

	public function getMultipleOrdersByCustomerId($customerId)
	{
		$response = [];

		$qty = 0;

		$multipleOrders = MultipleOrder::find()->customerId($customerId)->completed(1)->all();

		if (count($multipleOrders) > 0) {
			/**
			 * @var MultipleOrder $multipleOrder
			 */
			foreach ($multipleOrders as $key => $multipleOrder) {

				$response[$key] = $multipleOrder->toArray();

				$orders = $multipleOrder->getChildOrders();
				$stores = [];
				if (count($orders) > 0) {
					$total = 0;
					foreach ($orders as $oKey => $order) {

						$siteRecord = \craft\records\Site::findWithTrashed()->where(['id' => $order->siteId])->one();
						$siteModel = new Site();
						$siteModel->setAttributes($siteRecord->getAttributes(), false);

						Craft::$app->sites->setCurrentSite($siteModel);

						$response[$key]['orders'][$oKey] = $order->toArray();

						$total+= $order->getTotal();
						$qty+= $order->getTotalQty();

						$stores[] = $siteModel->name;
					}
				}

				if (count($stores) > 0) {

					$response[$key]['stores'] = implode(', ', $stores);
				}

				$response[$key]['total'] = $total;
				$response[$key]['qty'] = $qty;
			}
		}



		return $response;
	}

	public function purgeOrphanedMultipleOrders()
	{
		$cartIds = (new Query())->select(['m.id as mid'])
			->from(['m' => \modules\depotisemodule\records\MultipleOrder::Table])
			->leftJoin(['o' => \craft\commerce\db\Table::ORDERS], '[[m.id]] = [[o.multipleOrderId]]')
			->where(['o.id' => null])
			->column();

		Craft::$app->getDb()->createCommand()
			->delete('{{%elements}}', ['id' => $cartIds])
			->execute();

		// The searchindex table is probably MyISAM, though
		Craft::$app->getDb()->createCommand()
			->delete('{{%searchindex}}', ['elementId' => $cartIds])
			->execute();
	}
}
