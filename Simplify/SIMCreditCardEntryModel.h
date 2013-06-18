#import "SIMCreditCardNetwork.h"
#import "SIMCreditCardValidator.h"
#import "SIMTextFieldState.h"

@interface SIMCreditCardEntryModel : NSObject

typedef enum {
	SIMCreditCardEntryControlCreditCardNumber,
	SIMCreditCardEntryControlCVCNumber,
	SIMCreditCardEntryControlExpirationDate
} SIMCreditCardEntryControl;

- (id)initWithCreditCardNetwork:(SIMCreditCardNetwork *)creditCardNetwork
            creditCardValidator:(SIMCreditCardValidator *)creditCardValidator;

- (SIMTextFieldState*)stateForControl:(SIMCreditCardEntryControl)control withInput:(NSString *)input;

- (SIMCreditCardType)creditCardType;

- (BOOL)canSendCreditCard;

- (SIMCreditCardToken *)sendForCreditCardToken;

@end
