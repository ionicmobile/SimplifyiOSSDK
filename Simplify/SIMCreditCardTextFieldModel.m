#import "SIMCreditCardTextFieldModel.h"
#import "NSString+Simplify.h"

@interface SIMCreditCardTextFieldModel ()
@property (nonatomic) SIMLuhnValidator* luhnValidator;
@property (nonatomic) NSString *digitsOnlyCardNumberString;
@end

@implementation SIMCreditCardTextFieldModel

- (id)initWithLuhnValidator:(SIMLuhnValidator*)luhnValidator {
	if (self = [super init]) {
		self.luhnValidator = luhnValidator;
	}
	return self;
}

- (void)textField:(id<SIMModelDrivenTextFieldProtocol>)textField input:(NSString *)input {
	NSCharacterSet* nonDecimals = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
	self.digitsOnlyCardNumberString = [[input componentsSeparatedByCharactersInSet:nonDecimals] componentsJoinedByString:@""];
}

@end
