<?php

namespace modules\social\loginproviders;

use modules\social\base\LoginProvider;
use modules\social\helpers\SocialHelper;
use GuzzleHttp\Client;
use modules\social\models\Token;
use League\OAuth2\Client\Provider\FacebookUser;
use Craft;

class Facebook extends LoginProvider
{
    // Public Methods
    // =========================================================================

    /**
     * @inheritdoc
     */
    public function getName(): string
    {
        return 'Facebook';
    }

    /**
     * @inheritdoc
     */
    public function getManagerUrl()
    {
        return 'https://developers.facebook.com/apps';
    }

    /**
     * @inheritdoc
     */
    public function getScopeDocsUrl()
    {
        return 'https://developers.facebook.com/docs/facebook-login/permissions';
    }

    /**
     * @inheritdoc
     */
    public function getProfile(Token $token)
    {
        $client = $this->getClient($token);

        $fields = implode(',', $this->getProfileFields());

        $options = [
            'query' => [
                'fields' => 'email'
            ]
        ];

        $response = $client->request('GET', '/me', $options);

        if (!$response) {
            return null;
        }

        $data = json_decode($response->getBody(), true);

        if (!$data) {
            return null;
        }

        return new FacebookUser($data);
    }

    /**
     * Get the redirect URI.
     *
     * @return string
     */
    public function getRedirectUri(): string
    {
        $url = SocialHelper::siteActionUrl('depotise-social/login-accounts/callback');
        $parsedUrl = parse_url($url);

        if (isset($parsedUrl['query'])) {
            parse_str($parsedUrl['query'], $query);

            $query = http_build_query($query);

            return $parsedUrl['scheme'] . '://' . $parsedUrl['host'] . $parsedUrl['path'] . '?' . $query;
        }

        return $url;
    }

    /**
     * @inheritdoc
     */
    public function getOauthProviderConfig(): array
    {
        $config = parent::getOauthProviderConfig();

        if (empty($config['options']['graphApiVersion'])) {
            $config['options']['graphApiVersion'] = 'v7.0';
        }

        return $config;
    }

    /**
     * @inheritdoc
     *
     * @return \League\OAuth2\Client\Provider\Facebook
     * @throws \yii\base\InvalidConfigException
     */
    public function getOauthProvider(): \League\OAuth2\Client\Provider\Facebook
    {
        $config = $this->getOauthProviderConfig();

        return new \League\OAuth2\Client\Provider\Facebook($config['options']);
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
            'photo' => '{{ profile.getPictureUrl() }}',
        ];
    }

    // Protected Methods
    // =========================================================================

    /**
     * @inheritdoc
     */
    protected function getDefaultOauthScope(): array
    {
        return [
            'email',
        ];
    }

    /**
     * @inheritdoc
     */
    protected function getDefaultProfileFields(): array
    {
        return [
            'id',
            'name',
            'first_name',
            'last_name',
            'email',
            'picture.type(large){url,is_silhouette}',
            'cover{source}',
            'gender',
            'locale',
            'link',
        ];
    }

    // Private Methods
    // =========================================================================

    /**
     * Returns the authenticated Guzzle client.
     *
     * @param Token $token
     *
     * @return Client
     */
    private function getClient(Token $token): Client
    {
        $headers = [];

        if ($token) {

            $headers['Authorization'] = 'Bearer ' . $token->token;
        }

        $options = [
            'base_uri' => 'https://graph.facebook.com/',
            'headers' => $headers
        ];

        return new Client($options);
    }
}
