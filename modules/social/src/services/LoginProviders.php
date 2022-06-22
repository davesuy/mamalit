<?php


namespace modules\social\services;

use Craft;
use modules\social\base\LoginProvider;
use modules\social\events\RegisterLoginProviderTypesEvent;
use modules\social\Plugin;
use yii\base\Component;
use modules\social\base\LoginProviderInterface;
use modules\social\loginproviders\Facebook;
use modules\social\loginproviders\Twitter;
use modules\social\loginproviders\Google;

/**
 * The LoginProviders service provides APIs for managing login providers in Craft.
 *
 * An instance of the LoginProviders service is globally accessible in Craft via [[Plugin::loginProviders `Plugin::getInstance()->getLoginProviders()`]].
 *
 *
 * @since   1.0
 */
class LoginProviders extends Component
{
    // Constants
    // =========================================================================

    /**
     * @event RegisterLoginProviderTypesEvent The event that is triggered when registering login providers.
     */
    const EVENT_REGISTER_LOGIN_PROVIDER_TYPES = 'registerLoginProviderTypes';

    // Public Methods
    // =========================================================================

    /**
     * Disable a login provider by handle.
     *
     * @param string $handle
     *
     * @return bool
     */
    public function disableLoginProvider($handle): bool
    {
        $settings = Plugin::getInstance()->getSettings();

        $enabledLoginProviders = $settings->enabledLoginProviders;

        if (($key = array_search($handle, $enabledLoginProviders, true)) !== false) {
            unset($enabledLoginProviders[$key]);
        }

        $settings->enabledLoginProviders = $enabledLoginProviders;

        return Plugin::getInstance()->savePluginSettings($settings->getAttributes());
    }

    /**
     * Enable a login provider by handle.
     *
     * @param string $handle
     *
     * @return bool
     */
    public function enableLoginProvider($handle): bool
    {
        //$plugin = Craft::$app->getPlugins()->getPlugin('social');

        $settings = Plugin::getInstance()->getSettings();

		$enabledLoginProviders = $settings->enabledLoginProviders;

        if (!in_array($handle, $enabledLoginProviders, true)) {
            $enabledLoginProviders[] = $handle;
        }

		$settings->enabledLoginProviders = $enabledLoginProviders;

        return Plugin::getInstance()->savePluginSettings($settings->getAttributes());
    }

    /**
     * Get a login provider by handle.
     *
     * @param string $handle
     * @param bool|true $enabledOnly
     *
     * @return LoginProvider|LoginProviderInterface|null
     */
    public function getLoginProvider($handle, $enabledOnly = true)
    {
        $loginProviders = $this->getLoginProviders($enabledOnly);

        foreach ($loginProviders as $loginProvider) {
            if ($loginProvider->getHandle() == $handle) {
                return $loginProvider;
            }
        }
    }

    /**
     * Get login providers.
     *
     * @param bool|true $enabledOnly
     *
     * @return array
     */
    public function getLoginProviders($enabledOnly = true): array
    {
        return $this->_getLoginProviders($enabledOnly);
    }

    // Private Methods
    // =========================================================================

    /**
     * Get login providers and instantiate them.
     *
     * @param bool $enabledOnly
     *
     * @return array
     */
    private function _getLoginProviders($enabledOnly): array
    {
        $loginProviderTypes = $this->_getLoginProviderTypes();

        $loginProviders = [];

        foreach ($loginProviderTypes as $loginProviderType) {
            $loginProvider = $this->_createLoginProvider($loginProviderType);

            if (!$enabledOnly || ($enabledOnly && $loginProvider->getIsEnabled())) {
                $key = substr($loginProviderType, strrpos($loginProviderType, "\\") + 1);
                $loginProviders[$key] = $loginProvider;
            }
        }

        ksort($loginProviders);

        return $loginProviders;
    }

    /**
     * Returns login provider types.
     *
     * @return array
     */
    private function _getLoginProviderTypes(): array
    {
        $loginProviderTypes = [
            Facebook::class,
            Google::class,
            Twitter::class,
        ];

        $eventName = self::EVENT_REGISTER_LOGIN_PROVIDER_TYPES;

        $event = new RegisterLoginProviderTypesEvent([
            'loginProviderTypes' => $loginProviderTypes
        ]);

        $this->trigger($eventName, $event);

        return $event->loginProviderTypes;
    }

    /**
     * Instantiates an OAuth provider.
     *
     * @param $socialLoginProviderType
     *
     * @return LoginProviderInterface
     */
    private function _createLoginProvider($socialLoginProviderType): LoginProviderInterface
    {
        return new $socialLoginProviderType;
    }
}
