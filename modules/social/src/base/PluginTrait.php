<?php


namespace modules\social\base;

use modules\social\Plugin;

/**
 * PluginTrait implements the common methods and properties for plugin classes.
 *
 * @property \modules\social\services\LoginAccounts $loginAccounts      The loginAccounts service
 * @property \modules\social\services\LoginProviders $loginProviders     The loginProviders service
 */
trait PluginTrait
{
    /**
     * Returns the loginAccounts service.
     *
     * @return \modules\social\services\LoginAccounts The loginAccounts service
     * @throws \yii\base\InvalidConfigException
     */
    public function getLoginAccounts()
    {
        /** @var Plugin $this */
        return $this->get('loginAccounts');
    }

    /**
     * Returns the loginProviders service.
     *
     * @return \modules\social\services\LoginProviders The loginProviders service
     * @throws \yii\base\InvalidConfigException
     */
    public function getLoginProviders()
    {
        /** @var Plugin $this */
        return $this->get('loginProviders');
    }
}
