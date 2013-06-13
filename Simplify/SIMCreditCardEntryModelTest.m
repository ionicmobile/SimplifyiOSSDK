#import "SIMAbstractTestCase.h"
#import "SIMCreditCardEntryModel.h"

@interface SIMCreditCardEntryModelTest : SIMAbstractTestCase {
	id creditCardNetwork;
	id creditCardValidator;
	SIMCreditCardEntryModel *testObject;

	int creditCardNumberDisplayChangedNotification;
	int cvcNumberDisplayChangedNotification;
	int expirationDateDisplayChangedNotification;
}
@end

@implementation SIMCreditCardEntryModelTest

- (void)setUp {
	[super setUp];
	creditCardNetwork = [OCMockObject niceMockForClass:SIMCreditCardNetwork.class];
	creditCardValidator = [OCMockObject niceMockForClass:SIMCreditCardValidator.class];
	testObject = [[SIMCreditCardEntryModel alloc] initWithCreditCardNetwork:creditCardNetwork creditCardValidator:creditCardValidator];

	creditCardNumberDisplayChangedNotification = 0;
	cvcNumberDisplayChangedNotification = 0;
	expirationDateDisplayChangedNotification = 0;

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(creditCardNumberDisplayChanged) name:SIMCreditCardEntryModelCreditCardNumberChanged object:testObject];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cvcNumberDisplayChanged) name:SIMCreditCardEntryModelCVCNumberChanged object:testObject];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(expirationDateDisplayChanged) name:SIMCreditCardEntryModelExpirationDateChanged object:testObject];
}

- (void)tearDown {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super tearDown];
}

- (void)creditCardNumberDisplayChanged {
	creditCardNumberDisplayChangedNotification++;
}
- (void)cvcNumberDisplayChanged {
	cvcNumberDisplayChangedNotification++;
}
- (void)expirationDateDisplayChanged {
	expirationDateDisplayChangedNotification++;
}

- (void)testCreditCardType_DelegatesToValidator {
	[[[creditCardValidator stub] andReturnValue:[NSNumber numberWithInt:SIMCreditCardType_ChinaUnionPay]] cardType];

	GHAssertEquals(testObject.creditCardType, SIMCreditCardType_ChinaUnionPay, nil);
}

- (void)testSetCreditCardNumberInput_PostsNotification_SetsCardNumberOnValidator {
	NSString *creditCardNumberInput = @"111122223333";
	NSString *expectedFormattedText = @"1111 2222 3333 ";
	GHAssertEquals(creditCardNumberDisplayChangedNotification, 0, nil);
	[[[creditCardValidator expect] andDo:^(NSInvocation *invocation) {
		[[[creditCardValidator stub] andReturn:expectedFormattedText] formattedCardNumber];
	}] setCardNumberAsString:creditCardNumberInput];

	[testObject creditCardNumberInput:creditCardNumberInput];

	[creditCardValidator verify];
	GHAssertEquals(creditCardNumberDisplayChangedNotification, 1, nil);
	GHAssertEqualStrings(testObject.creditCardNumberDisplay, expectedFormattedText, nil);
}

- (void)testCreditCardNumberInputState_IsBad_WhenMaxLengthAndInvalid {
	[[[creditCardValidator stub] andReturnValue:@YES] isMaximumCardNumberLength];
	[[[creditCardValidator stub] andReturnValue:@NO] isValidCardNumber];

	GHAssertEquals(testObject.creditCardNumberInputState, SIMTextInputStateBad, nil);
}

- (void)testCreditCardNumberInputState_IsNormal_WhenNotMaxLengthAndValid {
	[[[creditCardValidator stub] andReturnValue:@NO] isMaximumCardNumberLength];
	[[[creditCardValidator stub] andReturnValue:@YES] isValidCardNumber];

	GHAssertEquals(testObject.creditCardNumberInputState, SIMTextInputStateNormal, nil);
}

- (void)testCreditCardNumberInputState_IsNormal_WhenNotMaxLengthAndInvalid {
	[[[creditCardValidator stub] andReturnValue:@NO] isMaximumCardNumberLength];
	[[[creditCardValidator stub] andReturnValue:@NO] isValidCardNumber];

	GHAssertEquals(testObject.creditCardNumberInputState, SIMTextInputStateNormal, nil);
}

- (void)testCreditCardNumberInputState_IsGood_WhenMaxLengthAndValid {
	[[[creditCardValidator stub] andReturnValue:@YES] isMaximumCardNumberLength];
	[[[creditCardValidator stub] andReturnValue:@YES] isValidCardNumber];

	GHAssertEquals(testObject.creditCardNumberInputState, SIMTextInputStateGood, nil);
}

- (void)testSetCVCNumberInput_PostsNotification_SetsCVCOnValidator {
	NSString *input = @"123";
	NSString *expectedFormattedText = @"123";
	GHAssertEquals(cvcNumberDisplayChangedNotification, 0, nil);
	[[[creditCardValidator expect] andDo:^(NSInvocation *invocation) {
		[[[creditCardValidator stub] andReturn:expectedFormattedText] formattedCVCCode];
	}] setCVCCodeAsString:input];

	[testObject cvcNumberInput:input];

	[creditCardValidator verify];
	GHAssertEquals(cvcNumberDisplayChangedNotification, 1, nil);
	GHAssertEqualStrings(testObject.cvcNumberDisplay, expectedFormattedText, nil);
}

- (void)testCVCNumberInputState_IsBad_WhenMaxLengthAndInvalid {
	[[[creditCardValidator stub] andReturnValue:@YES] isMaximumCVCLength];
	[[[creditCardValidator stub] andReturnValue:@NO] isValidCVC];

	GHAssertEquals(testObject.cvcNumberInputState, SIMTextInputStateBad, nil);
}

- (void)testCVCNumberInputState_IsNormal_WhenNotMaxLengthAndValid {
	[[[creditCardValidator stub] andReturnValue:@NO] isMaximumCVCLength];
	[[[creditCardValidator stub] andReturnValue:@YES] isValidCVC];

	GHAssertEquals(testObject.cvcNumberInputState, SIMTextInputStateNormal, nil);
}

- (void)testCVCNumberInputState_IsNormal_WhenNotMaxLengthAndInvalid {
	[[[creditCardValidator stub] andReturnValue:@NO] isMaximumCVCLength];
	[[[creditCardValidator stub] andReturnValue:@NO] isValidCVC];

	GHAssertEquals(testObject.cvcNumberInputState, SIMTextInputStateNormal, nil);
}

- (void)testCVCNumberInputState_IsGood_WhenMaxLengthAndValid {
	[[[creditCardValidator stub] andReturnValue:@YES] isMaximumCVCLength];
	[[[creditCardValidator stub] andReturnValue:@YES] isValidCVC];

	GHAssertEquals(testObject.cvcNumberInputState, SIMTextInputStateGood, nil);
}

- (void)testSetExpirationDateInput_PostsNotification_SetsExpirationDateOnValidator {
	NSString *input = @"12/12";
	NSString *expectedFormattedText = @"12/12";
	GHAssertEquals(expirationDateDisplayChangedNotification, 0, nil);
	[[[creditCardValidator expect] andDo:^(NSInvocation *invocation) {
		[[[creditCardValidator stub] andReturn:expectedFormattedText] formattedExpirationDate];
	}] setExpirationAsString:input];

	[testObject expirationDateInput:input];

	[creditCardValidator verify];
	GHAssertEquals(expirationDateDisplayChangedNotification, 1, nil);
	GHAssertEqualStrings(testObject.expirationDateDisplay, expectedFormattedText, nil);
}

- (void)testExpirationDateInputState_IsGood_WhenNotExpired {
	[[[creditCardValidator stub] andReturnValue:@NO] isExpired];

	GHAssertEquals(testObject.expirationDateInputState, SIMTextInputStateGood, nil);
}

- (void)testExpirationDateInputState_IsBad_WhenExpired {
	[[[creditCardValidator stub] andReturnValue:@YES] isExpired];

	GHAssertEquals(testObject.expirationDateInputState, SIMTextInputStateBad, nil);
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
	id cardToken = [OCMockObject niceMockForClass:SIMCardToken.class];
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

	[testObject sendCreditCard];

	[creditCardNetwork verify];
}

@end
