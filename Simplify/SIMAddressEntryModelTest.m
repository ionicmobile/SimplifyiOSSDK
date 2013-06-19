#import "SIMAbstractTestCase.h"
#import "SIMAddressEntryModel.h"

@interface SIMAddressEntryModelTest : SIMAbstractTestCase {
	id nameValidator;
	id addressLine1Validator;
	id addressLine2Validator;
	id cityValidator;
	id stateValidator;
	id zipValidator;
	SIMAddressEntryModel *testObject;
	NSDictionary *expectedStateEntries;
}
@end

@implementation SIMAddressEntryModelTest

- (void)setUp {
	[super setUp];
	nameValidator = [OCMockObject niceMockForProtocol:@protocol(SIMGeneralValidationStrategy)];
	addressLine1Validator = [OCMockObject niceMockForProtocol:@protocol(SIMGeneralValidationStrategy)];
	addressLine2Validator = [OCMockObject niceMockForProtocol:@protocol(SIMGeneralValidationStrategy)];
	cityValidator = [OCMockObject niceMockForProtocol:@protocol(SIMGeneralValidationStrategy)];
	stateValidator = [OCMockObject niceMockForProtocol:@protocol(SIMGeneralValidationStrategy)];
	zipValidator = [OCMockObject niceMockForProtocol:@protocol(SIMGeneralValidationStrategy)];
	testObject = [[SIMAddressEntryModel alloc] initWithNameValidator:nameValidator
	                                           addressLine1Validator:addressLine1Validator
						                       addressLine2Validator:addressLine2Validator
											           cityValidator:cityValidator
													  stateValidator:stateValidator
														zipValidator:zipValidator];
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

- (void)testStateForControl_WhenControlIsName_UsesNameValidator_AndSavesNameToAddress {
	id expected = [OCMockObject mockForClass:SIMTextFieldState.class];
	[[[expected stub] andReturn:@"cleaned up text"] text];
	[[[nameValidator stub] andReturn:expected] stateForInput:@"blah!"];

	SIMTextFieldState *result = [testObject stateForControl:SIMAddressEntryControlName withInput:@"blah!"];

	GHAssertEquals(result, expected, nil);
	SIMAddress *address = [testObject createAddressFromInput];
	GHAssertEqualStrings(address.name, @"cleaned up text", nil);
}

- (void)testStateForControl_WhenControlIsAddressLine1_UsesAddressLine1Validator_AndSavesAddressLine1ToAddress {
	id expected = [OCMockObject mockForClass:SIMTextFieldState.class];
	[[[expected stub] andReturn:@"cleaned up text"] text];
	[[[addressLine1Validator stub] andReturn:expected] stateForInput:@"blah!"];

	SIMTextFieldState *result = [testObject stateForControl:SIMAddressEntryControlLine1 withInput:@"blah!"];

	GHAssertEquals(result, expected, nil);
	SIMAddress *address = [testObject createAddressFromInput];
	GHAssertEqualStrings(address.addressLine1, @"cleaned up text", nil);
}

- (void)testStateForControl_WhenControlIsAddressLine2_UsesAddressLine2Validator_AndSavesAddressLine2ToAddress {
	id expected = [OCMockObject mockForClass:SIMTextFieldState.class];
	[[[expected stub] andReturn:@"cleaned up text"] text];
	[[[addressLine2Validator stub] andReturn:expected] stateForInput:@"blah!"];

	SIMTextFieldState *result = [testObject stateForControl:SIMAddressEntryControlLine2 withInput:@"blah!"];

	GHAssertEquals(result, expected, nil);
	SIMAddress *address = [testObject createAddressFromInput];
	GHAssertEqualStrings(address.addressLine2, @"cleaned up text", nil);
}

- (void)testStateForControl_WhenControlIsCity_UsesCityValidator_AndSavesCityToAddress {
	id expected = [OCMockObject mockForClass:SIMTextFieldState.class];
	[[[expected stub] andReturn:@"cleaned up text"] text];
	[[[cityValidator stub] andReturn:expected] stateForInput:@"blah!"];

	SIMTextFieldState *result = [testObject stateForControl:SIMAddressEntryControlCity withInput:@"blah!"];

	GHAssertEquals(result, expected, nil);
	SIMAddress *address = [testObject createAddressFromInput];
	GHAssertEqualStrings(address.city, @"cleaned up text", nil);
}

- (void)testStateForControl_WhenControlIsState_UsesStateValidator_AndSavesStateToAddress {
	id expected = [OCMockObject mockForClass:SIMTextFieldState.class];
	[[[expected stub] andReturn:@"cleaned up text"] text];
	[[[stateValidator stub] andReturn:expected] stateForInput:@"blah!"];

	SIMTextFieldState *result = [testObject stateForControl:SIMAddressEntryControlState withInput:@"blah!"];

	GHAssertEquals(result, expected, nil);
	SIMAddress *address = [testObject createAddressFromInput];
	GHAssertEqualStrings(address.state, @"cleaned up text", nil);
}

- (void)testStateForControl_WhenControlIsZip_UsesZipValidator_AndSavesZipToAddress {
	id expected = [OCMockObject mockForClass:SIMTextFieldState.class];
	[[[expected stub] andReturn:@"cleaned up text"] text];
	[[[zipValidator stub] andReturn:expected] stateForInput:@"blah!"];

	SIMTextFieldState *result = [testObject stateForControl:SIMAddressEntryControlZip withInput:@"blah!"];

	GHAssertEquals(result, expected, nil);
	SIMAddress *address = [testObject createAddressFromInput];
	GHAssertEqualStrings(address.zip, @"cleaned up text", nil);
}

@end
