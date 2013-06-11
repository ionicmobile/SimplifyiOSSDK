#import "SIMAbstractTestCase.h"
#import "SIMCardToken.h"

@interface SIMCardTokenTest : SIMAbstractTestCase {
	SIMCardToken* testObject;
}
@end

@implementation SIMCardTokenTest


- (void)testFromDictionary_BuildsObjectFromDictionaryCorrectly {
	NSDate *date = [NSDate date];
	NSDictionary *cardDictionary = @{
			@"name" : @"myCard",
			@"type" : @"someType",
			@"last4" : @"1234",
			@"addressLine1" : @"100 Happy Drive",
			@"addressLine2" : @"Apartment A",
			@"addressCity" : @"Saint Louis",
			@"addressState" : @"Missouri",
			@"addressZip" : @"63333",
			@"addressCountry" : @"USA",
			@"expMonth" : @"02",
			@"expYear" : @"15",
			@"dateCreated" : date
	};
	NSDictionary *dictionary = @{@"id" : @"myCardTokenId", @"card" : cardDictionary};

	testObject = [SIMCardToken cardTokenFromDictionary:dictionary];

	GHAssertEqualStrings(@"myCardTokenId", testObject.token, nil);
	GHAssertEqualStrings(@"myCard", testObject.name, nil);
	GHAssertEqualStrings(@"someType", testObject.type, nil);
	GHAssertEqualStrings(@"1234", testObject.last4, nil);
	GHAssertEqualStrings(@"100 Happy Drive", testObject.addressLine1, nil);
	GHAssertEqualStrings(@"Apartment A", testObject.addressLine2, nil);
	GHAssertEqualStrings(@"Saint Louis", testObject.addressCity, nil);
	GHAssertEqualStrings(@"Missouri", testObject.addressState, nil);
	GHAssertEqualStrings(@"63333", testObject.addressZip, nil);
	GHAssertEqualStrings(@"USA", testObject.addressCountry, nil);
	GHAssertEqualStrings(@"02", testObject.expMonth, nil);
	GHAssertEqualStrings(@"15", testObject.expYear, nil);
//	GHAssertEqualObjects(date, testObject.dateCreated, nil);
}

@end
