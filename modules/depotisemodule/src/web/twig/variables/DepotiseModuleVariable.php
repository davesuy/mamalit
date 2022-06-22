<?php
/**
 * Depotise module for Craft CMS 3.x
 *
 * online hardware shop
 *
 * @link      https://github.com/pdaleramirez
 * @copyright Copyright (c) 2020 Dale
 */

namespace modules\depotisemodule\web\twig\variables;

use craft\models\Site;
use modules\depotisemodule\DepotiseModule;

use Craft;
use modules\depotisemodule\elements\MultipleOrder;
use yii\helpers\ArrayHelper;

/**
 * Depotise Variable
 *
 * Craft allows modules to provide their own template variables, accessible from
 * the {{ craft }} global variable (e.g. {{ craft.depotiseModule }}).
 *
 * https://craftcms.com/docs/plugins/variables
 *
 * @author    Dale
 * @package   DepotiseModule
 * @since     1.0.0
 */
class DepotiseModuleVariable
{
    // Public Methods
    // =========================================================================

    /**
     * Whatever you want to output to a Twig template can go into a Variable method.
     * You can have as many variable functions as you want.  From any Twig template,
     * call it like this:
     *
     *     {{ craft.depotiseModule.exampleVariable }}
     *
     * Or, if your variable requires parameters from Twig:
     *
     *     {{ craft.depotiseModule.exampleVariable(twigValue) }}
     *
     * @param null $optional
     * @return string
     */
    public function exampleVariable($optional = null)
    {
        $result = "And away we go to the Twig template...";
        if ($optional) {
            $result = "I'm feeling optional today...";
        }
        return $result;
    }

	public function app()
	{
		return DepotiseModule::$app;
	}

	public function getMultipleOrdersByCustomerId($customerId)
	{
		return DepotiseModule::$app->orders->getMultipleOrdersByCustomerId($customerId);
	}

	public function mix($file)
	{
		$mix = DepotiseModule::$app->mix(CRAFT_BASE_PATH);

		return $mix[$file];
	}

	public function getSite($id)
	{
		$siteRecord = \craft\records\Site::findWithTrashed()->where(['id' => $id])->one();
		$siteModel = new Site();
		$siteModel->setAttributes($siteRecord->getAttributes(), false);

		return $siteModel;
	}

	public function setCurrentSite($id)
	{
		$site = $this->getSite($id);

		Craft::$app->sites->setCurrentSite($site);
	}
}
