# Depotise module for Craft CMS 3.x

online hardware shop

## Requirements

This module requires Craft CMS 3.0.0-RC1 or later.

## Installation

To install the module, follow these instructions.

First, you'll need to add the contents of the `app.php` file to your `config/app.php` (or just copy it there if it does not exist). This ensures that your module will get loaded for each request. The file might look something like this:
```
return [
    'modules' => [
        'depotise-module' => [
            'class' => \modules\depotisemodule\DepotiseModule::class,
            'components' => [
                'depotiseModuleService' => [
                    'class' => 'modules\depotisemodule\services\DepotiseModuleService',
                ],
            ],
        ],
    ],
    'bootstrap' => ['depotise-module'],
];
```
You'll also need to make sure that you add the following to your project's `composer.json` file so that Composer can find your module:

    "autoload": {
        "psr-4": {
          "modules\\depotisemodule\\": "modules/depotisemodule/src/"
        }
    },

After you have added this, you will need to do:

    composer dump-autoload
 
 …from the project’s root directory, to rebuild the Composer autoload map. This will happen automatically any time you do a `composer install` or `composer update` as well.

## Depotise Overview

-Insert text here-

## Using Depotise

-Insert text here-

## Depotise Roadmap

Some things to do, and ideas for potential features:

* Release it

Brought to you by [Dale](https://github.com/pdaleramirez)
