#import <UIKit/UIKit.h>
#import "SIMCreditCardToken.h"

@protocol SIMCreditCardEntryViewControllerDelegate <NSObject>

- (void)receivedCreditCardToken:(SIMCreditCardToken *)creditCardToken;

@end

@interface SIMCreditCardEntryViewController : UIViewController

@property (nonatomic, weak) id<SIMCreditCardEntryViewControllerDelegate>delegate;

- (id)initWithAddressView:(BOOL)showAddressView;

@end
