<?php

use Codeception\Stub;
use Codeception\Test\Unit;
use craft\commerce\controllers\CartController;
use craft\elements\Entry;
use craft\helpers\Json;
use craft\records\Plugin;
use craft\records\User;
use modules\depotisemodule\DepotiseModule;
use modules\depotisemodule\services\App;
use pdaleramirez\superfilter\SuperFilter;

class DepotiseTest extends Unit
{
	/**
	 * @var UnitTester
	 */
	protected $tester;

	protected $user_id;
//
	function _before()
	{
		// preparing a user, inserting user record to database
//		$this->user_id = $this->tester->haveRecord('craft\records\plugin', [
//			//'id' => 1,
//			'handle' => 'imba',
//			'schemaVersion' => '1',
//			'installDate' => '2020-11-01 00:00:00',
//			'version' => '1'
//		]);
	}

    public function testFirstDepot()
    {
/*		$service = $this->make(App::class, [
			'tryCall' => Stub\Expected::once()
		]);

		$service->testMethod();*/

	//	Craft::dd(\craft\commerce\Plugin::getInstance()->getCarts(), 10, false);
//		$service = $this->make(CartController::class, [
//			'requirePostRequest' => Stub\Expected::once()
//		]);
//
//		$service->actionUpdateCart();
    }
}
