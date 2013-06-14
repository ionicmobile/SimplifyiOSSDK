#import "SIMTextField.h"

@interface SIMTextFieldFactory : NSObject

- (SIMTextField*)createTextFieldWithPlaceholderText:(NSString *)placeholderText
                                       keyboardType:(UIKeyboardType)keyboardType;

@end
