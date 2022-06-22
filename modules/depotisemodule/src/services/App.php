<?php
/**
 * Depotise module for Craft CMS 3.x
 *
 * online hardware shop
 *
 * @link      https://github.com/pdaleramirez
 * @copyright Copyright (c) 2020 Dale
 */

namespace modules\depotisemodule\services;

use craft\base\Component;
use Craft;
use craft\commerce\elements\Order;
use craft\commerce\Plugin;
use craft\helpers\ArrayHelper;
use craft\helpers\Html;
use craft\helpers\Template;

/**
 * DepotiseModuleService Service
 *
 * All of your module’s business logic should go in services, including saving data,
 * retrieving data, etc. They provide APIs that your controllers, template variables,
 * and other modules can interact with.
 *
 * https://craftcms.com/docs/plugins/services

 * @property Carts $carts
 * @property Orders $orders
 * @property Categories $categories
 * @property Product $product
 * @author    Dale
 * @package   DepotiseModule
 * @since     1.0.0
 */
class App extends Component
{

	public $carts;
	public $orders;
	public $categories;
	public $product;

    public function init()
    {
       $this->carts  = new Carts();
       $this->orders = new Orders();
       $this->categories = new Categories();
       $this->product = new Product();
    }

    public function getSelectedSiteByAccess()
	{
		$siteIds = Craft::$app->sites->getEditableSiteIds();

		$siteId = $siteIds[0];

		if (($paramSiteId = Craft::$app->request->getParam('site')) !== null) {
			$siteId = $paramSiteId;
		}

		Craft::$app->sites->setCurrentSite($siteId);

		return $siteId;
	}

	private function getEndReferrer()
	{
		$referrer = Craft::$app->request->getReferrer();
		$linkArray = explode('/',$referrer);
		return end($linkArray);
	}

	public function getSiteIdByReferrer()
	{
		$siteHandle = $this->getEndReferrer();

		$site = Craft::$app->sites->getSiteByHandle($siteHandle);
		if ($site !== null) {
			return $site->id;
		}

		return null;
	}

	public function getSiteIdByReferrerOrder()
	{
		$orderId = $this->getEndReferrer();

		$sites = Craft::$app->getElements()->getEnabledSiteIdsForElement($orderId);

		if (count($sites)) {
			return $sites[0];
		}

		return null;
	}

	/**
	 * @return bool
	 * @throws \craft\errors\SiteNotFoundException
	 */
	public function isPrimarySite()
	{
		$primarySite = Craft::$app->sites->getPrimarySite();

		$currentSite = Craft::$app->sites->getCurrentSite();

		return $primarySite->id === $currentSite->id;
	}

	/**
	 * @param $value
	 * @return \Twig\Markup
	 * @throws \craft\errors\SiteNotFoundException
	 * @throws \yii\base\Exception
	 * @throws \yii\base\InvalidConfigException
	 */
	public function redirectInput($value)
	{
		$slash = $this->isPrimarySite() === true ? '/' : 'shop/';

		return Template::raw(Html::redirectInput($slash . $value));
	}

	public function testMethod()
	{

	}

	public function getProvinces()
	{
		$country = Plugin::getInstance()->countries->getCountryByIso('PH');

		$states = Plugin::getInstance()->states->getStatesByCountryId($country->id);

		return array_values(ArrayHelper::where($states, 'enabled', 1));
	}

	public function getPrimaryCurrencySymbol()
	{
		$primaryCurrency = Plugin::getInstance()->getPaymentCurrencies()->getPrimaryPaymentCurrency();

		return Craft::$app->getLocale()->getCurrencySymbol($primaryCurrency);
	}

	public function getVueId()
	{
		if (Craft::$app->request->getSegment(1) === 'products' || Craft::$app->request->getSegment(1) === 'bundles') {
			return "search-app";
		} elseif (Craft::$app->request->getSegment(2) === 'addresses') {
			return "address-app";
		}

		return "app";
	}

	public function getPostCodes()
	{
		return [
			6015 => 'Lapu-Lapu',
			6017 => 'Cordova'
		];
	}

	public function getPostCode($code)
	{
		$posts = $this->getPostCodes();

		return $posts[$code] ?? '';
	}

	function mix($path, $manifestDirectory = '')
	{
		static $manifest;
		$publicFolder = '/';
		$rootPath = $_SERVER['DOCUMENT_ROOT'];
		$publicPath = $rootPath . $publicFolder;

		if ($manifestDirectory && strpos($manifestDirectory, '/') !== 0) {
			$manifestDirectory = "/{$manifestDirectory}";
		}

		if (!$manifest) {
			if (! file_exists($manifestPath = ($rootPath . $manifestDirectory.'/mix-manifest.json') )) {
				throw new \Exception('The Mix manifest does not exist.');
			}
			$manifest = json_decode(file_get_contents($manifestPath), true);
		}

		return $manifest;
	}
}
