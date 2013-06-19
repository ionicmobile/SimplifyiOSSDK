#import "SIMAbstractTestCase.h"
#import "SIMSpecificValuesValidationStrategy.h"

@interface SIMSpecificValuesValidationStrategyTest : SIMAbstractTestCase {
	NSArray *validValues;
	SIMSpecificValuesValidationStrategy *testObject;
}
@end

@implementation SIMSpecificValuesValidationStrategyTest

- (void)setUp {
	[super setUp];
	validValues = @[@"abc", @"123", @"a"];
	testObject = [[SIMSpecificValuesValidationStrategy alloc] initWithValidValues:validValues];
}

- (void)tearDown {
	[super tearDown];
}

- (void)assertInput:(NSString *)input hasText:(NSString *)text andInputState:(SIMTextInputState)inputState {
	SIMTextFieldState *result = [testObject stateForInput:input];
	GHAssertEqualStrings(result.text, text, nil);
	GHAssertEquals(result.inputState, inputState, nil);
}

- (void)testStateForInput_EmptyStringIsNormalInputState {
	[self assertInput:@"" hasText:@"" andInputState:SIMTextInputStateNormal];
}

- (void)testStateForInput_OnlyAllowsSpecificValues {
	for (NSString *value in validValues) {
		[self assertInput:value hasText:value andInputState:SIMTextInputStateGood];
	}

	[self assertInput:@"23r4g" hasText:@"" andInputState:SIMTextInputStateNormal];
	[self assertInput:@"b" hasText:@"" andInputState:SIMTextInputStateNormal];
	[self assertInput:@"@!#Rubgijklfd" hasText:@"" andInputState:SIMTextInputStateNormal];
}

@end
