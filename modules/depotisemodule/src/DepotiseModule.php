<?php
/**
 * Depotise module for Craft CMS 3.x
 *
 * online hardware shop
 *
 * @link      https://github.com/pdaleramirez
 * @copyright Copyright (c) 2020 Dale
 */

namespace modules\depotisemodule;

use craft\base\Model;
use craft\commerce\controllers\BaseFrontEndController;
use craft\commerce\elements\db\ProductQuery;
use craft\commerce\elements\Order;
use craft\commerce\elements\Product;
use craft\commerce\elements\Variant;
use craft\commerce\events\AddLineItemEvent;
use craft\commerce\events\LineItemEvent;
use craft\commerce\events\ModifyCartInfoEvent;
use craft\commerce\models\LineItem;
use craft\commerce\Plugin;
use craft\commerce\records\Order as OrderRecord;
use craft\commerce\services\LineItems;
use craft\db\Table;
use craft\elements\Asset;
use craft\elements\Category;
use craft\events\DefineRulesEvent;
use craft\events\ModelEvent;
use craft\events\RegisterCpNavItemsEvent;
use craft\events\RegisterElementSearchableAttributesEvent;
use craft\helpers\ArrayHelper;
use craft\services\Gc;
use craft\web\twig\variables\Cp;
use Exception;
use modules\depotisemodule\assetbundles\depotisemodule\DepotiseModuleAsset;
use modules\depotisemodule\gateways\Paymongo;
use modules\depotisemodule\records\SitesRank;
use modules\depotisemodule\services\App;
use modules\depotisemodule\services\Carts;
use modules\depotisemodule\services\DepotiseModuleService as DepotiseModuleServiceService;
use modules\depotisemodule\web\twig\variables\DepotiseModuleVariable;
use modules\depotisemodule\twigextensions\DepotiseModuleTwigExtension;
use Craft;
use craft\events\RegisterTemplateRootsEvent;
use craft\events\TemplateEvent;
use craft\i18n\PhpMessageSource;
use craft\web\View;
use craft\web\UrlManager;
use craft\web\twig\variables\CraftVariable;
use craft\events\RegisterUrlRulesEvent;
use pdaleramirez\superfilter\events\ElementQueryEvent;
use pdaleramirez\superfilter\events\ItemArrayEvent;
use pdaleramirez\superfilter\services\SearchTypes;
use yii\base\Event;
use yii\base\InvalidConfigException;
use yii\base\Module;
use craft\commerce\services\Gateways;
use craft\events\RegisterComponentTypesEvent;
use yii\validators\Validator;
use yii\web\User;

/**
 * Craft plugins are very much like little applications in and of themselves. We’ve made
 * it as simple as we can, but the training wheels are off. A little prior knowledge is
 * going to be required to write a plugin.
 *
 * For the purposes of the plugin docs, we’re going to assume that you know PHP and SQL,
 * as well as some semi-advanced concepts like object-oriented programming and PHP namespaces.
 *
 * https://craftcms.com/docs/plugins/introduction
 *
 * @author    Dale
 * @package   DepotiseModule
 * @since     1.0.0
 *
 * @property  DepotiseModuleServiceService $depotiseModuleService
 */
class DepotiseModule extends Module
{
	// Static Properties
	// =========================================================================

	/**
	 * Static property that is an instance of this module class so that it can be accessed via
	 * DepotiseModule::$instance
	 *
	 * @var DepotiseModule
	 */
	public static $instance;

	/**
	 * @var App
	 */
	public static $app;

	// Public Methods
	// =========================================================================

	/**
	 * @inheritdoc
	 */
	public function __construct($id, $parent = null, array $config = [])
	{
		// Translation category
		$i18n = Craft::$app->getI18n();
		/** @noinspection UnSafeIsSetOverArrayInspection */
		if (!isset($i18n->translations[$id]) && !isset($i18n->translations[$id . '*'])) {
			$i18n->translations[$id] = [
				'class' => PhpMessageSource::class,
				'sourceLanguage' => 'en-US',
				'basePath' => '@depotisemodule/translations',
				'forceTranslation' => true,
				'allowOverrides' => true,
			];
		}

		// Base template directory
		Event::on(View::class, View::EVENT_REGISTER_CP_TEMPLATE_ROOTS, function (RegisterTemplateRootsEvent $e) {
			if (is_dir($baseDir = $this->getBasePath() . DIRECTORY_SEPARATOR . 'templates')) {
				$e->roots[$this->id] = $baseDir;
			}
		});

		// Set this as the global instance of this module class
		static::setInstance($this);

		parent::__construct($id, $parent, $config);
	}

	/**
	 * Set our $instance static property to this class so that it can be accessed via
	 * DepotiseModule::$instance
	 *
	 * Called after the module class is instantiated; do any one-time initialization
	 * here such as hooks and events.
	 *
	 * If you have a '/vendor/autoload.php' file, it will be loaded for you automatically;
	 * you do not need to load it in your init() method.
	 *
	 */
	public function init()
	{
		Craft::setAlias('@depotisemodule', $this->getBasePath());
		Craft::setAlias('@modules', __DIR__);
		// Set the controllerNamespace based on whether this is a console or web request
		if (Craft::$app->getRequest()->getIsConsoleRequest()) {
			$this->controllerNamespace = 'modules\\depotisemodule\\console\\controllers';
		} else {
			$this->controllerNamespace = 'modules\\depotisemodule\\controllers';
		}

		parent::init();
		self::$instance = $this;

		$this->setComponents([
			'app' => App::class
		]);

		self::$app = $this->get('app');

		// Load our AssetBundle
		if (Craft::$app->getRequest()->getIsCpRequest()) {
			Event::on(
				View::class,
				View::EVENT_BEFORE_RENDER_TEMPLATE,
				function (TemplateEvent $event) {
					try {
						Craft::$app->getView()->registerAssetBundle(DepotiseModuleAsset::class);
					} catch (InvalidConfigException $e) {
						Craft::error(
							'Error registering AssetBundle - ' . $e->getMessage(),
							__METHOD__
						);
					}
				}
			);
		}

		// Add in our Twig extensions
		Craft::$app->view->registerTwigExtension(new DepotiseModuleTwigExtension());

		// Register our site routes
		Event::on(
			UrlManager::class,
			UrlManager::EVENT_REGISTER_SITE_URL_RULES,
			function (RegisterUrlRulesEvent $event) {
				$event->rules['siteActionTrigger1'] = 'depotise-module/default';
				$event->rules['multiple-cart'] = 'depotise-module/cart/get-multiple-cart';
				$event->rules['multiple-cart-shipping'] = 'depotise-module/cart/get-multiple-cart-shipping';
				//$event->rules['cart'] = 'depotise-module/cart/get-cart';

				$event->rules['product'] = 'depotise-module/product/get-product';
				$event->rules['product-categories'] = 'depotise-module/product/get-categories';
				$event->rules['forget-cart'] = 'depotise-module/default/forget-cart';
			}
		);

		// Register our CP routes
		Event::on(
			UrlManager::class,
			UrlManager::EVENT_REGISTER_CP_URL_RULES,
			function (RegisterUrlRulesEvent $event) {
				$event->rules['test-action'] = 'depotise-module/default/test-action';
			}

		);

		// Register our variables
		Event::on(
			CraftVariable::class,
			CraftVariable::EVENT_INIT,
			function (Event $event) {
				/** @var CraftVariable $variable */
				$variable = $event->sender;
				$variable->set('depotiseModule', DepotiseModuleVariable::class);
			}
		);

		Event::on(Asset::class, Asset::EVENT_REGISTER_SEARCHABLE_ATTRIBUTES, function (RegisterElementSearchableAttributesEvent $e) {
			$e->attributes = [];
		});


		Event::on(Asset::class, Asset::EVENT_BEFORE_SAVE, function (ModelEvent $event) {

			$siteId = DepotiseModule::$app->getSiteIdByReferrer();

			if ($siteId !== null) {
				$element = $event->sender;

				$element->siteId = $siteId;
			}
		});

		Event::on(Order::class, Order::EVENT_AFTER_SAVE, function (ModelEvent $event) {
			/**
			 * @var Order $order
			 */
			$order = $event->sender;
			$orderRecord = OrderRecord::findOne($order->id);

			if ($orderRecord->multipleOrderId === null) {
				$multipleOrder = DepotiseModule::$app->carts->getCart();

				$orderRecord->link('multipleOrder', $multipleOrder->getRecord());
			}
		});

		Event::on(SearchTypes::class, SearchTypes::EVENT_ITEM_ARRAY, function (ItemArrayEvent $event) {
			$site = Craft::$app->sites->getSiteById($event->element->siteId);

			if ($site === null) {
				return null;
			}
			$event->item['siteName'] = $site->name;
			$event->item['siteHandle'] = $site->handle;
			$event->item['siteBaseUrl'] = $site->getBaseUrl();


			/**
			 * @var Product $product
			 */
			$product = $event->element;

			if ($product instanceof Product) {
				$itemVariants = [
					'items' => DepotiseModule::$app->product->normalizeVariants($product->getVariants()),
					'selected' => (int)$product->defaultVariant->id
				];

				$event->item['productVariants'] = $itemVariants;
				$event->item['firstVariantImage'] = null;
				if (count($itemVariants['items']) > 0) {

					$images = $itemVariants['items'][0]->productImages;
					if (count($images) > 0) {
						$event->item['firstVariantImage'] = $images[0];
					}

					$event->item['defaultPriceAsCurrency'] = $itemVariants['items'][0]->price;
				}
			}

			/** @var Category $category */
			$category = $event->element;

			if ($category instanceof Category) {
				/**
				 * @var Asset[] $productImages
				 */
				$asset = $category->categoryImage->one();

				if ($asset !== null) {
					$image['url'] = $asset->getUrl('grid');
					$image['title'] = $asset->title;

					$event->item['categoryImage'] = $image;
				}
				$event->item['slug'] = $category->slug;
			}

		});

		Event::on(SearchTypes::class, SearchTypes::EVENT_ELEMENT_QUERY, function (ElementQueryEvent $event) {
			/**
			 * @var ProductQuery $productQuery
			 */
			$productQuery = $event->query;
			if ($productQuery instanceof ProductQuery) {
				$event->query->andWhere(['<>', 'elements_sites.siteId', Craft::$app->sites->getPrimarySite()->id])
					->leftJoin(['sites' => Table::SITES], '[[sites.id]] = [[elements_sites.siteId]]')
					->andWhere(['sites.dateDeleted' => null]);

				if (Craft::$app->getRequest()->getSegment(2) === 'filter') {
					$event->query
						->leftJoin(['r' => SitesRank::Table], '[[r.siteId]] = [[elements_sites.siteId]]')
						->orderBy('r.rank DESC');

					$event->query->addOrderBy([$event->searchType->sortParam['attribute'] => $event->searchType->sortParam['sort']]);
				}
			}
		});

		Event::on(Carts::class, BaseFrontEndController::EVENT_MODIFY_CART_INFO, function (ModifyCartInfoEvent $event) {

			$event->cartInfo['lineItems'] = array_map(function ($value) {
				$value['remove'] = null;
				return $value;
			}, $event->cartInfo['lineItems']);

		});

		Event::on(BaseFrontEndController::class, BaseFrontEndController::EVENT_MODIFY_CART_INFO, function (ModifyCartInfoEvent $event) {

			$event->cartInfo['lineItems'] = array_map(function ($value) {
				$value['remove'] = null;

				return $value;
			}, $event->cartInfo['lineItems']);

		});

		Event::on(Gateways::class, Gateways::EVENT_REGISTER_GATEWAY_TYPES, function (RegisterComponentTypesEvent $event) {
			$event->types[] = Paymongo::class;
		});


		Event::on(UrlManager::class, UrlManager::EVENT_REGISTER_CP_URL_RULES, function (RegisterUrlRulesEvent $event) {

			$event->rules['depotise-module/multiple-order/edit/<multipleOrderId:\d+|new>'] = 'depotise-module/order/edit-multiple-order';
			$event->rules['depotise-module/multiple-order/receipt/<multipleOrderId:\d+|new>'] = 'depotise-module/order/receipt-multiple-order';
			$event->rules['depotise-module/sites'] = 'depotise-module/sites/settings-index';

		});
		Event::on(
			Cp::class,
			Cp::EVENT_REGISTER_CP_NAV_ITEMS,
			function (RegisterCpNavItemsEvent $event) {
				$isAdmin = \Craft::$app->getUser()->getIsAdmin();

				if ($isAdmin === true) {
					$event->navItems[] = [
						'url' => 'depotise-module/multiple-order',
						'label' => Craft::t('depotise-module', 'Multiple Order')
					];
					$event->navItems[] = [
						'url' => 'settings/sites',
						'label' => Craft::t('depotise-module', 'Sites')
					];

					$event->navItems[] = [
						'url' => 'entries/suggest',
						'label' => Craft::t('depotise-module', 'Auto Suggest')
					];
				}
			}
		);

		Event::on(User::class, User::EVENT_AFTER_LOGIN, [static::$app->carts, 'onLoginRestoreUserCart']);

		Event::on(Gc::class, Gc::EVENT_RUN, function () {
			DepotiseModule::$app->orders->purgeOrphanedMultipleOrders();
		});




		Event::on(
			Order::class,
			Order::EVENT_BEFORE_ADD_LINE_ITEM,
			function (AddLineItemEvent $event) {

				$siteCart = DepotiseModule::$app->carts->getCart();

				$variant = $event->lineItem->getPurchasable();

				if ($siteCart->hasPromo === '1') {
					if (in_array($variant->product->id, $this->getPromoVariants()) === true) {
						$event->lineItem->note = 'is-promo';
					}
				} else {

					if ($event->lineItem->qty <= $event->lineItem->purchasable->maxQty && in_array($variant->product->id, $this->getPromoVariants()) === true) {
						$siteCart->hasPromo = 1;

						Craft::$app->getElements()->saveElement($siteCart);
					}
				}
			}
		);

		Event::on(
			Order::class,
			Order::EVENT_AFTER_REMOVE_LINE_ITEM,
			function (LineItemEvent $event) {
				$siteCart = DepotiseModule::$app->carts->getCart();

				if ($siteCart->hasPromo === '1') {
					/** @var Variant $variant */
					$variant = $event->lineItem->getPurchasable();

					if (in_array($variant->product->id, $this->getPromoVariants()) === true) {
						$siteCart->hasPromo = 0;

						Craft::$app->getElements()->saveElement($siteCart);
					}
				}

			}
		);

		Event::on(
			LineItem::class,
			Model::EVENT_DEFINE_RULES,
			function (DefineRulesEvent $event) {
				$rules = $event->rules;
				/** @var LineItem $lineItem */
				$lineItem = $event->sender;

				$rules[] =
					['purchasableId', function($attribute, $params, Validator $validator) use ($lineItem) {

						/** @var Variant $variant */
						$variant = $lineItem->getPurchasable();

						if ($variant !== null) {

							if ($lineItem->note === 'is-promo') {
								$validator->addError($lineItem, $attribute, Plugin::t('You can only add one promo in the cart.'));
							}
						}
					}];

				$event->rules = $rules;
			}
		);
	}

	public function getPromoVariants()
	{
		$promo = Category::find()->slug('promo')->one();
		$products = Product::find()->relatedTo($promo)->site('*')->all();

		return ArrayHelper::getColumn($products, 'id');
	}
}
