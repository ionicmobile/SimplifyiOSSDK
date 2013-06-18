#import "SIMAbstractTestCase.h"
#import "SIMCreditCardToken.h"

@interface SIMCardTokenTest : SIMAbstractTestCase {
	SIMCreditCardToken* testObject;
}
@end

@implementation SIMCardTokenTest


- (void)testFromDictionary_BuildsObjectFromDictionaryCorrectly {
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
			@"dateCreated" : @"1371130986562"
	};
	NSDictionary *dictionary = @{@"id" : @"myCardTokenId", @"card" : cardDictionary};

	testObject = [SIMCreditCardToken cardTokenFromDictionary:dictionary];

	GHAssertEqualStrings(testObject.token, @"myCardTokenId", nil);
	GHAssertEqualStrings(testObject.name, @"myCard", nil);
	GHAssertEqualStrings(testObject.type, @"someType", nil);
	GHAssertEqualStrings(testObject.last4, @"1234", nil);
	GHAssertEqualStrings(testObject.addressLine1, @"100 Happy Drive", nil);
	GHAssertEqualStrings(testObject.addressLine2, @"Apartment A", nil);
	GHAssertEqualStrings(testObject.addressCity, @"Saint Louis", nil);
	GHAssertEqualStrings(testObject.addressState, @"Missouri", nil);
	GHAssertEqualStrings(testObject.addressZip, @"63333", nil);
	GHAssertEqualStrings(testObject.addressCountry, @"USA", nil);
	GHAssertEqualStrings(testObject.expMonth, @"02", nil);
	GHAssertEqualStrings(testObject.expYear, @"15", nil);
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:1371130986562 / 1000];
	GHAssertEqualObjects(testObject.dateCreated, date, nil);
}

@end
