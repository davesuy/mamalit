<?php


namespace modules\social\events;

use modules\social\models\Token;
use yii\base\Event;

/**
 * OauthTokenEvent class.
 *
 * @author Dukt <support@dukt.net>
 * @since  2.0
 */
class OauthTokenEvent extends Event
{
    // Properties
    // =========================================================================

    /**
     * @var Token|null The OAuth token.
     */
    public $token;
}
