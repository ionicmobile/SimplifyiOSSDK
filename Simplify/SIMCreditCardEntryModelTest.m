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
	id cardToken = [OCMockObject niceMockForClass:SIMCreditCardToken.class];
	[[[creditCardValidator stub] andReturn:@"11"] expirationMonth];
	[[[creditCardValidator stub] andReturn:@"13"] expirationYear];
	[[[creditCardValidator stub] andReturn:@"1111 2222 3333 4444"] formattedCardNumber];
	[[[creditCardValidator stub] andReturn:@"123"] formattedCVCCode];
	[[[creditCardNetwork expect] andReturn:cardToken]
			createCardTokenWithExpirationMonth:@"11"
								expirationYear:@"13"
									cardNumber:@"1111222233334444"
										   cvc:@"123"
										 error:[OCMArg setTo:nil]];

	[testObject sendForCreditCardToken];

	[creditCardNetwork verify];
}

@end
