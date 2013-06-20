#import <UIKit/UIKit.h>
#import "SIMCreditCardToken.h"

@protocol SIMCreditCardEntryViewControllerDelegate <NSObject>

- (void)receivedCreditCardToken:(SIMCreditCardToken *)creditCardToken error:(NSError *)error;

@end

@interface SIMCreditCardEntryViewController : UIViewController

@property (nonatomic, weak) id<SIMCreditCardEntryViewControllerDelegate>delegate;

- (id)initWithPublicApiToken:(NSString *)publicApiToken addressView:(BOOL)showAddressView;

@end
