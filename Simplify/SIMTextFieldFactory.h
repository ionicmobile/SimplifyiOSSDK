#import "SIMTextField.h"
#import "SIMModelDrivenTextField.h"

@interface SIMTextFieldFactory : NSObject

- (SIMTextField*)createTextFieldWithPlaceholderText:(NSString *)placeholderText
                                       keyboardType:(UIKeyboardType)keyboardType;

- (SIMModelDrivenTextField*)createModelDrivenTextFieldWithPlaceholderText:(NSString *)placeholderText
                                                             keyboardType:(UIKeyboardType)keyboardType;

@end
