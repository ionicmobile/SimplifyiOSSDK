#import <UIKit/UIKit.h>
#import "SIMCreditCardToken.h"

/**
  The delegate that provides a callback once a credit card token (or error) was received from the server.
*/
@protocol SIMCreditCardEntryViewControllerDelegate <NSObject>

/**
 The user cancelled this attempt at credit card entry.
 */
- (void)cancelled;

/**
 The user finished sending a credit card to Simplify, and either an error or a SIMCreditCardToken was returned.
 */
- (void)receivedCreditCardToken:(SIMCreditCardToken *)creditCardToken error:(NSError *)error;

@end

/**
  The UIViewController subclass that provides a SIMCreditCardToken object, representing a credit card token from the Simplify server.
*/
@interface SIMCreditCardEntryViewController : UIViewController

/**
 To use this class, set yourself as the delegate so you receive notification when the user cancels or sends a credit card.
 */
@property (nonatomic, weak) id<SIMCreditCardEntryViewControllerDelegate>delegate;

/**
 Initializes a new SIMCreditCardEntryViewController. Make sure to set yourself as the delegate of this object!
 
 @param publicApiToken the public API token you received when signing up to the Simplify API.
 @param showAddressView shows entry information for a US address if true.
 */
- (id)initWithPublicApiToken:(NSString *)publicApiToken addressView:(BOOL)showAddressView;

@end
