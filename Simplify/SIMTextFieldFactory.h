#import "SIMTextField.h"
#import "SIMModelDrivenTextField.h"
#import "SIMTextFieldWithPickerView.h"

@interface SIMTextFieldFactory : NSObject

- (SIMTextField*)createTextFieldWithPlaceholderText:(NSString *)placeholderText
                                       keyboardType:(UIKeyboardType)keyboardType;

- (SIMModelDrivenTextField*)createModelDrivenTextFieldWithPlaceholderText:(NSString *)placeholderText
                                                             keyboardType:(UIKeyboardType)keyboardType;

- (SIMTextFieldWithPickerView*)createTextFieldWithPickerViewAndPlaceholderText:(NSString *)placeholderText
																  keyboardType:(UIKeyboardType)keyboardType;

@end
