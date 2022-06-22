<?php


namespace modules\social\loginproviders;

use modules\social\base\LoginProvider;
use modules\social\models\Token;

/**
 * Google represents the Google login provider.
 *
 *
 * @since   1.0
 */
class Google extends LoginProvider
{
    // Public Methods
    // =========================================================================

    /**
     * @inheritdoc
     */
    public function getName(): string
    {
        return 'Google';
    }

    /**
     * @inheritdoc
     */
    public function getDefaultOauthScope(): array
    {
        return [
            'https://www.googleapis.com/auth/userinfo.profile',
            'https://www.googleapis.com/auth/userinfo.email'
        ];
    }

    /**
     * @inheritdoc
     */
    public function getManagerUrl()
    {
        return 'https://code.google.com/apis/console/';
    }

    /**
     * @inheritdoc
     */
    public function getScopeDocsUrl()
    {
        return 'https://developers.google.com/identity/protocols/googlescopes';
    }

    /**
     * @inheritdoc
     */
    public function getDefaultUserFieldMapping(): array
    {
        return [
            'id' => '{{ profile.getId() }}',
            'email' => '{{ profile.getEmail() }}',
            'username' => '{{ profile.getEmail() }}',
            'photo' => '{{ profile.getAvatar() }}',
        ];
    }

    /**
     * @inheritdoc
     */
    public function getOauthProviderConfig(): array
    {
        $config = parent::getOauthProviderConfig();

        if (empty($config['options']['useOidcMode'])) {
            $config['options']['useOidcMode'] = true;
        }

        return $config;
    }

    /**
     * Returns the login provider’s OAuth provider.
     *
     * @return \League\OAuth2\Client\Provider\Google
     * @throws \yii\base\InvalidConfigException
     */
    public function getOauthProvider(): \League\OAuth2\Client\Provider\Google
    {
        $config = $this->getOauthProviderConfig();

        return new \League\OAuth2\Client\Provider\Google($config['options']);
    }
}
