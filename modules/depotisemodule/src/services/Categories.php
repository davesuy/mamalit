<?php
namespace modules\depotisemodule\services;

use Craft;
use craft\base\Component;
use craft\elements\Category;

class Categories extends Component
{
	private $level = 1;
	private $handle = 'productCategories';

	public function getCategoryTree($categories)
	{
		//if ($this->level >= 3) return null;

		$tree = [];

		foreach ($categories as $key => $category) {

			$tree[$key]['title'] = $category->title;
			$tree[$key]['uri']   = $category->uri;
			$tree[$key]['slug']  = $category->slug;
			/**
			 * @var Category $category
			 */
			$children = $category->getChildren()->all();

			if (count($children) > 0) {
				$tree[$key]['children'] = $this->getCategoryTree($children);
			}
		}

		//$this->level++;
		return $tree;
	}

	/**
	 * @return array|\craft\base\ElementInterface|Category|null
	 */
	public function getCurrentCategory()
	{
		$slug = Craft::$app->request->getSegment(-1);

		if ($slug !== 'products') {
			return Category::find()->slug($slug)->group($this->handle)->one();
		}

		return null;
	}

	public function getCurrentBundle()
	{
		$slug = Craft::$app->request->getSegment(-1);

		if ($slug !== 'bundles') {
			return Category::find()->slug($slug)->group('bundles')->one();
		}

		return null;
	}
}
