<?php


namespace modules\social\web\assets\loginaccountindex;

use craft\web\AssetBundle;
use craft\web\assets\cp\CpAsset;

/**
 * Asset bundle for login account index
 */
class LoginAccountIndexAsset extends AssetBundle
{
    /**
     * @inheritdoc
     */
    public function init()
    {
        $this->sourcePath = __DIR__ . '/dist';

        $this->depends = [
            CpAsset::class,
        ];

        $this->js = [
            'LoginAccountIndex.js',
        ];

        parent::init();
    }
}
