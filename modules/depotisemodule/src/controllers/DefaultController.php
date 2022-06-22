<?php
/**
 * Depotise module for Craft CMS 3.x
 *
 * online hardware shop
 *
 * @link      https://github.com/pdaleramirez
 * @copyright Copyright (c) 2020 Dale
 */

namespace modules\depotisemodule\controllers;

use craft\base\Field;
use craft\commerce\base\Gateway;
use craft\commerce\elements\Order;
use craft\commerce\elements\Product;
use craft\commerce\elements\Variant;
use craft\commerce\Plugin;
use craft\commerce\services\Carts;
use craft\db\Paginator;
use craft\db\Query;
use craft\elements\Category;
use craft\elements\db\AssetQuery;
use craft\elements\Entry;
use craft\elements\User;
use craft\helpers\ArrayHelper;
use modules\depotisemodule\DepotiseModule;

use Craft;
use craft\web\Controller;
use modules\depotisemodule\records\MultipleOrder;
use NumberFormatter;


/**
 * Default Controller
 *
 * Generally speaking, controllers are the middlemen between the front end of
 * the CP/website and your module’s services. They contain action methods which
 * handle individual tasks.
 *
 * A common pattern used throughout Craft involves a controller action gathering
 * post data, saving it on a model, passing the model off to a service, and then
 * responding to the request appropriately depending on the service method’s response.
 *
 * Action methods begin with the prefix “action”, followed by a description of what
 * the method does (for example, actionSaveIngredient()).
 *
 * https://craftcms.com/docs/plugins/controllers
 *
 * @author    Dale
 * @package   DepotiseModule
 * @since     1.0.0
 */
class DefaultController extends Controller
{

	// Protected Properties
	// =========================================================================

	/**
	 * @var    bool|array Allows anonymous access to this controller's actions.
	 *         The actions must be in 'kebab-case'
	 * @access protected
	 */
	protected $allowAnonymous = ['index', 'do-something', 'forget-cart'];

	// Public Methods
	// =========================================================================

	/**
	 * Handle a request going to our module's index action URL,
	 * e.g.: actions/depotise-module/default
	 *
	 * @return mixed
	 */
	public function actionIndex()
	{
		$result = 'Welcome to the DefaultController actionIndex() method';

		return $result;
	}

	/**
	 * Handle a request going to our module's actionDoSomething URL,
	 * e.g.: actions/depotise-module/default/do-something
	 *
	 * @return mixed
	 */
	public function actionTestAction()
	{
		$products = Product::find()->site('*')->type('products')->limit(2)->all();

		Craft::dd($products);
		Craft::dd('vasd');
	}

	public function sendMail(string $html, string $subject, $mail): bool
	{
		return Craft::$app
			->getMailer()
			->compose()
			->setTo($mail)
			->setSubject($subject)
			->setHtmlBody($html)
			->send();
	}

	public function getEmailTemplate()
	{
		$order  = Plugin::getInstance()->getOrders()->getOrderById(37678);
		Craft::$app->getView()->setTemplatesPath(Craft::$app->path->getSiteTemplatesPath());

		return $this->renderTemplate('shop/_emails/customer_order_received', [
			'order' => $order
		]);
	}

	public function actionForgetCart()
	{
		DepotiseModule::$app->carts->forgetCart();
	}

	public function actionCart()
	{
		$multipleOrderCart = DepotiseModule::$app->carts->getCart();

		$activeOrders = $multipleOrderCart->getActiveOrders();

		$orders = [];
		if (count($activeOrders) > 0) {
			foreach ($activeOrders as $activeOrder) {
				$number = $activeOrder['number'];
				$siteId = $activeOrder['site'];

				//$element = Order::find()->siteId($siteId)->number($number)->one();

				$orders[$siteId]['site'] = Craft::$app->sites->getSiteById($siteId)->toArray();

				$element = Order::find()->siteId($siteId)->number($number)->one();
				$orders[$siteId]['order'] = $element;

				//$orders[$siteId]['order']['lineItems'] = $element->lineItems;
			}
		}

		return $this->renderTemplate('test');
	}
}
