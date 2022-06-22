<?php
/**
 * Depotise module for Craft CMS 3.x
 *
 * online hardware shop
 *
 * @link      https://github.com/pdaleramirez
 * @copyright Copyright (c) 2020 Dale
 */

namespace modules\depotisemodule\console\controllers;

use craft\commerce\elements\Product;
use craft\db\Paginator;
use modules\depotisemodule\DepotiseModule;

use Craft;
use yii\console\Controller;
use yii\helpers\Console;

/**
 * Default Command
 *
 * The first line of this class docblock is displayed as the description
 * of the Console Command in ./craft help
 *
 * Craft can be invoked via commandline console by using the `./craft` command
 * from the project root.
 *
 * Console Commands are just controllers that are invoked to handle console
 * actions. The segment routing is module-name/controller-name/action-name
 *
 * The actionIndex() method is what is executed if no sub-commands are supplied, e.g.:
 *
 * ./craft depotise-module/default
 *
 * Actions must be in 'kebab-case' so actionDoSomething() maps to 'do-something',
 * and would be invoked via:
 *
 * ./craft depotise-module/default/do-something
 *
 * @author    Dale
 * @package   DepotiseModule
 * @since     1.0.0
 */
class DefaultController extends Controller
{
    // Public Methods
    // =========================================================================

    /**
     * Handle depotise-module/default console commands
     *
     * The first line of this method docblock is displayed as the description
     * of the Console Command in ./craft help
     *
     * @return mixed
     */
    public function actionIndex()
    {
        $result = 'something';

        echo "Welcome to the console DefaultController actionIndex() method\n";

        return $result;
    }

    /**
     * Handle depotise-module/default/do-something console commands
     *
     * The first line of this method docblock is displayed as the description
     * of the Console Command in ./craft help
     *
     * @return mixed
     */
    public function actionDoSomething()
    {
        $result = 'something';

        echo "Welcome to the console DefaultController actionDoSomething() method\n";

        return $result;
    }

    public function actionRand()
    {
        //$product = Product::find()->siteId(1)->id(36280)->one();
        $productsQuery = Product::find()->siteId(1);

        $paginator = new Paginator($productsQuery, [
            'currentPage' => 4,
            'pageSize'    => 2000
        ]);

        $products = $paginator->getPageResults();
        foreach ($products as $product) {
            $variants = $product->getVariants();
            $siteIds = [2, 3, 4, 5];
            $key = array_rand($siteIds, 1);
            $siteId = $siteIds[$key];
            if (!empty($variants)) {
                foreach ($variants as $key => $variant) {

                    $newVariant = $variants[$key];

                    $this->changeSite($newVariant->id, $siteId);
                }
            }

            $this->changeSite($product->id, $siteId);

            $this->stdout($product->title . ' site changed. '.PHP_EOL);
        }
    }

    private function changeSite($elementId, $siteId)
    {


        $db = Craft::$app->getDb()->createCommand();
        $db->update('{{%elements_sites}}', ['siteId' => $siteId], ['elementId' => $elementId]);
        $db->execute();
        $db->update('{{%content}}', ['siteId' => $siteId], ['elementId' => $elementId]);
        $db->execute();
    }
}
