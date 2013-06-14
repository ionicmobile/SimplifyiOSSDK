#import "SIMTextRequiredTextFieldModel.h"

@implementation SIMTextRequiredTextFieldModel

- (void)textField:(UITextField *)textField input:(NSString *)input {
	textField.text = input;
	textField.backgroundColor = input.length ? SIMTextColorGood : SIMTextColorNormal;
}

@end
