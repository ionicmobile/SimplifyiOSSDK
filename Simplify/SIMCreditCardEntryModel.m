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

- (SIMCreditCardType)creditCardType {
	return self.creditCardValidator.cardType;
}

- (NSString *)creditCardNumberDisplay {
	return self.creditCardValidator.formattedCardNumber;
}

- (SIMTextInputState)creditCardNumberInputState {
	return self.creditCardValidator.isMaximumCardNumberLength ? (self.creditCardValidator.isValidCardNumber ? SIMTextInputStateGood : SIMTextInputStateBad) : SIMTextInputStateNormal;
}

- (NSString *)cvcNumberDisplay {
	return self.creditCardValidator.formattedCVCCode;
}

- (SIMTextInputState)cvcNumberInputState {
	return self.creditCardValidator.isMaximumCVCLength ? (self.creditCardValidator.isValidCVC ? SIMTextInputStateGood : SIMTextInputStateBad) : SIMTextInputStateNormal;
}

- (NSString *)expirationDateDisplay {
	return [self.creditCardValidator formattedExpirationDate];
}

- (SIMTextInputState)expirationDateInputState {
	return [self.creditCardValidator isExpired] ? SIMTextInputStateBad : SIMTextInputStateGood;
}

- (BOOL)canSendCreditCard {
	return  self.creditCardNumberInputState == SIMTextInputStateGood &&
			self.cvcNumberInputState == SIMTextInputStateGood &&
			self.expirationDateInputState == SIMTextInputStateGood;
}

#pragma mark - View Input

-(void)creditCardNumberInput:(NSString *)input {
	[self.creditCardValidator setCardNumberAsString:input];
	[[NSNotificationCenter defaultCenter] postNotificationName:SIMCreditCardEntryModelCreditCardNumberChanged object:self];
}

-(void)cvcNumberInput:(NSString *)input {
	[self.creditCardValidator setCVCCodeAsString:input];
	[[NSNotificationCenter defaultCenter] postNotificationName:SIMCreditCardEntryModelCVCNumberChanged object:self];
}

-(void)expirationDateInput:(NSString *)input {
	[self.creditCardValidator setExpirationAsString:input];
	[[NSNotificationCenter defaultCenter] postNotificationName:SIMCreditCardEntryModelExpirationDateChanged object:self];
}

-(void)sendCreditCard {
	NSError *error = nil;
	NSString *creditCardNumber = [self.creditCardValidator.formattedCardNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSString *expirationMonth = self.creditCardValidator.expirationMonth;
	NSString *expirationYear = self.creditCardValidator.expirationYear;
	NSString *cvcNumber = self.creditCardValidator.formattedCVCCode;
	SIMCardToken *cardToken = [self.creditCardNetwork createCardTokenWithExpirationMonth:expirationMonth
	                                                                      expirationYear:expirationYear
				                                                              cardNumber:creditCardNumber
							                                                         cvc:cvcNumber
							                                                       error:&error];
	NSLog(@"Card Token: %@", cardToken);
}

@end
