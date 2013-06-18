#include "SIMTextInputState.h"

@interface SIMTextFieldState : NSObject
@property (nonatomic, readonly) NSString *text;
@property (nonatomic, readonly) SIMTextInputState inputState;
- (id)initWithText:(NSString *)text inputState:(SIMTextInputState)inputState;
@end
