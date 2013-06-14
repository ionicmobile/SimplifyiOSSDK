#import "SIMAbstractTestCase.h"
#import "SIMCreditCardTextFieldModel.h"
#import "SIMModelDrivenTextFieldProtocol.h"

@interface SIMCreditCardTextFieldModelTest : SIMAbstractTestCase {
	id luhnValidator;
	id creditCardTypeValidator;
	SIMCreditCardTextFieldModel* testObject;
	id textField;
}
@end

@implementation SIMCreditCardTextFieldModelTest

- (void)setUp {
	[super setUp];
	luhnValidator = [OCMockObject niceMockForClass:SIMLuhnValidator.class];
	creditCardTypeValidator = [OCMockObject niceMockForClass:SIMCreditCardTypeValidator.class];
	textField = [OCMockObject niceMockForProtocol:@protocol(SIMModelDrivenTextFieldProtocol)];
	testObject = [[SIMCreditCardTextFieldModel alloc] initWithLuhnValidator:luhnValidator creditCardTypeValidator:creditCardTypeValidator];
}

- (void)tearDown {
	[super tearDown];
}


@end
