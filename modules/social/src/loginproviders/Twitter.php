<?php


namespace modules\social\loginproviders;

use Craft;
use modules\social\base\LoginProvider;
use modules\social\models\Token;

/**
 * Twitter represents the Twitter login provider.
 *
 *
 * @since   1.0
 */
class Twitter extends LoginProvider
{
    // Public Methods
    // =========================================================================

    /**
     * @inheritdoc
     */
    public function getName(): string
    {
        return 'Twitter';
    }

    /**
     * @inheritdoc
     */
    public function oauthVersion(): int
    {
        return 1;
    }

    /**
     * @inheritdoc
     */
    public function getManagerUrl()
    {
        return 'https://dev.twitter.com/apps';
    }

    /**
     * @inheritdoc
     */
    public function getProfile(Token $token)
    {
        $profile = $this->getOauthProvider()->getUserDetails($token->token);

        if (!$profile) {
            return null;
        }

        $profile = (array)$profile;
        $profile['id'] = $profile['uid'];

        return $profile;
    }

    /**
     * @inheritdoc
     */
    public function getDefaultUserFieldMapping(): array
    {
        return [
            'id' => '{{ profile.uid }}',
            'email' => '{{ profile.email }}',
            'username' => '{{ profile.email }}',
            'photo' => '{{ profile.imageUrl|replace("_normal.", ".") }}',
        ];
    }

    /**
     * Returns the login provider’s OAuth provider.
     *
     * @return \League\OAuth1\Client\Server\Twitter
     * @throws \yii\base\InvalidConfigException
     */
    public function getOauthProvider(): \League\OAuth1\Client\Server\Twitter
    {
        $config = $this->getOauthProviderConfig();

        $config['identifier'] = $config['options']['clientId'] ?? '';
        unset($config['options']['clientId']);

        $config['secret'] = $config['options']['clientSecret'] ?? '';
        unset($config['options']['clientSecret']);

        $config['callback_uri'] = $config['options']['redirectUri'] ?? '';
        unset($config['options']['redirectUri']);

        return new \League\OAuth1\Client\Server\Twitter($config);
    }

    /**
     * Returns a warning for the OAuth redirect URI.
     *
     * @return string|null
     */
    public function getRedirectUriWarning()
    {
        $generalConfig = Craft::$app->getConfig()->getGeneral();

        if ($generalConfig->usePathInfo) {
            return null;
        }

        return Craft::t('depotise-social', 'Query parameters are not allowed in Twitter callback URLs. {link}.', [
            'link' => '<a href="https://docs.dukt.net/social/v2/twitter.html#oauth-configuration">'.Craft::t('depotise-social', 'More information').'</a>'
        ]);
    }
}
