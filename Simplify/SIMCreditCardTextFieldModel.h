#import "SIMTextFieldModel.h"
#import "SIMCreditCardType.h"
#import "SIMLuhnValidator.h"
#import "SIMCreditCardTypeValidator.h"

@interface SIMCreditCardTextFieldModel : SIMTextFieldModel
@property (nonatomic, readonly) SIMCreditCardType creditCardType;

- (id)initWithLuhnValidator:(SIMLuhnValidator*)luhnValidator
    creditCardTypeValidator:(SIMCreditCardTypeValidator*)creditCardTypeValidator;
@end
