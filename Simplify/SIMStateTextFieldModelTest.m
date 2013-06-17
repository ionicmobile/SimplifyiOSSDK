#import "SIMAbstractTestCase.h"
#import "SIMStateTextFieldModel.h"
#import "SIMModelDrivenTextFieldProtocol.h"

@interface SIMStateTextFieldModelTest : SIMAbstractTestCase {
	id textField;
	SIMStateTextFieldModel *testObject;
	NSArray *stateAbbreviations;
}
@end

@implementation SIMStateTextFieldModelTest

- (void)setUp {
	[super setUp];
	textField = [OCMockObject niceMockForProtocol:@protocol(SIMModelDrivenTextFieldProtocol)];
	stateAbbreviations = @[@"AL",@"AK",@"AZ",@"AR",@"CA",@"CO",@"CT",@"DE",@"FL",@"GA",@"HI",
							 @"ID",@"IL",@"IN",@"IA",@"KS",@"KY",@"LA",@"ME",@"MD",@"MA",@"MI",@"MN",@"MS",@"MO",@"MT",
							 @"NE",@"NV",@"NH",@"NJ",@"NM",@"NY",@"NC",@"ND",@"OH",@"OK",@"OR",@"PA",@"RI",@"SC",@"SD",
							 @"TN",@"TX",@"UT",@"VT",@"VA",@"WA",@"WV",@"WI",@"WY"];
	testObject = [[SIMStateTextFieldModel alloc] init];
}

- (void)tearDown {
	[super tearDown];
}

- (void)expectNothingForInput:(NSString *)input {
	[[textField reject] setText:OCMOCK_ANY];
	[[textField reject] setBackgroundColor:OCMOCK_ANY];
	[testObject textField:textField input:input];
	[textField verify];
}

- (void)expectText:(NSString *)setText forInput:(NSString *)input {
	[[textField expect] setText:setText];
	[testObject textField:textField input:input];
	[textField verify];
}

- (void)expectText:(NSString *)setText forInput:(NSString *)input withColor:(UIColor *)color {
	[[textField expect] setText:setText];
	[[textField expect] setBackgroundColor:color];
	[testObject textField:textField input:input];
	[textField verify];
}

- (void)testInput_AllowsBlank {
	[self expectText:@"" forInput:@""];
}

- (void)testInput_AutocapitalizesText {
	[self expectText:@"M" forInput:@"m"];
	
	[self expectText:@"MO" forInput:@"Mo"];
}

- (void)testInput_AllowsAStateOrStateBeginning_AndSetsColorToGoodOrNormal {
	for (NSString *stateAbbr in stateAbbreviations) {
		[self expectText:stateAbbr forInput:stateAbbr withColor:SIMTextColorGood];
		NSString *stateBeginning = [stateAbbr substringWithRange:NSMakeRange(0, 1)];
		[self expectText:stateBeginning forInput:stateBeginning withColor:SIMTextColorNormal];
	}
	[self expectNothingForInput:@"B"];
	[self expectNothingForInput:@"ZX"];
}

@end
