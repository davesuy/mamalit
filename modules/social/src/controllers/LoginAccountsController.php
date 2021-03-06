<?php


namespace modules\social\controllers;

use Craft;
use modules\social\errors\LoginException;
use modules\social\errors\RegistrationException;
use modules\social\events\LoginAccountEvent;
use modules\social\events\OauthTokenEvent;
use modules\social\helpers\SocialHelper;
use modules\social\Plugin;
use modules\social\web\assets\social\SocialAsset;
use GuzzleHttp\Exception\BadResponseException;
use yii\web\HttpException;
use craft\elements\User;
use modules\social\models\Token;
use modules\social\elements\LoginAccount;
use yii\web\Response;

/**
 * The LoginAccountsController class is a controller that handles various login account related tasks.
 *
 * Note that all actions in the controller, except [[actionLogin]], [[actionCallback]], require an authenticated Craft session via [[allowAnonymous]].
 *
 *
 * @since   1.0
 */
class LoginAccountsController extends BaseController
{
    // Constants
    // =========================================================================

    /**
     * @event LoginAccountEvent The event that is triggered before registering a user.
     */
    const EVENT_BEFORE_REGISTER = 'beforeRegister';

    /**
     * @event LoginAccountEvent The event that is triggered after registering a user.
     */
    const EVENT_AFTER_REGISTER = 'afterRegister';

    /**
     * @event LoginAccountEvent The event that is triggered after the OAuth callback.
     */
    const EVENT_AFTER_OAUTH_CALLBACK = 'afterOauthCallback';

    // Properties
    // =========================================================================

    /**
     * @inheritdoc
     */
    protected $allowAnonymous = ['login', 'callback'];

    /**
     * URL to redirect to after login.
     *
     * @var string
     */
    private $redirect;

    /**
     * URL where the login was initiated from.
     *
     * @var string
     */
    private $originUrl;

    // Public Methods
    // =========================================================================

    /**
     * Login Accounts Index.
     *
     * @return Response
     * @throws \yii\base\InvalidConfigException
     */
    public function actionIndex(): Response
    {
        Craft::$app->getView()->registerAssetBundle(SocialAsset::class);

        return $this->renderTemplate('depotise-social/loginaccounts/_index');
    }

    /**
     * Edit login accounts.
     *
     * @param $userId
     *
     * @return Response
     * @throws HttpException
     * @throws \yii\base\InvalidConfigException
     */
    public function actionEdit($userId): Response
    {
        $user = Craft::$app->users->getUserById($userId);

        if (!$user) {
            throw new HttpException(404);
        }

        $loginAccounts = Plugin::getInstance()->getLoginAccounts()->getLoginAccountsByUserId($user->id);

        Craft::$app->getView()->registerAssetBundle(SocialAsset::class);

        return $this->renderTemplate('depotise-social/loginaccounts/_edit', [
            'userId' => $userId,
            'user' => $user,
            'loginAccounts' => $loginAccounts
        ]);
    }

    /**
     * Delete login account.
     *
     * @return Response
     * @throws \Throwable
     * @throws \yii\base\InvalidConfigException
     * @throws \yii\web\BadRequestHttpException
     */
    public function actionDeleteLoginAccount(): Response
    {
        $this->requirePostRequest();
        $this->requireAcceptsJson();
        $this->requireAdmin();

        $loginAccountId = Craft::$app->getRequest()->getRequiredBodyParam('id');

        Plugin::getInstance()->getLoginAccounts()->deleteLoginAccountById($loginAccountId);

        return $this->asJson(['success' => true]);
    }

    /**
     * Login.
     *
     * @return Response
     * @throws \GuzzleHttp\Exception\GuzzleException
     * @throws \Throwable
     */
    public function actionLogin(): Response
    {
        Craft::$app->getSession()->set('social.loginControllerUrl', Craft::$app->getRequest()->getAbsoluteUrl());

        $this->originUrl = Craft::$app->getSession()->get('social.originUrl');

        if (!$this->originUrl) {
            $this->originUrl = Craft::$app->getRequest()->referrer;
            Craft::$app->getSession()->set('social.originUrl', $this->originUrl);
        }

        $this->redirect = (string)Craft::$app->getRequest()->getParam('redirect');


        // Connect

        $providerHandle = (string)Craft::$app->getRequest()->getParam('provider');

        $pluginSettings = Plugin::getInstance()->getSettings();

        try {
            if (!$pluginSettings->enableSocialLogin) {
                throw new LoginException('Social login is disabled');
            }

            $loginProvider = Plugin::getInstance()->getLoginProviders()->getLoginProvider($providerHandle);

            if (!$loginProvider) {
                throw new LoginException('Login provider is not configured');
            }


            // Redirect to login provider???s authorization page

            Craft::$app->getSession()->set('social.loginProvider', $providerHandle);

            if (!Craft::$app->getSession()->get('social.callback')) {
                return $loginProvider->oauthConnect();
            }


            // Callback

            Craft::$app->getSession()->remove('social.callback');

            $callbackResponse = $loginProvider->oauthCallback();
;
            if ($callbackResponse['success']) {
                $token = new Token();
                $token->providerHandle = $providerHandle;
                $token->token = $callbackResponse['token'];

                // Fire a 'afterOauthCallback' event
                if ($this->hasEventHandlers(self::EVENT_AFTER_OAUTH_CALLBACK)) {
                    $this->trigger(self::EVENT_AFTER_OAUTH_CALLBACK, new OauthTokenEvent([
                        'token' => $token,
                    ]));
                }

                return $this->connectUser($token);
            }


            // Unable to log the user in, throw an exception

            throw new LoginException($callbackResponse['errorMsg']);
        } catch (BadResponseException $e) {
            $response = $e->getResponse();
            $body = $response->getBody();
            $json = json_decode($body, true);

            if ($json) {
                $errorMsg = $json['error']['message'];
            } else {
                $errorMsg = 'Couldn???t login.';
            }

            Craft::error('Couldn???t login. ' . $e->getTraceAsString(), __METHOD__);
            Craft::$app->getSession()->setFlash('error', $errorMsg);
            $this->_cleanSession();

            return $this->redirect($this->originUrl);
        } catch (\Exception $e) {
            $errorMsg = $e->getMessage();
            Craft::error('Couldn???t login. ' . $e->getTraceAsString(), __METHOD__);
            Craft::$app->getSession()->setFlash('error', $errorMsg);
            $this->_cleanSession();

            return $this->redirect($this->originUrl);
        }
    }

    /**
     * OAuth callback.
     *
     * @return Response
     * @throws \craft\errors\MissingComponentException
     */
    public function actionCallback(): Response
    {
        Craft::$app->getSession()->set('social.callback', true);

        $url = Craft::$app->getSession()->get('social.loginControllerUrl');

        if (strpos($url, '?') === false) {
            $url .= '?';
        } else {
            $url .= '&';
        }


        // Pass the existing string containing oauth data to the next redirect

        $queryParams = Craft::$app->getRequest()->getQueryParams();

        if (isset($queryParams['p'])) {
            unset($queryParams['p']);
        }

        $url .= http_build_query($queryParams);

        return $this->redirect($url);
    }

    /**
     * Connect a login account (link).
     *
     * @return Response
     * @throws \GuzzleHttp\Exception\GuzzleException
     * @throws \Throwable
     */
    public function actionConnectLoginAccount(): Response
    {
        return $this->actionLogin();
    }

    /**
     * Disconnect a login account (unlink).
     *
     * @return Response
     * @throws \Throwable
     * @throws \yii\base\InvalidConfigException
     */
    public function actionDisconnectLoginAccount(): Response
    {
        $handle = Craft::$app->getRequest()->getParam('provider');

        // delete social user
        Plugin::getInstance()->getLoginAccounts()->deleteLoginAccountByProvider($handle);

        if (Craft::$app->getRequest()->getAcceptsJson()) {
            return $this->asJson([
                'success' => true
            ]);
        }

        Craft::$app->getSession()->setNotice(Craft::t('depotise-social', 'Login account disconnected.'));

        // redirect
        $redirect = Craft::$app->getRequest()->referrer;

        return $this->redirect($redirect);
    }

    // Private Methods
    // =========================================================================

    /**
     * Connect (register, login, link) a user from token.
     *
     * @param Token $token
     *
     * @return null|\yii\web\Response
     * @throws \GuzzleHttp\Exception\GuzzleException
     * @throws \Throwable
     * @throws \craft\errors\ElementNotFoundException
     * @throws \craft\errors\ImageException
     * @throws \craft\errors\VolumeException
     * @throws \yii\base\Exception
     * @throws \yii\base\InvalidConfigException
     */
    private function connectUser(Token $token)
    {
        $craftUser = Craft::$app->getUser()->getIdentity();

        if ($craftUser) {
            return $this->linkAccountFromToken($token, $craftUser);
        }

        return $this->registerOrLoginFromToken($token);
    }

    /**
     * Link account from token.
     *
     * @param Token $token
     * @param       $craftUser
     *
     * @return Response
     * @throws \Throwable
     * @throws \craft\errors\ElementNotFoundException
     * @throws \yii\base\Exception
     * @throws \yii\base\InvalidConfigException
     */
    private function linkAccountFromToken(Token $token, $craftUser): Response
    {
        $this->_cleanSession();

        if (!$this->redirect) {
            $this->redirect = $this->originUrl;
        }

        $socialLoginProvider = Plugin::getInstance()->getLoginProviders()->getLoginProvider($token->providerHandle);
        $profile = $socialLoginProvider->getProfile($token);
        $userFieldMapping = $socialLoginProvider->getUserFieldMapping();
        $socialUid = Craft::$app->getView()->renderString($userFieldMapping['id'], ['profile' => $profile]);
        $account = Plugin::getInstance()->getLoginAccounts()->getLoginAccountByUid($socialLoginProvider->getHandle(), $socialUid);


        // Existing login account

        if ($account) {
            if ($craftUser->id == $account->userId) {
                Craft::$app->elements->saveElement($account);

                Craft::$app->getSession()->setNotice(Craft::t('depotise-social', 'Login account added.'));

                return $this->redirect($this->redirect);
            }

            throw new LoginException('This UID is already associated with another user. Disconnect from your current session and retry.');
        }


        // New login account

        $account = new LoginAccount;
        $account->userId = $craftUser->id;
        $account->providerHandle = $socialLoginProvider->getHandle();
        $account->socialUid = $socialUid;

        Craft::$app->getElements()->saveElement($account);

        Craft::$app->getSession()->setNotice(Craft::t('depotise-social', 'Login account added.'));

        return $this->redirect($this->redirect);
    }

    /**
     * Register or login user from an OAuth token.
     *
     * @param Token $token
     *
     * @return null
     * @throws \GuzzleHttp\Exception\GuzzleException
     * @throws \Throwable
     * @throws \craft\errors\ElementNotFoundException
     * @throws \craft\errors\ImageException
     * @throws \craft\errors\VolumeException
     * @throws \yii\base\Exception
     * @throws \yii\base\InvalidConfigException
     */
    private function registerOrLoginFromToken(Token $token)
    {
        $socialLoginProvider = Plugin::getInstance()->getLoginProviders()->getLoginProvider($token->providerHandle);

        $profile = $socialLoginProvider->getProfile($token);

        $userFieldMapping = $socialLoginProvider->getUserFieldMapping();
        $socialUid = Craft::$app->getView()->renderString($userFieldMapping['id'], ['profile' => $profile]);
        $account = Plugin::getInstance()->getLoginAccounts()->getLoginAccountByUid($socialLoginProvider->getHandle(), $socialUid);

        // Existing user
        if ($account) {
            $craftUser = Craft::$app->users->getUserById($account->userId);

            if (!$craftUser) {
                throw new LoginException('Social account exists but Craft user doesn???t.');
            }

            // Save existing login account
            Craft::$app->elements->saveElement($account);

            // Login
            return $this->login($craftUser, $account, $token);
        }

        // Register new user
        $craftUser = $this->registerUser($socialLoginProvider->getHandle(), $profile);

        if (!$craftUser) {
            throw new RegistrationException('Craft user couldn???t be created.');
        }

        // Save new login account
        $account = new LoginAccount;
        $account->userId = $craftUser->id;
        $account->providerHandle = $socialLoginProvider->getHandle();
        $account->socialUid = $socialUid;

        Craft::$app->elements->saveElement($account);

        // Login
        return $this->login($craftUser, $account, $token, true);
    }

    /**
     * Register a user.
     *
     * @param string $providerHandle
     * @param        $profile
     *
     * @return User
     * @throws RegistrationException
     * @throws \GuzzleHttp\Exception\GuzzleException
     * @throws \Throwable
     * @throws \craft\errors\ElementNotFoundException
     * @throws \craft\errors\ImageException
     * @throws \craft\errors\VolumeException
     * @throws \craft\errors\WrongEditionException
     * @throws \yii\base\Exception
     * @throws \yii\base\InvalidConfigException
     */
    private function registerUser(string $providerHandle, $profile): User
    {
        $loginProvider = Plugin::getInstance()->getLoginProviders()->getLoginProvider($providerHandle);
        $userFieldMapping = $loginProvider->getUserFieldMapping();
        $email = Craft::$app->getView()->renderString($userFieldMapping['email'], ['profile' => $profile]);

        if (empty($email)) {
            throw new RegistrationException('Email address not provided.');
        }


        // Registration of an existing user with a matching email
        $user = Craft::$app->users->getUserByUsernameOrEmail($email);

        if ($user) {
            if (Plugin::getInstance()->getSettings()->allowEmailMatch !== true) {
                throw new RegistrationException('An account already exists with this email: ' . $email);
            }

            return $user;
        }


        // Register a new user

        Craft::$app->requireEdition(Craft::Pro);

        $settings = Plugin::getInstance()->getSettings();

        $this->checkRegistrationEnabled($settings);
        $this->checkLockedDomains($email);

        // Fire a 'beforeRegister' event
        if ($this->hasEventHandlers(self::EVENT_BEFORE_REGISTER)) {
            $this->trigger(self::EVENT_BEFORE_REGISTER, new LoginAccountEvent([
                'profile' => &$profile,
                'loginProvider' => $loginProvider,
            ]));
        }

        $newUser = new User();

        // Fill user
        $this->fillUser($providerHandle, $newUser, $profile);

        // Save user
        if (!Craft::$app->elements->saveElement($newUser)) {
            Craft::error('There was a problem creating the user:' . print_r($newUser->getErrors(), true), __METHOD__);
            throw new RegistrationException('Craft user couldn???t be created.');
        }

        // Save remote photo
        if ($settings['autoFillProfile']) {
            Plugin::getInstance()->getLoginAccounts()->saveRemotePhoto($providerHandle, $newUser, $profile);
        }

        // Assign user to default group
        if ($newUser->id !== null && !empty($settings['defaultGroup'])) {
            Craft::$app->users->assignUserToGroups($newUser->id, [$settings['defaultGroup']]);
        }

        Craft::$app->elements->saveElement($newUser);

        // Fire a 'afterRegister' event
        if ($this->hasEventHandlers(self::EVENT_AFTER_REGISTER)) {
            $this->trigger(self::EVENT_AFTER_REGISTER, new LoginAccountEvent([
                'profile' => &$profile,
                'loginProvider' => $loginProvider,
                'user' => $newUser
            ]));
        }

        return $newUser;
    }

    /**
     * @param string $providerHandle
     * @param User $newUser
     * @param        $profile
     *
     * @throws \yii\base\InvalidConfigException
     */
    private function fillUser(string $providerHandle, User $newUser, $profile)
    {

        $settings = Plugin::getInstance()->getSettings();
        $loginProvider = Plugin::getInstance()->getLoginProviders()->getLoginProvider($providerHandle);
        $userFieldMapping = $loginProvider->getUserFieldMapping();

        $userModelAttributes = ['email', 'username', 'firstName', 'lastName', 'preferredLocale', 'weekStartDay'];

        foreach ($userFieldMapping as $attribute => $template) {
            // Only fill other fields than `email` and `username` when `autoFillProfile` is true
            if (!$settings->autoFillProfile && $attribute !== 'email' && $attribute !== 'username') {
                continue;
            }

            // Check whether they try to set an attribute or a custom field
            if (\in_array($attribute, $userModelAttributes, true)) {
                SocialHelper::fillUserAttribute($newUser, $attribute, $template, $profile);
            } else {
                SocialHelper::fillUserCustomFieldValue($newUser, $attribute, $template, $profile);
            }
        }
    }

    /**
     * Login user from login account.
     *
     * @param User $craftUser
     * @param LoginAccount $account
     * @param Token $token
     * @param bool $registrationMode
     *
     * @return Response
     * @throws \craft\errors\MissingComponentException
     * @throws \yii\base\InvalidConfigException
     */
    private function login(User $craftUser, LoginAccount $account, Token $token, $registrationMode = false): Response
    {
        $this->_cleanSession();

        if (!$this->redirect) {
            $this->redirect = $this->originUrl;
        }

        if (!$account->authenticate($token)) {
            return $this->_handleLoginFailure();
        }

        if (!Craft::$app->getUser()->login($craftUser)) {
            return $this->_handleLoginFailure();
        }

        return $this->_handleSuccessfulLogin($registrationMode);
    }

    /**
     * Handles a failed login attempt.
     *
     * @return Response
     * @throws \craft\errors\MissingComponentException
     */
    private function _handleLoginFailure(): Response
    {
        Craft::$app->getSession()->setError(Craft::t('depotise-social', 'Couldn???t authenticate.'));

        return $this->redirect($this->originUrl);
    }

    /**
     * Redirects the user after a successful login attempt.
     *
     * @param bool $registrationMode
     *
     * @return Response
     * @throws \craft\errors\MissingComponentException
     */
    private function _handleSuccessfulLogin(bool $registrationMode): Response
    {
        if ($registrationMode) {
            Craft::$app->getSession()->setNotice(Craft::t('depotise-social', 'Account created.'));
        } else {
            Craft::$app->getSession()->setNotice(Craft::t('depotise-social', 'Logged in.'));
        }

        return $this->redirect($this->redirect);
    }

    /**
     * Clean session variables.
     */
    private function _cleanSession()
    {
        Craft::$app->getSession()->remove('social.originUrl');
    }
}
