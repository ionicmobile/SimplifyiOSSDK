#import "SIMAbstractTestCase.h"
#import "SIMAddress.h"

@interface SIMAddressTest : SIMAbstractTestCase {
	SIMAddress *testObject;
}
@end

@implementation SIMAddressTest

- (void)setUp {
	[super setUp];
}

- (void)tearDown {
	[super tearDown];
}

- (void)testValues_AreSaved {
	testObject = [[SIMAddress alloc] initWithName:@"John Smith" addressLine1:@"100 Street" addressLine2:@"Suite 1" city:@"myCity" state:@"MO" zip:@"45454"];
	
	GHAssertEqualStrings(testObject.name, @"John Smith", nil);
	GHAssertEqualStrings(testObject.addressLine1, @"100 Street", nil);
	GHAssertEqualStrings(testObject.addressLine2, @"Suite 1", nil);
	GHAssertEqualStrings(testObject.city, @"myCity", nil);
	GHAssertEqualStrings(testObject.state, @"MO", nil);
	GHAssertEqualStrings(testObject.zip, @"45454", nil);
	GHAssertEqualStrings(testObject.country, @"USA", nil);
}

@end
