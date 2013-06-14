#import "SIMAbstractTestCase.h"
#import "SIMTextRequiredTextFieldModel.h"
#import "SIMModelDrivenTextFieldProtocol.h"

@interface SIMTextRequiredTextFieldModelTest : SIMAbstractTestCase {
	id textField;
	SIMTextRequiredTextFieldModel* testObject;
}
@end

@implementation SIMTextRequiredTextFieldModelTest

- (void)setUp {
	[super setUp];
	textField = [OCMockObject niceMockForProtocol:@protocol(SIMModelDrivenTextFieldProtocol)];
	testObject = [[SIMTextRequiredTextFieldModel alloc] init];
}

- (void)tearDown {
	[super tearDown];
}

- (void)testInput_KeepsAllInput {
	NSString *text = @"ndsfl(*AN)uirgesjdkn";
	[[textField expect] setText:text];

	[testObject textField:textField input:text];

	[textField verify];
}

- (void)testInput_SetsToNormalColor_WhenTextIsEmpty {
	[[textField expect] setBackgroundColor:SIMTextColorNormal];

	[testObject textField:textField input:@""];

	[textField verify];
}

- (void)testInput_SetsToGoodColor_WhenTextIsNotEmpty {
	[[textField expect] setBackgroundColor:SIMTextColorGood];

	[testObject textField:textField input:@"abc"];

	[textField verify];
}

@end
