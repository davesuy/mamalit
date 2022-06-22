<?php


namespace modules\social\web\twig\variables;

use Craft;
use modules\social\elements\db\LoginAccountQuery;
use modules\social\elements\LoginAccount;
use modules\social\Plugin;

/**
 * Class SocialVariable variable.
 *
 *
 * @since   1.0
 */
class SocialVariable
{
    // Public Methods
    // =========================================================================

    /**
     * Returns a new EntryQuery instance.
     *
     * @param mixed $criteria
     *
     * @return LoginAccountQuery
     */
    public function loginAccounts($criteria = null): LoginAccountQuery
    {
        $query = LoginAccount::find();
        if ($criteria) {
            Craft::configure($query, $criteria);
        }

        return $query;
    }

    /**
     * Get the login URL
     *
     * @param       $providerHandle
     * @param array $params
     *
     * @return string
     * @throws \yii\base\InvalidConfigException
     */
    public function getLoginUrl($providerHandle, array $params = [])
    {
        return Plugin::getInstance()->getLoginAccounts()->getLoginUrl($providerHandle, $params);
    }

    /**
     * Get the login account by provider handle
     *
     * @param string $loginProviderHandle
     *
     * @return LoginAccount|null
     * @throws \yii\base\InvalidConfigException
     */
    public function getLoginAccountByLoginProvider($loginProviderHandle)
    {
        return Plugin::getInstance()->getLoginAccounts()->getLoginAccountByLoginProvider($loginProviderHandle);
    }

    /**
     * Get the login account connect URL
     *
     * @param string $providerHandle
     *
     * @return string
     * @throws \yii\base\InvalidConfigException
     */
    public function getLoginAccountConnectUrl($providerHandle)
    {
        return Plugin::getInstance()->getLoginAccounts()->getLoginAccountConnectUrl($providerHandle);
    }

    /**
     * Get the login account disconnect URL
     *
     * @param string $providerHandle
     *
     * @return string
     * @throws \yii\base\InvalidConfigException
     */
    public function getLoginAccountDisconnectUrl($providerHandle)
    {
        return Plugin::getInstance()->getLoginAccounts()->getLoginAccountDisconnectUrl($providerHandle);
    }

    /**
     * Get a list of login providers
     *
     * @param bool|true $enabledOnly
     *
     * @return array
     * @throws \yii\base\InvalidConfigException
     */
    public function getLoginProviders($enabledOnly = true)
    {
        return Plugin::getInstance()->getLoginProviders()->getLoginProviders($enabledOnly);
    }
}
