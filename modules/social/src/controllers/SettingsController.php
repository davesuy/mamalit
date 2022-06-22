<?php


namespace modules\social\controllers;

use Craft;
use craft\web\Controller;
use modules\social\models\Settings;
use modules\social\Plugin;
use yii\web\Response;

/**
 * The SettingsController class is a controller that handles various settings related tasks.
 *
 * Note that all actions in the controller require an authenticated Craft session via [[allowAnonymous]].
 *
 *
 * @since   1.0
 */
class SettingsController extends BaseController
{
    // Public Methods
    // =========================================================================

    /**
     * General settings.
     *
     * @return Response
     * @throws \yii\base\InvalidConfigException
     */
    public function actionSettings(): Response
    {
        if (Craft::$app->getEdition() !== Craft::Pro) {
            return $this->renderTemplate('depotise-social/settings/_pro-requirement');
        }

        $variables['settings'] = Plugin::getInstance()->getSettings();

        $accounts = Plugin::getInstance()->getLoginAccounts()->getLoginAccounts();
        $variables['totalAccounts'] = count($accounts);

        return $this->renderTemplate('depotise-social/settings/settings', $variables);
    }

    /**
     * Saves the settings.
     *
     * @return null|Response
     * @throws \craft\errors\MissingComponentException
     * @throws \yii\web\BadRequestHttpException
     */
    public function actionSaveSettings()
    {
        $this->requirePostRequest();
        $settings = Craft::$app->getRequest()->getBodyParam('settings', []);

        if (!Plugin::getInstance()->savePluginSettings($settings)) {
            Craft::$app->getSession()->setError(Craft::t('app', 'Couldn’t save plugin settings.'));

            // Send the plugin back to the template
            Craft::$app->getUrlManager()->setRouteParams([

            ]);

            return null;
        }

        Craft::$app->getSession()->setNotice(Craft::t('app', 'Plugin settings saved.'));

        return $this->redirectToPostedUrl();
    }
}
