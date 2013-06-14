#import "SIMTextFieldModel.h"

@interface SIMTextFieldModel ()
@end

@implementation SIMTextFieldModel

- (void)attachToTextField:(UITextField *)textField {
	textField.delegate = self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)replacementString {
	NSString *resultString = [textField.text stringByReplacingCharactersInRange:range withString:replacementString];
	if ([self respondsToSelector:@selector(textField:input:)]) {
		[self textField:self input:resultString];
	}
	return NO;
}

@end
