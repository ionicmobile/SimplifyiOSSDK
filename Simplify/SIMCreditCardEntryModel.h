#import "SIMCreditCardNetwork.h"
#import "SIMCreditCardValidator.h"
#import "SIMTextFieldState.h"
#import "SIMCreditCardEntryControl.h"

@interface SIMCreditCardEntryModel : NSObject

- (id)initWithCreditCardNetwork:(SIMCreditCardNetwork *)creditCardNetwork
            creditCardValidator:(SIMCreditCardValidator *)creditCardValidator;

- (SIMTextFieldState *)stateForControl:(SIMCreditCardEntryControl)control withInput:(NSString *)input;

- (SIMCreditCardType)creditCardType;

- (BOOL)canSendCreditCard;

- (SIMCreditCardToken *)sendForCreditCardToken;

@end
