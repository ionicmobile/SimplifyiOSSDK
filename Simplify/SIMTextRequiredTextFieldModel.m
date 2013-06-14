#import "SIMTextRequiredTextFieldModel.h"
#import "SIMModelDrivenTextFieldProtocol.h"

@implementation SIMTextRequiredTextFieldModel

- (void)textField:(id<SIMModelDrivenTextFieldProtocol>)textField input:(NSString *)input {
	[textField setText:input];
	UIColor* backgroundColor = input.length ? SIMTextColorGood : SIMTextColorNormal;
	[textField setBackgroundColor:backgroundColor];
}

@end
