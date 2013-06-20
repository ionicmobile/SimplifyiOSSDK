/* Copyright (c) 2013, Asynchrony Solutions, Inc.
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are met:
 *
 *    * Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *
 *    * Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *
 *    * Neither the name of Asynchrony Solutions, Inc. nor the
 *      names of its contributors may be used to endorse or promote products
 *      derived from this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 *  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 *  DISCLAIMED. IN NO EVENT SHALL ASYNCHRONY SOLUTIONS, INC. BE LIABLE FOR ANY
 *  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 *  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 *  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

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

- (SIMTextFieldState *)stateForControl:(SIMCreditCardEntryControl)control withInput:(NSString *)input {
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

- (SIMTextInputState)creditCardNumberInputState {
	return self.creditCardValidator.isMaximumCardNumberLength ? (self.creditCardValidator.isValidCardNumber ? SIMTextInputStateGood : SIMTextInputStateBad) : SIMTextInputStateNormal;
}

- (SIMTextInputState)cvcNumberInputState {
	return self.creditCardValidator.isMaximumCVCLength ? (self.creditCardValidator.isValidCVC ? SIMTextInputStateGood : SIMTextInputStateBad) : SIMTextInputStateNormal;
}

- (SIMTextInputState)expirationDateInputState {
	return [self.creditCardValidator isExpired] ? SIMTextInputStateBad : SIMTextInputStateGood;
}

- (BOOL)canSendCreditCard {
	return self.creditCardNumberInputState == SIMTextInputStateGood &&
			self.cvcNumberInputState == SIMTextInputStateGood &&
			self.expirationDateInputState == SIMTextInputStateGood;
}

- (SIMCreditCardToken *)sendForCreditCardTokenUsingAddress:(SIMAddress *)address error:(NSError **)error {
	NSString *creditCardNumber = [self.creditCardValidator.formattedCardNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSString *expirationMonth = self.creditCardValidator.expirationMonth;
	NSString *expirationYear = self.creditCardValidator.expirationYear;
	NSString *cvcNumber = self.creditCardValidator.formattedCVCCode;
	SIMCreditCardToken *cardToken = [self.creditCardNetwork createCardTokenWithExpirationMonth:expirationMonth
	                                                                            expirationYear:expirationYear
				                                                                    cardNumber:creditCardNumber
							                                                               cvc:cvcNumber
							                                                           address:address
									                                                     error:error];
	return cardToken;
}

@end
