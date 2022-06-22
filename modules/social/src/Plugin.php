<?php


namespace modules\social;

use Craft;
use craft\elements\User;
use craft\events\ModelEvent;
use craft\events\RegisterCpNavItemsEvent;
use craft\events\RegisterElementTableAttributesEvent;
use craft\events\RegisterTemplateRootsEvent;
use craft\events\RegisterUrlRulesEvent;
use craft\events\SetElementTableAttributeHtmlEvent;
use craft\helpers\UrlHelper;
use craft\services\Plugins;
use craft\web\twig\variables\Cp;
use craft\web\twig\variables\CraftVariable;
use craft\web\UrlManager;
use craft\web\View;
use modules\social\base\PluginTrait;
use modules\social\elements\LoginAccount;
use modules\social\models\Settings;
use modules\social\web\assets\login\LoginAsset;
use modules\social\web\twig\variables\SocialVariable;
use modules\social\web\assets\social\SocialAsset;
use yii\base\Event;
use yii\base\Module;
use craft\i18n\PhpMessageSource;
/**
 * Social plugin class.
 *
 *
 * @since   1.0
 */
class Plugin extends Module
{
    // Traits
    // =========================================================================

    use PluginTrait;

    // Properties
    // =========================================================================

    /**
     * @var bool
     */
    public $hasCpSettings = true;

    /**
     * @inheritdoc
     */
    public $minVersionRequired = '1.1.0';

	public function __construct($id, $parent = null, array $config = [])
	{
		// Translation category
		$i18n = Craft::$app->getI18n();
		/** @noinspection UnSafeIsSetOverArrayInspection */
		if (!isset($i18n->translations[$id]) && !isset($i18n->translations[$id . '*'])) {
			$i18n->translations[$id] = [
				'class' => PhpMessageSource::class,
				'sourceLanguage' => 'en-US',
				'basePath' => '@depotisemodule/translations',
				'forceTranslation' => true,
				'allowOverrides' => true,
			];
		}

		// Set this as the global instance of this module class
		static::setInstance($this);

		parent::__construct($id, $parent, $config);
	}

    /**
     * @inheritdoc
     */
    public function init()
    {
        parent::init();

        $this->_setPluginComponents();
        $this->_registerCpRoutes();
        $this->_registerVariable();
        $this->_registerEventHandlers();
        $this->_registerTableAttributes();
        $this->_initLoginAccountsUserPane();
		Craft::setAlias('@depotisesocial', __DIR__);

		Event::on(
			Cp::class,
			Cp::EVENT_REGISTER_CP_NAV_ITEMS,
			function(RegisterCpNavItemsEvent $event) {
				$event->navItems[] = [
					'url' => 'settings/depotise-social',
					'label' => 'Social Login',
					'icon' => '@app/icons/users.svg',
				];
			}
		);
		// Base template directory
		Event::on(View::class, View::EVENT_REGISTER_CP_TEMPLATE_ROOTS, function (RegisterTemplateRootsEvent $e) {
			if (is_dir($baseDir = $this->getBasePath().DIRECTORY_SEPARATOR.'templates')) {
				$e->roots[$this->id] = $baseDir;
			}
		});
    }

    public function getSettings()
	{
		$settingValues = Craft::$app->getProjectConfig()->get('depotiseSocial');

		$settingModel = new Settings();
		$settingModel->setAttributes($settingValues, false);

		return $settingModel;
	}

	/**
     * @inheritdoc
     */
    public function getSettingsResponse()
    {
        $url = UrlHelper::cpUrl('settings/depotise-social/loginproviders');

        Craft::$app->controller->redirect($url);

        return '';
    }

    /**
     * Get OAuth provider config.
     *
     * @param $handle
     *
     * @return array
     * @throws \yii\base\InvalidConfigException
     */
    public function getOauthProviderConfig($handle): array
    {
        $config = [
            'options' => $this->getOauthConfigItem($handle, 'options'),
            'scope' => $this->getOauthConfigItem($handle, 'scope'),
            'authorizationOptions' => $this->getOauthConfigItem($handle, 'authorizationOptions'),
        ];

        $provider = $this->getLoginProviders()->getLoginProvider($handle);

        if ($provider && !isset($config['options']['redirectUri'])) {
            $config['options']['redirectUri'] = $provider->getRedirectUri();
        }

        return $config;
    }

    /**
     * Get login provider config.
     *
     * @param $handle
     *
     * @return array
     */
    public function getLoginProviderConfig($handle)
    {
        $configSettings = Craft::$app->config->getConfigFromFile($this->id);

        if (isset($configSettings['loginProviders'][$handle])) {
            return $configSettings['loginProviders'][$handle];
        }

        return [];
    }

    /**
     * Save plugin settings.
     *
     * @param array $settings
     *
     * @param Plugin|null $plugin
     * @return bool
     */
    public function savePluginSettings(array $settings)
    {
		$storedSettings = $this->getSettings()->getAttributes();

		$settings['loginProviders'] = [];

		if (isset($storedSettings['loginProviders'])) {
			$settings['loginProviders'] = $storedSettings['loginProviders'];
		}

		Craft::$app->getProjectConfig()->set('depotiseSocial', $settings);

		return true;
    }

    /**
     * Save login provider settings.
     *
     * @param $handle
     * @param $providerSettings
     *
     * @return bool
     */
    public function saveLoginProviderSettings($handle, $providerSettings)
    {
        $settings = (array)self::getInstance()->getSettings();
        //$storedSettings = Craft::$app->plugins->getStoredPluginInfo('social')['settings'];
		$storedSettings = $this->getSettings()->getAttributes();

        $settings['loginProviders'] = [];

        if (isset($storedSettings['loginProviders'])) {
            $settings['loginProviders'] = $storedSettings['loginProviders'];
        }

        $settings['loginProviders'][$handle] = $providerSettings;
        //$plugin = Craft::$app->getPlugins()->getPlugin('social');

        Craft::$app->getProjectConfig()->set('depotiseSocial', $settings);

        return true;
    }

    // Protected Methods
    // =========================================================================

    /**
     * @inheritdoc
     */
    protected function createSettingsModel()
    {
        return new Settings();
    }

    // Private Methods
    // =========================================================================

    /**
     * Social login for the control panel.
     *
     * @return null
     * @throws \craft\errors\MissingComponentException
     * @throws \yii\base\InvalidConfigException
     */
    private function initCpSocialLogin()
    {
        if (!Craft::$app->getRequest()->getIsConsoleRequest() && $this->getSettings()->enableCpLogin && Craft::$app->getRequest()->getIsCpRequest() && Craft::$app->getRequest()->getSegment(1) === 'login') {

            $loginProviders = $this->loginProviders->getLoginProviders();
            $jsLoginProviders = [];

            foreach ($loginProviders as $loginProvider) {
                $jsLoginProvider = [
                    'name' => $loginProvider->getName(),
                    'handle' => $loginProvider->getHandle(),
                    'url' => $this->getLoginAccounts()->getLoginUrl($loginProvider->getHandle()),
                    'iconUrl' => $loginProvider->getIconUrl(),
                ];

                $jsLoginProviders[] = $jsLoginProvider;
            }

            $error = Craft::$app->getSession()->getFlash('error');

            Craft::$app->getView()->registerAssetBundle(LoginAsset::class);

            Craft::$app->getView()->registerJs('var socialLoginForm = new Craft.SocialLoginForm(' . json_encode($jsLoginProviders) . ', ' . json_encode($error) . ');');
        }
    }

    /**
     * Initialize login accounts user pane.
     *
     * @return null
     */
    private function _initLoginAccountsUserPane()
    {
        Craft::$app->getView()->hook('cp.users.edit.details', function(&$context) {
            if ($context['user'] && $context['user']->id) {
                $context['loginAccounts'] = $this->loginAccounts->getLoginAccountsByUserId($context['user']->id);
                $context['loginProviders'] = $this->loginProviders->getLoginProviders();

                Craft::$app->getView()->registerAssetBundle(SocialAsset::class);

                return Craft::$app->getView()->renderTemplate('depotise-social/_components/users/login-accounts-pane', $context);
            }
        });
    }

    /**
     * Get OAuth config item
     *
     * @param string $providerHandle
     * @param string $key
     *
     * @return array
     */
    private function getOauthConfigItem(string $providerHandle, string $key): array
    {
        $configSettings = Craft::$app->config->getConfigFromFile($this->id);

        if (isset($configSettings['loginProviders'][$providerHandle]['oauth'][$key])) {
            return $configSettings['loginProviders'][$providerHandle]['oauth'][$key];
        }

        $storedSettings = $this->getSettings()->getAttributes();

        if (isset($storedSettings['loginProviders'][$providerHandle]['oauth'][$key])) {
            return $storedSettings['loginProviders'][$providerHandle]['oauth'][$key];
        }

        return [];
    }

    /**
     * Set plugin components.
     */
    private function _setPluginComponents()
    {
        $this->setComponents([
            'loginAccounts' => \modules\social\services\LoginAccounts::class,
            'loginProviders' => \modules\social\services\LoginProviders::class,
        ]);
    }

    /**
     * Register CP routes.
     */
    private function _registerCpRoutes()
    {
        Event::on(UrlManager::class, UrlManager::EVENT_REGISTER_CP_URL_RULES, function(RegisterUrlRulesEvent $event) {
            $rules = [
                'depotise-social' => 'depotise-social/login-accounts/index',

                'depotise-social/loginaccounts' => 'depotise-social/loginAccounts/index',
                'depotise-social/loginaccounts/<userId:\d+>' => 'depotise-social/login-accounts/edit',

                'settings/depotise-social' => 'depotise-social/login-providers/index',
                'settings/depotise-social/loginproviders' => 'depotise-social/login-providers/index',
                'settings/depotise-social/loginproviders/<handle:{handle}>' => 'depotise-social/login-providers/oauth',
                'settings/depotise-social/loginproviders/<handle:{handle}>/user-field-mapping' => 'depotise-social/login-providers/user-field-mapping',
                'settings/depotise-social/settings' => 'depotise-social/settings/settings',
            ];

            $event->rules = array_merge($event->rules, $rules);
        });
    }

    /**
     * Register Social template variable.
     */
    private function _registerVariable()
    {
        Event::on(CraftVariable::class, CraftVariable::EVENT_INIT, function(Event $event) {
            /** @var CraftVariable $variable */
            $variable = $event->sender;
            $variable->set('depotiseSocial', SocialVariable::class);
        });
    }

    /**
     * Register Social user table attributes.
     */
    private function _registerTableAttributes()
    {
        Event::on(User::class, User::EVENT_REGISTER_TABLE_ATTRIBUTES, function(RegisterElementTableAttributesEvent $event) {
            $event->tableAttributes['loginAccounts'] = Craft::t('depotise-social', 'Login Accounts');
        });

        Event::on(User::class, User::EVENT_SET_TABLE_ATTRIBUTE_HTML, function(SetElementTableAttributeHtmlEvent $event) {
            if ($event->attribute === 'loginAccounts') {
                Craft::$app->getView()->registerAssetBundle(SocialAsset::class);

                $user = $event->sender;

                $loginAccounts = LoginAccount::find()
                    ->userId($user->id)
                    ->trashed($user->trashed)
                    ->all();

                if ($loginAccounts) {
                    $event->html = Craft::$app->getView()->renderTemplate('depotise-social/_components/users/login-accounts-table-attribute', [
                        'loginAccounts' => $loginAccounts,
                    ]);
                } else {
                    $event->html = '';
                }
            }
        });
    }

    /**
     * Register event handlers.
     */
    private function _registerEventHandlers()
    {
        Event::on(User::class, User::EVENT_AFTER_SAVE, function(ModelEvent $event) {
            $user = $event->sender;
            $loginAccounts = Plugin::getInstance()->getLoginAccounts()->getLoginAccountsByUserId($user->id);

            foreach ($loginAccounts as $loginAccount) {
                Craft::$app->elements->saveElement($loginAccount);
            }
        });

        // Soft delete the related login accounts after deleting a user
        Event::on(User::class, User::EVENT_AFTER_DELETE, function(Event $event) {
            $user = $event->sender;

            $loginAccounts = LoginAccount::find()
                ->userId($user->id)
                ->all();

            foreach($loginAccounts as $loginAccount) {
                Craft::$app->getElements()->deleteElement($loginAccount);
            }
        });

        // Make sure there’s no duplicate login account before restoring the user
        Event::on(User::class, User::EVENT_BEFORE_RESTORE, function(ModelEvent $event) {
            $user = $event->sender;

            // Get the login accounts of the user that’s being restored
            $loginAccounts = LoginAccount::find()
                ->userId($user->id)
                ->trashed(true)
                ->all();

            $conflicts = false;

            // Check that those login accounts don’t conflict with existing login accounts from other users
            foreach ($loginAccounts as $loginAccount) {
                // Check if there is another user with a login account using the same providerHandle/socialUid combo
                $existingAccount = LoginAccount::find([
                    'providerHandle' => $loginAccount['providerHandle'],
                    'socialUid' => $loginAccount['socialUid']
                ])->one();

                if ($existingAccount) {
                    $conflicts = true;
                }
            }

            // Mark the event as invalid is there are conflicts
            if ($conflicts) {
                $event->isValid = false;
                return false;
            }

            // Restore login account elements
            foreach($loginAccounts as $loginAccount) {
                Craft::$app->getElements()->restoreElement($loginAccount);
            }
        });

        // Initialize Social Login for CP after loading the plugins
        Event::on(Plugins::class, Plugins::EVENT_AFTER_LOAD_PLUGINS, function() {
            $this->initCpSocialLogin();
        });
    }
}
