#import "SIMTextField.h"

@interface SIMTextFieldWithPickerView : SIMTextField

/**
 The keys of the options dictionary are what is shown in the picker, the values are what is shown in the text field when something is picked.
 */
@property (nonatomic) NSDictionary *options;

@end
