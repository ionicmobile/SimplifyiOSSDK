#import "SIMAbstractTestCase.h"
#import "SIMTextRequiredValidationStrategy.h"

@interface SIMTextRequiredValidationStrategyTest : SIMAbstractTestCase {
	SIMTextRequiredValidationStrategy *testObject;
}
@end

@implementation SIMTextRequiredValidationStrategyTest

- (void)setUp {
	[super setUp];
	testObject = [[SIMTextRequiredValidationStrategy alloc] init];
}

- (void)tearDown {
	[super tearDown];
}

- (void)testStateForControl_ReturnsNormalStateForNoText {
	SIMTextFieldState *result = [testObject stateForInput:@""];

	GHAssertEqualStrings(result.text, @"", nil);
	GHAssertEquals(result.inputState, SIMTextInputStateNormal, nil);
}

- (void)testStateForControl_ReturnsGoodStateForAnyText {
	SIMTextFieldState *result = [testObject stateForInput:@"a"];

	GHAssertEqualStrings(result.text, @"a", nil);
	GHAssertEquals(result.inputState, SIMTextInputStateGood, nil);
}

@end
