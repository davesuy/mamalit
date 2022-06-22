<?php


namespace modules\social\base;

use craft\web\Response;

/**
 * LoginProviderInterface defines the common interface to be implemented by login provider classes.
 *
 *
 * @since   1.0
 */
interface LoginProviderInterface
{
    // Public Methods
    // =========================================================================

    /**
     * Returns the name of the login provider.
     *
     * @return string
     */
    public function getName(): string;

    /**
     * Returns the OAuth provider instance.
     *
     * @return mixed
     */
    public function getOauthProvider();

    /**
     * Returns the default user field mapping.
     *
     * @return array
     */
    public function getDefaultUserFieldMapping(): array;

    /**
     * OAuth connect.
     *
     * @return Response
     */
    public function oauthConnect(): Response;

    /**
     * OAuth callback.
     *
     * @return array
     */
    public function oauthCallback(): array;
}
