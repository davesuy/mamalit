<?php


namespace modules\social\events;

use modules\social\base\LoginProvider;
use yii\base\Event;

/**
 * LoginAccountEvent class.
 *
 * @author Dukt <support@dukt.net>
 * @since  2.0
 */
class LoginAccountEvent extends Event
{
    // Properties
    // =========================================================================

    /**
     * @var LoginProvider|null The login provider associated with the event.
     */
    public $loginProvider;

    /**
     * @var ResourceOwnerInterface|array|null The profile associated with the event.
     */
    public $profile;

    /**
     * @var User|null The user model associated with the event.
     */
    public $user;
}
