#import "SIMTextFieldState.h"

@interface SIMTextFieldState()
@property (nonatomic, readwrite) NSString *text;
@property (nonatomic, readwrite) SIMTextInputState inputState;
@end

@implementation SIMTextFieldState
- (id)initWithText:(NSString *)text inputState:(SIMTextInputState)inputState {
	if (self = [super init]) {
		self.text = text;
		self.inputState = inputState;
	}
	return self;
}
@end
