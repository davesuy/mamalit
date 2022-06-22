<?php

namespace modules\depotisemodule\controllers;

use craft\commerce\elements\Product;
use craft\commerce\elements\Variant;
use function Arrayy\create;
use Craft;
use craft\commerce\Plugin;
use craft\elements\Asset;
use craft\elements\Category;
use craft\elements\Entry;
use craft\helpers\ArrayHelper;
use craft\web\Controller;
use modules\depotisemodule\DepotiseModule;

class ProductController extends Controller
{

	protected $allowAnonymous = ['get-product', 'get-categories', 'get-auto-suggest'];

	public function actionGetProduct()
	{
		$id = Craft::$app->request->getBodyParam('productId');
		$siteId = Craft::$app->request->getBodyParam('siteId');

		Craft::$app->sites->setCurrentSite($siteId);


		$product = Plugin::getInstance()->getProducts()->getProductById($id);

		$variants = DepotiseModule::$app->product->normalizeVariants($product->getVariants());

		return $this->asJson([
			'variants' => ['items' => $variants, 'selected' => (int) $product->defaultVariant->id ]
		]);
	}

	public function actionGetCategories()
	{
		$categorySlug = Craft::$app->request->getBodyParam('categorySlug');

		$elements = null;
		$find = Category::find()->group('productCategories');

		if ($categorySlug !== null && $categorySlug !== 'products') {

			$currentCategory = $find->slug($categorySlug)->one();

			if ($currentCategory) {
				$elements = $currentCategory->getChildren()->all();
			}
		}

		$elements = $elements ?? $find->level(1)->all();

		$categories = ArrayHelper::toArray($elements, [
			Category::class => [
				'id' => function($item) {
					return (int) $item->id;
				}, 'title', 'uri'
			]
		]);


		return $this->asJson($categories);
	}

	public function getCategoryTree($categories, array &$tree)
	{
		foreach ($categories as $category) {

			$tree[$category->slug] = $category;

			$children = $category->getChildren();

			if ($children) {
				$tree[$category->slug]['children'] = $children;

				$this->getCategoryTree($children, $tree);
			}
		}

		return $tree;
	}

	public function actionGetAutoSuggest()
	{
		$items = Entry::find()->section('suggest')->select('title')->column();

		return $this->asJson(['items' => $items]);
	}

	public function actionGetBundleSuggest()
	{
		$items = Entry::find()->section('bundles')->select('title')->column();

		return $this->asJson(['items' => $items]);
	}
}
