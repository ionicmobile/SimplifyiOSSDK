#import "SIMCreditCardNetwork.h"
#import "SIMCreditCardValidator.h"
#import "SIMTextInputState.h"

#define SIMCreditCardEntryModelCreditCardNumberChanged @"SIMCreditCardEntryModelCreditCardNumberChanged"
#define SIMCreditCardEntryModelCVCNumberChanged @"SIMCreditCardEntryModelCVCNumberChanged"
#define SIMCreditCardEntryModelExpirationDateChanged @"SIMCreditCardEntryModelExpirationDateChanged"
#define SIMCreditCardEntryModelDoneEnabledChanged @"SIMCreditCardEntryModelDoneEnabledChanged"

@interface SIMCreditCardEntryModel : NSObject

- (id)initWithCreditCardNetwork:(SIMCreditCardNetwork *)creditCardNetwork
            creditCardValidator:(SIMCreditCardValidator *)creditCardValidator;

- (NSString *)creditCardNumberDisplay;
- (SIMTextInputState)creditCardNumberInputState;
- (NSString *)cvcNumberDisplay;
- (SIMTextInputState)cvcNumberInputState;
- (NSString *)expirationDateDisplay;
- (SIMTextInputState)expirationDateInputState;

-(void)creditCardNumberInput:(NSString *)input;
-(void)cvcNumberInput:(NSString *)input;
-(void)expirationDateInput:(NSString *)input;

-(BOOL)doneEnabled;
-(void)sendCreditCard;

@end
