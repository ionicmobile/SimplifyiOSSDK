#import "SIMAbstractTestCase.h"
#import "SIMAddressEntryModel.h"

@interface SIMAddressEntryModelTest : SIMAbstractTestCase {
	SIMAddressEntryModel *testObject;
	NSDictionary *expectedStateEntries;
}
@end

@implementation SIMAddressEntryModelTest

- (void)setUp {
	[super setUp];
	testObject = [[SIMAddressEntryModel alloc] init];
	expectedStateEntries = @{
		@"Alabama":@"AL",
		@"Alaska":@"AK",
		@"Arizona":@"AZ",
		@"Arkansas":@"AR",
		@"California":@"CA",
		@"Colorado":@"CO",
		@"Connecticut":@"CT",
		@"Delaware":@"DE",
		@"Florida":@"FL",
		@"Georgia":@"GA",
		@"Hawaii":@"HI",
		@"Idaho":@"ID",
		@"Illinois":@"IL",
		@"Indiana":@"IN",
		@"Iowa":@"IA",
		@"Kansas":@"KS",
		@"Kentucky":@"KY",
		@"Louisiana":@"LA",
		@"Maine":@"ME",
		@"Maryland":@"MD",
		@"Massachusetts":@"MA",
		@"Michigan":@"MI",
		@"Minnesota":@"MN",
		@"Mississippi":@"MS",
		@"Missouri":@"MO",
		@"Montana":@"MT",
		@"Nebraska":@"NE",
		@"Nevada":@"NV",
		@"New Hampshire":@"NH",
		@"New Jersey":@"NJ",
		@"New Mexico":@"NM",
		@"New York":@"NY",
		@"North Carolina":@"NC",
		@"North Dakota":@"ND",
		@"Ohio":@"OH",
		@"Oklahoma":@"OK",
		@"Oregon":@"OR",
		@"Pennsylvania":@"PA",
		@"Rhode Island":@"RI",
		@"South Carolina":@"SC",
		@"South Dakota":@"SD",
		@"Tennessee":@"TN",
		@"Texas":@"TX",
		@"Utah":@"UT",
		@"Vermont":@"VT",
		@"Virginia":@"VA",
		@"Washington":@"WA",
		@"West Virginia":@"WV",
		@"Wisconsin":@"WI",
		@"Wyoming":@"WY"};
}

- (void)tearDown {
	[super tearDown];
}

- (void)testStateOptions_ReturnsDictionaryOfStateNameToStateAbbreviation {
	NSArray *expectedKeys = expectedStateEntries.allKeys;

	NSDictionary *actual = testObject.stateOptions;
	NSArray *actualKeys = actual.allKeys;

	GHAssertEquals(actualKeys.count, expectedKeys.count, nil);
	for (NSString *key in expectedKeys) {
		GHAssertTrue([actualKeys containsObject:key], nil);
		GHAssertEqualStrings(actual[key], expectedStateEntries[key], nil);
	}
}

- (void)testStateForControl_ForSIMAddressEntryControlName_ReturnsBadStateForNoText {
	SIMTextFieldState *result = [testObject stateForControl:SIMAddressEntryControlName withInput:@""];

	GHAssertEqualStrings(result.text, @"", nil);
	GHAssertEquals(result.inputState, SIMTextInputStateNormal, nil);
}

- (void)testStateForControl_ForSIMAddressEntryControlName_ReturnsGoodStateForAnyText {
	SIMTextFieldState *result = [testObject stateForControl:SIMAddressEntryControlName withInput:@"a"];

	GHAssertEqualStrings(result.text, @"a", nil);
	GHAssertEquals(result.inputState, SIMTextInputStateGood, nil);
}

- (void)testCreateAddressFromInput_KeepsPreviousInput {
	[testObject stateForControl:SIMAddressEntryControlName withInput:@"Billy Thorn"];
	[testObject stateForControl:SIMAddressEntryControlLine1 withInput:@"Line 1"];
	[testObject stateForControl:SIMAddressEntryControlLine2 withInput:@"Line 2"];
	[testObject stateForControl:SIMAddressEntryControlCity withInput:@"Some City"];
	[testObject stateForControl:SIMAddressEntryControlState withInput:@"MO"];
	[testObject stateForControl:SIMAddressEntryControlZip withInput:@"12345"];

	SIMAddress *address = [testObject createAddressFromInput];

	GHAssertEqualStrings(address.name, @"Billy Thorn", nil);
	GHAssertEqualStrings(address.addressLine1, @"Line 1", nil);
	GHAssertEqualStrings(address.addressLine2, @"Line 2", nil);
	GHAssertEqualStrings(address.city, @"Some City", nil);
	GHAssertEqualStrings(address.state, @"MO", nil);
	GHAssertEqualStrings(address.zip, @"12345", nil);
}

- (void)assertStateInput:(NSString *)input hasText:(NSString *)text andInputState:(SIMTextInputState)inputState {
	SIMTextFieldState *result = [testObject stateForControl:SIMAddressEntryControlState withInput:input];
	GHAssertEqualStrings(result.text, text, nil);
	GHAssertEquals(result.inputState, inputState, nil);
}

- (void)testStateForControl_WithSIMAddressEntryControlState_ValidStatesAreAllowed_AndEverythingElseReturnsEmptyString {
	[self assertStateInput:@"" hasText:@"" andInputState:SIMTextInputStateNormal];

	for (NSString *stateAbbr in expectedStateEntries.allValues) {
		[self assertStateInput:stateAbbr hasText:stateAbbr andInputState:SIMTextInputStateGood];
	}

	[self assertStateInput:@"b" hasText:@"" andInputState:SIMTextInputStateNormal];
	[self assertStateInput:@"A" hasText:@"" andInputState:SIMTextInputStateNormal];
	[self assertStateInput:@"argh" hasText:@"" andInputState:SIMTextInputStateNormal];
	[self assertStateInput:@"billy!" hasText:@"" andInputState:SIMTextInputStateNormal];
}

@end
