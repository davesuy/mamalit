<?php
/**
 * Depotise module for Craft CMS 3.x
 *
 * online hardware shop
 *
 * @link      https://github.com/pdaleramirez
 * @copyright Copyright (c) 2020 Dale
 */

namespace modules\depotisemodule\assetbundles\depotisemodule;

use Craft;
use craft\web\AssetBundle;
use craft\web\assets\cp\CpAsset;

/**
 * DepotiseModuleAsset AssetBundle
 *
 * AssetBundle represents a collection of asset files, such as CSS, JS, images.
 *
 * Each asset bundle has a unique name that globally identifies it among all asset bundles used in an application.
 * The name is the [fully qualified class name](http://php.net/manual/en/language.namespaces.rules.php)
 * of the class representing it.
 *
 * An asset bundle can depend on other asset bundles. When registering an asset bundle
 * with a view, all its dependent asset bundles will be automatically registered.
 *
 * http://www.yiiframework.com/doc-2.0/guide-structure-assets.html
 *
 * @author    Dale
 * @package   DepotiseModule
 * @since     1.0.0
 */
class DepotiseModuleAsset extends AssetBundle
{
    // Public Methods
    // =========================================================================

    /**
     * Initializes the bundle.
     */
    public function init()
    {
        // define the path that your publishable resources live
        $this->sourcePath = "@depotisemodule/assetbundles/depotisemodule/dist";

        // define the dependencies
        $this->depends = [
            CpAsset::class,
        ];

        // define the relative path to CSS/JS files that should be registered with the page
        // when this asset bundle is registered
        $this->js = [
            'js/depotise-cp.js',
        ];

        $this->css = [
            'css/cp.css'
        ];

        $currentUserId = Craft::$app->getUser()->getId();

        if ($currentUserId !== null) {
			$groups = Craft::$app->getUserGroups()->getGroupsByUserId($currentUserId);

			if (count($groups) > 0 && $groups[0]->handle === 'mamalit') {
				$this->css[] = 'css/mamalit.css';
			}


			if (Craft::$app->getUser()->getIsAdmin() === false) {
				$this->css[] = 'css/user.css';
			}
		}
        parent::init();
    }
}
