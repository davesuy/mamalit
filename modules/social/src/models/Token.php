<?php


namespace modules\social\models;

use craft\base\Model;

/**
 * Token model class.
 *
 *
 * @since   2.0
 */
class Token extends Model
{
    /**
     * @var string|null Provider handle
     */
    public $providerHandle;

    /**
     * @var mixed|null Token
     */
    public $token;
}
