#import "SIMZipValidationStrategy.h"

@interface SIMZipValidationStrategy()

@property (nonatomic) NSString *digits;

@end

@implementation SIMZipValidationStrategy

- (id)init {
	if (self = [super init]) {
		self.digits = @"1234567890";
	}
	return self;
}

- (NSString *)stringWithOnlyNumbersFromString:(NSString *)string {
	NSMutableString *newString = [[NSMutableString alloc] init];
	for (int i = 0; i < string.length; i++) {
		NSString *substring = [string substringWithRange:NSMakeRange(i, 1)];
		if ([self.digits rangeOfString:substring].location != NSNotFound) {
			[newString appendString:substring];
		}
	}
	return newString;
}

- (SIMTextFieldState *)stateForInput:(NSString *)input {
	input = [self stringWithOnlyNumbersFromString:input]; // Trim non digits
	input = [input substringWithRange:NSMakeRange(0, input.length > 9 ? 9 : input.length)]; // Trim to 9 characters
	if (input.length > 5) {
		input = [input stringByReplacingCharactersInRange:NSMakeRange(5, 0) withString:@"-"];
	}
	BOOL isValid = (input.length == 5 || input.length == 10);
	return [[SIMTextFieldState alloc] initWithText:input inputState:isValid ? SIMTextInputStateGood : SIMTextInputStateNormal];
}

@end
