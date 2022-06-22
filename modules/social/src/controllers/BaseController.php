<?php


namespace modules\social\controllers;

use craft\web\Controller;
use modules\social\errors\RegistrationException;
use modules\social\Plugin;

/**
 * The LoginAccountsController class is a controller that handles various login account related tasks.
 *
 * Note that all actions in the controller, except [[actionLogin]], [[actionCallback]], require an authenticated Craft session via [[allowAnonymous]].
 *
 *
 * @since   1.0
 */
abstract class BaseController extends Controller
{
    // Public Methods
    // =========================================================================

    /**
     * Check if social registration is enabled.
     *
     * @param $settings
     *
     * @throws RegistrationException
     */
    public function checkRegistrationEnabled($settings)
    {
        if (!$settings['enableSocialRegistration']) {
            throw new RegistrationException('Social registration is disabled.');
        }
    }

    /**
     * Check locked domains.
     *
     * @param $email
     *
     * @throws RegistrationException
     */
    public function checkLockedDomains($email)
    {
        $lockDomains = Plugin::getInstance()->getSettings()->lockDomains;

        if (\count($lockDomains) > 0) {
            $domainRejected = true;

            foreach ($lockDomains as $lockDomain) {
                if (strpos($email, '@' . $lockDomain) !== false) {
                    $domainRejected = false;
                }
            }

            if ($domainRejected) {
                throw new RegistrationException('Couldn’t register with this email (domain is not allowed): ' . $email);
            }
        }
    }
}
