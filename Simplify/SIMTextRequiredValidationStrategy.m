#import "SIMTextRequiredValidationStrategy.h"

@implementation SIMTextRequiredValidationStrategy

- (SIMTextFieldState *)stateForInput:(NSString *)input {
	if (input.length > 0) {
		return [[SIMTextFieldState alloc] initWithText:input inputState:SIMTextInputStateGood];
	} else {
		return [[SIMTextFieldState alloc] initWithText:@"" inputState:SIMTextInputStateNormal];
	}
}

@end
