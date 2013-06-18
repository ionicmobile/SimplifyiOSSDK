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

- (SIMTextFieldState*)stateForControl:(SIMCreditCardEntryControl)control withInput:(NSString *)input {
	SIMTextFieldState *result = nil;
	switch (control) {
		case SIMCreditCardEntryControlCreditCardNumber:
			[self.creditCardValidator setCardNumberAsString:input];
			result = [[SIMTextFieldState alloc] initWithText:self.creditCardValidator.formattedCardNumber inputState:[self creditCardNumberInputState]];
			break;
		case SIMCreditCardEntryControlCVCNumber:
			[self.creditCardValidator setCVCCodeAsString:input];
			result = [[SIMTextFieldState alloc] initWithText:self.creditCardValidator.formattedCVCCode inputState:[self cvcNumberInputState]];
			break;
		case SIMCreditCardEntryControlExpirationDate:
			[self.creditCardValidator setExpirationAsString:input];
			result = [[SIMTextFieldState alloc] initWithText:self.creditCardValidator.formattedExpirationDate inputState:[self expirationDateInputState]];
			break;
		default:
			break;
	}
	return result;
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

- (SIMCreditCardToken *)sendForCreditCardToken {
	NSError *error = nil;
	NSString *creditCardNumber = [self.creditCardValidator.formattedCardNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSString *expirationMonth = self.creditCardValidator.expirationMonth;
	NSString *expirationYear = self.creditCardValidator.expirationYear;
	NSString *cvcNumber = self.creditCardValidator.formattedCVCCode;
	SIMCreditCardToken *cardToken = [self.creditCardNetwork createCardTokenWithExpirationMonth:expirationMonth
																				expirationYear:expirationYear
																					cardNumber:creditCardNumber
																						   cvc:cvcNumber
																						 error:&error];
	return cardToken;
}

@end
