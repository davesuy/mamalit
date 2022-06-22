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

use modules\depotisemodule\DepotiseModule;

use Craft;
use craft\base\Component;

/**
 * DepotiseModuleService Service
 *
 * All of your module’s business logic should go in services, including saving data,
 * retrieving data, etc. They provide APIs that your controllers, template variables,
 * and other modules can interact with.
 *
 * https://craftcms.com/docs/plugins/services
 *
 * @author    Dale
 * @package   DepotiseModule
 * @since     1.0.0
 */
class DepotiseModuleService extends Component
{
    // Public Methods
    // =========================================================================

    /**
     * This function can literally be anything you want, and you can have as many service
     * functions as you want
     *
     * From any other plugin/module file, call it like this:
     *
     *     DepotiseModule::$instance->depotiseModuleService->exampleService()
     *
     * @return mixed
     */
    public function exampleService()
    {
        $result = 'something';

        return $result;
    }
}
