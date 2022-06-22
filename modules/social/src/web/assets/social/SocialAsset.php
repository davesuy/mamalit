<?php


namespace modules\social\web\assets\social;

use craft\web\AssetBundle;
use craft\web\assets\cp\CpAsset;

/**
 * Asset bundle for Social
 */
class SocialAsset extends AssetBundle
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

        $this->css = [
            'social.css',
        ];

        $this->js = [
            'social.js',
        ];

        parent::init();
    }
}
