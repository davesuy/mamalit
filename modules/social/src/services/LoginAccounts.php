<?php


namespace modules\social\services;

use Craft;
use craft\elements\User;
use craft\helpers\FileHelper;
use modules\social\errors\ImageTypeException;
use modules\social\errors\LoginAccountNotFoundException;
use modules\social\helpers\SocialHelper;
use modules\social\Plugin;
use yii\base\Component;
use craft\elements\User as UserModel;
use modules\social\elements\LoginAccount;
use modules\social\records\LoginAccount as LoginAccountRecord;
use craft\helpers\UrlHelper;

/**
 * The LoginAccounts service provides APIs for managing login accounts in Craft.
 *
 * An instance of the LoginAccounts service is globally accessible in Craft via [[Plugin::loginAccounts `Plugin::getInstance()->getLoginAccounts()`]].
 *
 *
 * @since   1.0
 */
class LoginAccounts extends Component
{
    // Public Methods
    // =========================================================================

    /**
     * Get all social accounts.
     *
     * @return array|null
     */
    public function getLoginAccounts()
    {
        return LoginAccount::find()->all();
    }

    /**
     * Get all of the social accounts for a given user id.
     *
     * @param $userId
     *
     * @return array|null
     */
    public function getLoginAccountsByUserId($userId)
    {
        return LoginAccount::find()->userId($userId)->all();
    }

    /**
     * Returns a social account from its ID.
     *
     * @param int $id
     *
     * @return LoginAccount|null
     */
    public function getLoginAccountById($id)
    {
        return Craft::$app->elements->getElementById($id);
    }

    /**
     * Get a social account by provider handle for the currently logged in user.
     *
     * @param string $providerHandle
     *
     * @return LoginAccount|null
     */
    public function getLoginAccountByLoginProvider($providerHandle)
    {
        $currentUser = Craft::$app->getUser()->getIdentity();

        // Check if there is a current user or not
        if (!$currentUser) {
            return false;
        }

        return LoginAccount::find()->userId($currentUser->id)->providerHandle($providerHandle)->one();
    }

    /**
     * Get a social account by social UID.
     *
     * @param string $providerHandle
     * @param string $socialUid
     *
     * @return LoginAccount|null
     */
    public function getLoginAccountByUid($providerHandle, $socialUid)
    {
        return LoginAccount::find()->providerHandle($providerHandle)->socialUid($socialUid)->one();
    }

    /**
     * Deletes a social account by provider.
     *
     * @param $providerHandle
     *
     * @return bool
     * @throws \Throwable
     */
    public function deleteLoginAccountByProvider($providerHandle): bool
    {
        $loginAccount = $this->getLoginAccountByLoginProvider($providerHandle);

        return $this->deleteLoginAccount($loginAccount);
    }

    /**
     * Deletes a social login account by its ID.
     *
     * @param int $id
     *
     * @return bool
     * @throws \Throwable
     */
    public function deleteLoginAccountById($id): bool
    {
        $loginAccount = $this->getLoginAccountById($id);

        return $this->deleteLoginAccount($loginAccount);
    }

    /**
     * Deletes a login account.
     *
     * @param LoginAccount $loginAccount
     *
     * @return bool
     * @throws \Throwable
     */
    public function deleteLoginAccount(LoginAccount $loginAccount): bool
    {
        Craft::$app->elements->deleteElement($loginAccount);

        return true;
    }

    /**
     * Get login URL.
     *
     * @param       $providerHandle
     * @param array $params
     *
     * @return string
     */
    public function getLoginUrl($providerHandle, array $params = []): string
    {
        $params['provider'] = $providerHandle;

        return SocialHelper::siteActionUrl('depotise-social/login-accounts/login', $params);
    }

    /**
     * Get link account URL.
     *
     * @param $handle
     *
     * @return string
     */
    public function getLoginAccountConnectUrl($handle): string
    {
        return UrlHelper::actionUrl('depotise-social/login-accounts/connect-login-account', [
            'provider' => $handle
        ]);
    }

    /**
     * Get unlink account URL.
     *
     * @param $handle
     *
     * @return string
     */
    public function getLoginAccountDisconnectUrl($handle): string
    {
        return UrlHelper::actionUrl('depotise-social/login-accounts/disconnect-login-account', [
            'provider' => $handle
        ]);
    }

    /**
     * Saves a remote photo.
     *
     * @param string $providerHandle
     * @param User $newUser
     * @param $profile
     * @throws \GuzzleHttp\Exception\GuzzleException
     * @throws \craft\errors\ImageException
     * @throws \craft\errors\VolumeException
     * @throws \yii\base\Exception
     */
    public function saveRemotePhoto(string $providerHandle, User $newUser, $profile)
    {
        $photoUrl = false;
        $loginProvider = Plugin::getInstance()->getLoginProviders()->getLoginProvider($providerHandle);
        $userFieldMapping = $loginProvider->getUserFieldMapping();

        if (isset($userFieldMapping['photo'])) {
            try {
                $photoUrl = html_entity_decode(Craft::$app->getView()->renderString($userFieldMapping['photo'], ['profile' => $profile]));
            } catch (\Exception $e) {
                Craft::warning('Could not map:' . print_r(['photo', $userFieldMapping['photo'], $profile, $e->getMessage()], true), __METHOD__);
            }
        }

        if ($photoUrl) {
            $this->_saveRemotePhoto($photoUrl, $newUser);
        }
    }

    /**
     * Save a remote photo.
     *
     * @param           $photoUrl
     * @param UserModel $user
     *
     * @return bool|void
     * @throws \GuzzleHttp\Exception\GuzzleException
     * @throws \craft\errors\ImageException
     * @throws \craft\errors\VolumeException
     * @throws \yii\base\Exception
     */
    private function _saveRemotePhoto($photoUrl, UserModel $user)
    {
        $filename = 'photo';

        $tempPath = Craft::$app->path->getTempPath() . '/social/userphotos/' . $user->email . '/';

        FileHelper::createDirectory($tempPath);

        $client = new \GuzzleHttp\Client();

        $response = $client->request('GET', $photoUrl, [
            'save_to' => $tempPath . $filename
        ]);

        if ($response->getStatusCode() !== 200) {
            return;
        }

        $contentTypes = $response->getHeader('Content-Type');

        if (is_array($contentTypes) && isset($contentTypes[0])) {
            switch ($contentTypes[0]) {
                case 'image/gif':
                    $extension = 'gif';
                    break;
                case 'image/jpeg':
                    $extension = 'jpg';
                    break;
                case 'image/png':
                    $extension = 'png';
                    break;
                case 'image/svg+xml':
                    $extension = 'svg';
                    break;

                default:
                    throw new ImageTypeException('Image type “' . $contentTypes[0] . '” not supported');
            }
        } else {
            throw new ImageTypeException('Image type not supported');
        }

        rename($tempPath . $filename, $tempPath . $filename . '.' . $extension);

        $image = Craft::$app->images->loadImage($tempPath . $filename . '.' . $extension);
        $imageWidth = $image->getWidth();
        $imageHeight = $image->getHeight();

        $dimension = min($imageWidth, $imageHeight);
        $horizontalMargin = ($imageWidth - $dimension) / 2;
        $verticalMargin = ($imageHeight - $dimension) / 2;
        $image->crop($horizontalMargin, $imageWidth - $horizontalMargin, $verticalMargin, $imageHeight - $verticalMargin);

        Craft::$app->users->saveUserPhoto($tempPath . $filename . '.' . $extension, $user, $filename . '.' . $extension);

        return true;
    }

    // Private Methods
    // =========================================================================

    /**
     * Gets a user record by its ID.
     *
     * @param int $loginAccountId
     *
     * @return LoginAccountRecord
     * @throws LoginAccountNotFoundException if $loginAccountId is invalid
     */
    private function _getLoginAccountRecordById(int $loginAccountId): LoginAccountRecord
    {
        $loginAccountRecord = LoginAccountRecord::findOne($loginAccountId);

        if (!$loginAccountRecord) {
            throw new LoginAccountNotFoundException("No login account exists with the ID '{$loginAccountId}'");
        }

        return $loginAccountRecord;
    }
}
