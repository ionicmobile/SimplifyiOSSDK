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

@end
