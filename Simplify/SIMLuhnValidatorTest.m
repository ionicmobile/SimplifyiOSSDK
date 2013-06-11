#import "SIMAbstractTestCase.h"
#import "SIMLuhnValidator.h"

@interface SIMLuhnValidatorTest : SIMAbstractTestCase {
    SIMLuhnValidator* testObject;
}

@end


@implementation SIMLuhnValidatorTest

-(void)setUp {
    [super setUp];
    testObject = [[SIMLuhnValidator alloc] init];
}

-(void)testWhenNonLuhnNumberIsSubmittedThenItIsInvalid {
    GHAssertFalse([testObject isValid:@"79927398710"], nil);
    GHAssertFalse([testObject isValid:@"79927398711"], nil);
    GHAssertFalse([testObject isValid:@"79927398712"], nil);
    GHAssertFalse([testObject isValid:@"79927398714"], nil);
    GHAssertFalse([testObject isValid:@"79927398715"], nil);
    GHAssertFalse([testObject isValid:@"79927398716"], nil);
    GHAssertFalse([testObject isValid:@"79927398717"], nil);
    GHAssertFalse([testObject isValid:@"79927398718"], nil);
    GHAssertFalse([testObject isValid:@"79927398719"], nil);
}

-(void)testWhenLuhnNumberIsSubmittedThenIsIsValid {
    GHAssertTrue([testObject isValid:@"79927398713"], nil);
    GHAssertTrue([testObject isValid:@"378282246310005"], nil);
    GHAssertTrue([testObject isValid:@"371449635398431"], nil);
}

@end
