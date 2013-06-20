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

#import "SIMAbstractTestCase.h"
#import "SIMCreditCardEntryModel.h"

@interface SIMCreditCardEntryModelTest : SIMAbstractTestCase {
	id creditCardNetwork;
	id creditCardValidator;
	SIMCreditCardEntryModel *testObject;
}
@end

@implementation SIMCreditCardEntryModelTest

- (void)setUp {
	[super setUp];
	creditCardNetwork = [OCMockObject niceMockForClass:SIMCreditCardNetwork.class];
	creditCardValidator = [OCMockObject niceMockForClass:SIMCreditCardValidator.class];
	testObject = [[SIMCreditCardEntryModel alloc] initWithCreditCardNetwork:creditCardNetwork creditCardValidator:creditCardValidator];
}

- (void)tearDown {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super tearDown];
}

- (void)testCreditCardType_DelegatesToValidator {
	[[[creditCardValidator stub] andReturnValue:[NSNumber numberWithInt:SIMCreditCardType_ChinaUnionPay]] cardType];
	
	GHAssertEquals(testObject.creditCardType, SIMCreditCardType_ChinaUnionPay, nil);
}

- (void)testStateForControl_WhereControlIsCreditCardNumber_SetsCardNumberOnValidatorAndReturnsFormattedText {
	NSString *input = @"111122223333";
	NSString *expectedText = @"1111 2222 3333 ";
	[[[creditCardValidator expect] andDo:^(NSInvocation *invocation) {
		[[[creditCardValidator stub] andReturn:expectedText] formattedCardNumber];
	}] setCardNumberAsString:input];
	
	SIMTextFieldState *result = [testObject stateForControl:SIMCreditCardEntryControlCreditCardNumber withInput:input];
	
	[creditCardValidator verify];
	GHAssertEqualStrings(result.text, expectedText, nil);
}

- (void)testCreditCardNumberInputState_IsBad_WhenMaxLengthAndInvalid {
	[[[creditCardValidator stub] andReturnValue:@YES] isMaximumCardNumberLength];
	[[[creditCardValidator stub] andReturnValue:@NO] isValidCardNumber];
	
	SIMTextFieldState *result = [testObject stateForControl:SIMCreditCardEntryControlCreditCardNumber withInput:@""];
	
	GHAssertEquals(result.inputState, SIMTextInputStateBad, nil);
}

- (void)testCreditCardNumberInputState_IsNormal_WhenNotMaxLengthAndValid {
	[[[creditCardValidator stub] andReturnValue:@NO] isMaximumCardNumberLength];
	[[[creditCardValidator stub] andReturnValue:@YES] isValidCardNumber];
	
	SIMTextFieldState *result = [testObject stateForControl:SIMCreditCardEntryControlCreditCardNumber withInput:@""];
	
	GHAssertEquals(result.inputState, SIMTextInputStateNormal, nil);
}

- (void)testCreditCardNumberInputState_IsNormal_WhenNotMaxLengthAndInvalid {
	[[[creditCardValidator stub] andReturnValue:@NO] isMaximumCardNumberLength];
	[[[creditCardValidator stub] andReturnValue:@NO] isValidCardNumber];
	
	SIMTextFieldState *result = [testObject stateForControl:SIMCreditCardEntryControlCreditCardNumber withInput:@""];
	
	GHAssertEquals(result.inputState, SIMTextInputStateNormal, nil);
}

- (void)testCreditCardNumberInputState_IsGood_WhenMaxLengthAndValid {
	[[[creditCardValidator stub] andReturnValue:@YES] isMaximumCardNumberLength];
	[[[creditCardValidator stub] andReturnValue:@YES] isValidCardNumber];
	
	SIMTextFieldState *result = [testObject stateForControl:SIMCreditCardEntryControlCreditCardNumber withInput:@""];
	
	GHAssertEquals(result.inputState, SIMTextInputStateGood, nil);
}

- (void)testStateForControl_WhereControlIsCVCNumber_SetsCardNumberOnValidatorAndReturnsFormattedText {
	NSString *input = @"123";
	NSString *expectedText = @"abc";
	[[[creditCardValidator expect] andDo:^(NSInvocation *invocation) {
		[[[creditCardValidator stub] andReturn:expectedText] formattedCVCCode];
	}] setCVCCodeAsString:input];
	
	SIMTextFieldState *result = [testObject stateForControl:SIMCreditCardEntryControlCVCNumber withInput:input];
	
	[creditCardValidator verify];
	GHAssertEqualStrings(result.text, expectedText, nil);
}

- (void)testCVCNumberInputState_IsBad_WhenMaxLengthAndInvalid {
	[[[creditCardValidator stub] andReturnValue:@YES] isMaximumCVCLength];
	[[[creditCardValidator stub] andReturnValue:@NO] isValidCVC];
	
	SIMTextFieldState *result = [testObject stateForControl:SIMCreditCardEntryControlCVCNumber withInput:@""];
	
	GHAssertEquals(result.inputState, SIMTextInputStateBad, nil);
}

- (void)testCVCNumberInputState_IsNormal_WhenNotMaxLengthAndValid {
	[[[creditCardValidator stub] andReturnValue:@NO] isMaximumCVCLength];
	[[[creditCardValidator stub] andReturnValue:@YES] isValidCVC];
	
	SIMTextFieldState *result = [testObject stateForControl:SIMCreditCardEntryControlCVCNumber withInput:@""];
	
	GHAssertEquals(result.inputState, SIMTextInputStateNormal, nil);
}

- (void)testCVCNumberInputState_IsNormal_WhenNotMaxLengthAndInvalid {
	[[[creditCardValidator stub] andReturnValue:@NO] isMaximumCVCLength];
	[[[creditCardValidator stub] andReturnValue:@NO] isValidCVC];
	
	SIMTextFieldState *result = [testObject stateForControl:SIMCreditCardEntryControlCVCNumber withInput:@""];
	
	GHAssertEquals(result.inputState, SIMTextInputStateNormal, nil);
}

- (void)testCVCNumberInputState_IsGood_WhenMaxLengthAndValid {
	[[[creditCardValidator stub] andReturnValue:@YES] isMaximumCVCLength];
	[[[creditCardValidator stub] andReturnValue:@YES] isValidCVC];
	
	SIMTextFieldState *result = [testObject stateForControl:SIMCreditCardEntryControlCVCNumber withInput:@""];
	
	GHAssertEquals(result.inputState, SIMTextInputStateGood, nil);
}

- (void)testStateForControl_WhereControlIsExpirationDate_SetsCardNumberOnValidatorAndReturnsFormattedText {
	NSString *input = @"12/12";
	NSString *expectedText = @"12/12";
	[[[creditCardValidator expect] andDo:^(NSInvocation *invocation) {
		[[[creditCardValidator stub] andReturn:expectedText] formattedExpirationDate];
	}] setExpirationAsString:input];
	
	SIMTextFieldState *result = [testObject stateForControl:SIMCreditCardEntryControlExpirationDate withInput:input];
	
	[creditCardValidator verify];
	GHAssertEqualStrings(result.text, expectedText, nil);
}

- (void)testExpirationDateInputState_IsGood_WhenNotExpired {
	[[[creditCardValidator stub] andReturnValue:@NO] isExpired];
	
	SIMTextFieldState *result = [testObject stateForControl:SIMCreditCardEntryControlExpirationDate withInput:@""];
	
	GHAssertEquals(result.inputState, SIMTextInputStateGood, nil);
}

- (void)testExpirationDateInputState_IsBad_WhenExpired {
	[[[creditCardValidator stub] andReturnValue:@YES] isExpired];
	
	SIMTextFieldState *result = [testObject stateForControl:SIMCreditCardEntryControlExpirationDate withInput:@""];
	
	GHAssertEquals(result.inputState, SIMTextInputStateBad, nil);
}

- (void)testCanSendCreditCard_ReturnsYES_IfEverythingIsValid {
	[[[creditCardValidator stub] andReturnValue:@YES] isMaximumCardNumberLength];
	[[[creditCardValidator stub] andReturnValue:@YES] isValidCardNumber];
	[[[creditCardValidator stub] andReturnValue:@YES] isMaximumCVCLength];
	[[[creditCardValidator stub] andReturnValue:@YES] isValidCVC];
	[[[creditCardValidator stub] andReturnValue:@NO] isExpired];
	
	GHAssertTrue(testObject.canSendCreditCard, nil);
}

- (void)testCanSendCreditCard_ReturnsNO_IfEverythingIsValidExceptButCardNumber {
	[[[creditCardValidator stub] andReturnValue:@NO] isMaximumCardNumberLength];
	[[[creditCardValidator stub] andReturnValue:@YES] isValidCardNumber];
	[[[creditCardValidator stub] andReturnValue:@YES] isMaximumCVCLength];
	[[[creditCardValidator stub] andReturnValue:@YES] isValidCVC];
	[[[creditCardValidator stub] andReturnValue:@NO] isExpired];
	
	GHAssertFalse(testObject.canSendCreditCard, nil);
}

- (void)testCanSendCreditCard_ReturnsNO_IfEverythingIsValidExceptCVC {
	[[[creditCardValidator stub] andReturnValue:@YES] isMaximumCardNumberLength];
	[[[creditCardValidator stub] andReturnValue:@YES] isValidCardNumber];
	[[[creditCardValidator stub] andReturnValue:@YES] isMaximumCVCLength];
	[[[creditCardValidator stub] andReturnValue:@NO] isValidCVC];
	[[[creditCardValidator stub] andReturnValue:@NO] isExpired];
	
	GHAssertFalse(testObject.canSendCreditCard, nil);
}

- (void)testCanSendCreditCard_ReturnsNO_IfEverythingIsValidExceptExpired {
	[[[creditCardValidator stub] andReturnValue:@YES] isMaximumCardNumberLength];
	[[[creditCardValidator stub] andReturnValue:@YES] isValidCardNumber];
	[[[creditCardValidator stub] andReturnValue:@YES] isMaximumCVCLength];
	[[[creditCardValidator stub] andReturnValue:@YES] isValidCVC];
	[[[creditCardValidator stub] andReturnValue:@YES] isExpired];
	
	GHAssertFalse(testObject.canSendCreditCard, nil);
}

- (void)testSendCreditCard_UsesNetwork {
    NSError* error = nil;
	id address = [OCMockObject niceMockForClass:SIMAddress.class];
	id cardToken = [OCMockObject niceMockForClass:SIMCreditCardToken.class];
	[[[creditCardValidator stub] andReturn:@"11"] expirationMonth];
	[[[creditCardValidator stub] andReturn:@"13"] expirationYear];
	[[[creditCardValidator stub] andReturn:@"1111 2222 3333 4444"] formattedCardNumber];
	[[[creditCardValidator stub] andReturn:@"123"] formattedCVCCode];
	[[[creditCardNetwork expect] andReturn:cardToken] createCardTokenWithExpirationMonth:@"11"
																		  expirationYear:@"13"
																			  cardNumber:@"1111222233334444"
																					 cvc:@"123"
																				 address:address
																				   error:[OCMArg setTo:nil]];
	
	[testObject sendForCreditCardTokenUsingAddress:address error:&error];
	
	[creditCardNetwork verify];
}

@end
