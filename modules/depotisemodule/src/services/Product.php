<?php

namespace modules\depotisemodule\services;

use craft\base\Component;
use craft\commerce\elements\Order;
use Craft;
use craft\commerce\elements\Variant;
use craft\commerce\models\OrderAdjustment;
use craft\commerce\Plugin;
use craft\elements\Asset;
use yii\web\ForbiddenHttpException;

class Product extends Component
{
	public function normalizeVariants(array $variants)
	{
		$currency  = Plugin::getInstance()->getPaymentCurrencies()->getPrimaryPaymentCurrency();

		$variants = array_map(function ($item) use ($currency) {

			$price = Craft::$app->getFormatter()->asCurrency($item->price, $currency);

			$item->id    = (int) $item->id;
			$item->price = $price;
			$item->stock = (int) $item->stock;
			$item->hasUnlimitedStock = (boolean) $item->hasUnlimitedStock;

			/**
			 * @var Asset[] $productImages
			 */
			$productImages = $item->productImages->all();
			$images = [];
			if (count($productImages) > 0) {
				foreach ($productImages as $key => $image) {
					$images[$key]['url']   = $image->getUrl('grid');
					$images[$key]['title'] = $image->title;
				}
			}
			$item->productImages = $images;

			return $item;
		}, $variants);

		return $variants;
	}
}
