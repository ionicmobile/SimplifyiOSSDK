#import "SIMCreditCardEntryModel.h"

@interface SIMCreditCardEntryModel ()
@property (nonatomic) SIMCreditCardNetwork *creditCardNetwork;
@property (nonatomic) SIMCreditCardValidator *creditCardValidator;
@end

@implementation SIMCreditCardEntryModel

- (id)initWithCreditCardNetwork:(SIMCreditCardNetwork *)creditCardNetwork
            creditCardValidator:(SIMCreditCardValidator *)creditCardValidator {
	if (self = [super init]) {
		self.creditCardNetwork = creditCardNetwork;
		self.creditCardValidator = creditCardValidator;
	}
	return self;
}

- (NSString *)creditCardNumberDisplay {
	return @"";
}

- (SIMTextInputState)creditCardNumberInputState {
	return SIMTextInputStateNormal;
}

- (NSString *)cvcNumberDisplay {
	return @"";
}

- (SIMTextInputState)cvcNumberInputState {
	return SIMTextInputStateNormal;
}

- (NSString *)expirationDateDisplay {
	return @"";
}

- (SIMTextInputState)expirationDateInputState {
	return SIMTextInputStateNormal;
}

-(void)creditCardNumberInput:(NSString *)input {
}

-(void)cvcNumberInput:(NSString *)input {
}

-(void)expirationDateInput:(NSString *)input {
}

-(BOOL)doneEnabled {
	return NO;
}

-(void)sendCreditCard {

}

@end
