#import <UIKit/UIKit.h>
#import "SIMCreditCardToken.h"

/**
  The delegate that provides a callback once a credit card token (or error) was received from the server.
*/
@protocol SIMCreditCardEntryViewControllerDelegate <NSObject>

- (void)cancelled;
- (void)receivedCreditCardToken:(SIMCreditCardToken *)creditCardToken error:(NSError *)error;

@end

/**
  The UIViewController subclass that provides
*/
@interface SIMCreditCardEntryViewController : UIViewController

@property (nonatomic, weak) id<SIMCreditCardEntryViewControllerDelegate>delegate;

- (id)initWithPublicApiToken:(NSString *)publicApiToken addressView:(BOOL)showAddressView;

@end
