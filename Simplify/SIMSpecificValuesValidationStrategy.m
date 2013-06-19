#import "SIMSpecificValuesValidationStrategy.h"

@interface SIMSpecificValuesValidationStrategy()

@property (nonatomic) NSArray *validValues;

@end

@implementation SIMSpecificValuesValidationStrategy

- (id)initWithValidValues:(NSArray *)validValues {
	if (self = [super init]) {
		self.validValues = validValues;
	}
	return self;
}

- (SIMTextFieldState *)stateForInput:(NSString *)input {
	BOOL isValidValue = [self.validValues containsObject:input];
	NSString *result = isValidValue ? input : @"";
	SIMTextInputState state = isValidValue ? SIMTextInputStateGood : SIMTextInputStateNormal;
	return [[SIMTextFieldState alloc] initWithText:result inputState:state];
}

@end
