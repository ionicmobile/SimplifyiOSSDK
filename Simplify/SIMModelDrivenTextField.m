#import "SIMModelDrivenTextField.h"

@interface SIMModelDrivenTextField ()<UITextFieldDelegate>
@end

@implementation SIMModelDrivenTextField

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.delegate = self;
	}
	return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)replacementString {
	NSString *resultString = [textField.text stringByReplacingCharactersInRange:range withString:replacementString];
	if (self.model && [self.model respondsToSelector:@selector(textField:input:)]) {
		[self.model textField:self input:resultString];
		return NO;
	}
	return YES;
}

@end
