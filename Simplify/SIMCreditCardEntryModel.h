#import "SIMCreditCardNetwork.h"
#import "SIMCreditCardValidator.h"
#import "SIMTextInputState.h"

#define SIMCreditCardEntryModelCreditCardNumberChanged @"SIMCreditCardEntryModelCreditCardNumberChanged"
#define SIMCreditCardEntryModelCVCNumberChanged @"SIMCreditCardEntryModelCVCNumberChanged"
#define SIMCreditCardEntryModelExpirationDateChanged @"SIMCreditCardEntryModelExpirationDateChanged"

@interface SIMCreditCardEntryModel : NSObject

- (id)initWithCreditCardNetwork:(SIMCreditCardNetwork *)creditCardNetwork
            creditCardValidator:(SIMCreditCardValidator *)creditCardValidator;

// View Display Information
- (SIMCreditCardType)creditCardType;

- (NSString *)creditCardNumberDisplay;
- (SIMTextInputState)creditCardNumberInputState;

- (NSString *)cvcNumberDisplay;
- (SIMTextInputState)cvcNumberInputState;

- (NSString *)expirationDateDisplay;
- (SIMTextInputState)expirationDateInputState;

- (BOOL)canSendCreditCard;

// View Input methods
- (void)creditCardNumberInput:(NSString *)input;
- (void)cvcNumberInput:(NSString *)input;
- (void)expirationDateInput:(NSString *)input;
- (void)sendCreditCard;

@end
