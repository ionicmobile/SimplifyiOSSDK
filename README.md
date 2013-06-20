SimplifyiOSSDK
==============

## Installation

To install the API in your app, copy the `Simplify.framework` and `Simplify.bundle` to your project.
Add both to your app target.

![ScreenShot](Docs/add_to_project.jpg)

## API

The two main classes that are used are `SIMCreditCardEntryViewController` and `SIMCreditCardToken`.  

### SIMCreditCardEntryViewController
The `SIMCreditCardEntryViewController` can be used for entering credit card and address details for a
transaction.

### SIMCreditCardToken
The `SIMCreditCardToken` is issued to the user by `SIMCreditCardEntryViewController` to a 
when a `SIMCreditCardEntryViewControllerDelegate` when a successful transaction has been processed.

