#import "SIMAbstractTestCase.h"
#import "SIMZipValidationStrategy.h"

@interface SIMZipValidationStrategyTest : SIMAbstractTestCase {
	SIMZipValidationStrategy *testObject;
}
@end

@implementation SIMZipValidationStrategyTest

- (void)setUp {
	[super setUp];
	testObject = [[SIMZipValidationStrategy alloc] init];
}

- (void)tearDown {
	[super tearDown];
}

- (void)assertInput:(NSString *)input hasText:(NSString *)text andInputState:(SIMTextInputState)inputState {
	SIMTextFieldState *result = [testObject stateForInput:input];
	GHAssertEqualStrings(result.text, text, nil);
	GHAssertEquals(result.inputState, inputState, nil);
}

- (void)testStateForControl_OnlyAcceptsNumbers {
	[self assertInput:@"asb" hasText:@"" andInputState:SIMTextInputStateNormal];
	[self assertInput:@"B" hasText:@"" andInputState:SIMTextInputStateNormal];
	[self assertInput:@"1" hasText:@"1" andInputState:SIMTextInputStateNormal];
	[self assertInput:@"12" hasText:@"12" andInputState:SIMTextInputStateNormal];
	[self assertInput:@"123" hasText:@"123" andInputState:SIMTextInputStateNormal];
	[self assertInput:@"1234" hasText:@"1234" andInputState:SIMTextInputStateNormal];
}

- (void)testStateForControl_ReturnsInputStateGood_OnZipWith5Numbers {
	[self assertInput:@"12345" hasText:@"12345" andInputState:SIMTextInputStateGood];
}

- (void)testStateForControl_ReturnsInputStateGood_OnZipWith9Numbers {
	[self assertInput:@"123456789" hasText:@"12345-6789" andInputState:SIMTextInputStateGood];
	[self assertInput:@"12345-6789" hasText:@"12345-6789" andInputState:SIMTextInputStateGood];
}

- (void)testStateForControl_AddsDash_OnZipsBiggerThan5Numbers {
	[self assertInput:@"123456" hasText:@"12345-6" andInputState:SIMTextInputStateNormal];
	[self assertInput:@"12345-" hasText:@"12345" andInputState:SIMTextInputStateGood];
	[self assertInput:@"12345-67" hasText:@"12345-67" andInputState:SIMTextInputStateNormal];
	[self assertInput:@"12345-678" hasText:@"12345-678" andInputState:SIMTextInputStateNormal];
}

- (void)testStateForControl_HasMaxOf9Digits {
	[self assertInput:@"12345-67891" hasText:@"12345-6789" andInputState:SIMTextInputStateGood];
	[self assertInput:@"12345-6789-" hasText:@"12345-6789" andInputState:SIMTextInputStateGood];
	[self assertInput:@"12345-6789x" hasText:@"12345-6789" andInputState:SIMTextInputStateGood];
	[self assertInput:@"12x345-6789" hasText:@"12345-6789" andInputState:SIMTextInputStateGood];
}

@end
