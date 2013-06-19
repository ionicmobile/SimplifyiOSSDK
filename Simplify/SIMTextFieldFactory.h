#import "SIMTextField.h"
#import "SIMTextFieldWithPickerView.h"

@interface SIMTextFieldFactory : NSObject

- (SIMTextField*)createTextFieldWithPlaceholderText:(NSString *)placeholderText
                                       keyboardType:(UIKeyboardType)keyboardType;

- (SIMTextFieldWithPickerView *)createTextFieldWithPickerViewAndPlaceholderText:(NSString *)placeholderText;

@end
