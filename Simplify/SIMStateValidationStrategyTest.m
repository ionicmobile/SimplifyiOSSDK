#import "SIMAbstractTestCase.h"
#import "SIMStateValidationStrategy.h"

@interface SIMStateValidationStrategyTest : SIMAbstractTestCase {
	NSArray *stateAbbreviations;
	SIMStateValidationStrategy *testObject;
}
@end

@implementation SIMStateValidationStrategyTest

- (void)setUp {
	[super setUp];
	stateAbbreviations = @[@"AL", @"AK", @"AZ", @"AR", @"CA", @"CO", @"CT", @"DE", @"FL", @"GA", @"HI", @"ID", @"IL",
			@"IN", @"IA", @"KS",@"KY", @"LA", @"ME", @"MD", @"MA", @"MI", @"MN", @"MS", @"MO", @"MT", @"NE", @"NV",
			@"NH", @"NJ", @"NM", @"NY", @"NC", @"ND", @"OH", @"OK", @"OR", @"PA", @"RI", @"SC", @"SD", @"TN", @"TX",
			@"UT", @"VT", @"VA", @"WA", @"WV", @"WI", @"WY"];

	testObject = [[SIMStateValidationStrategy alloc] init];
}

- (void)tearDown {
	[super tearDown];
}

- (void)assertStateInput:(NSString *)input hasText:(NSString *)text andInputState:(SIMTextInputState)inputState {
	SIMTextFieldState *result = [testObject stateForInput:input];
	GHAssertEqualStrings(result.text, text, nil);
	GHAssertEquals(result.inputState, inputState, nil);
}

- (void)testStateForControl_WithSIMAddressEntryControlState_ValidStatesAreAllowed_AndEverythingElseReturnsEmptyString {
	[self assertStateInput:@"" hasText:@"" andInputState:SIMTextInputStateNormal];

	for (NSString *stateAbbr in stateAbbreviations) {
		[self assertStateInput:stateAbbr hasText:stateAbbr andInputState:SIMTextInputStateGood];
	}

	[self assertStateInput:@"b" hasText:@"" andInputState:SIMTextInputStateNormal];
	[self assertStateInput:@"A" hasText:@"" andInputState:SIMTextInputStateNormal];
	[self assertStateInput:@"argh" hasText:@"" andInputState:SIMTextInputStateNormal];
	[self assertStateInput:@"billy!" hasText:@"" andInputState:SIMTextInputStateNormal];
}


@end
