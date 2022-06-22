<?php
/**
 * @link https://craftcms.com/
 * @copyright Copyright (c) Pixel & Tonic, Inc.
 * @license https://craftcms.github.io/license/
 */

namespace modules\depotisemodule\elements\actions;

use Craft;
use craft\commerce\Plugin;
use craft\elements\actions\Delete;
use craft\elements\db\ElementQueryInterface;
use modules\depotisemodule\records\MultipleOrder;

/**
 * Delete Element Action
 *
 * @author Pixel & Tonic, Inc. <support@pixelandtonic.com>
 * @since 2.0
 */
class DeleteMultipleOrder extends Delete
{
	/**
	 * @inheritdoc
	 */
	public function performAction(ElementQueryInterface $query = null): bool
	{
		if (!$query) {
			return false;
		}

		foreach ($query->all() as $order) {
			Craft::$app->getElements()->deleteElement($order);
		}

		$this->setMessage(Plugin::t('Orders deleted.'));

		return true;
	}
}
