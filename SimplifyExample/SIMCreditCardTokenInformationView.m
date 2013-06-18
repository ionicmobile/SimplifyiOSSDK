#import "SIMCreditCardTokenInformationView.h"
#import "UIColor+Additions.h"

@implementation SIMCreditCardTokenInformationView

- (id)initWithFrame:(CGRect)frame creditCardToken:(SIMCreditCardToken *)creditCardToken {
	if (self = [super initWithFrame:frame]) {
		UILabel *titleLabel = [self createLabelWithSize:26.0f text:@"Token Information" yOffset:0.0];
		UILabel *idLabel = [self createLabelWithSize:14.0f text:[NSString stringWithFormat:@"Id:%@", creditCardToken.token] yOffset:CGRectGetMaxY(titleLabel.frame) + 6.0];

		[self addSubview:titleLabel];
		[self addSubview:idLabel];
	}
	return self;
}

- (UILabel *)createLabelWithSize:(CGFloat)size text:(NSString *)text yOffset:(CGFloat)yOffset {
	UILabel* label = [[UILabel alloc] init];
	label.font = [UIFont boldSystemFontOfSize:size];
	label.text = text;
	label.textColor = [UIColor colorWithHexString:@"4a4a4a"];
	label.backgroundColor = UIColor.clearColor;
	[label sizeToFit];
	label.frame = CGRectMake(CGRectGetMidX(self.frame) - CGRectGetWidth(label.frame) / 2, yOffset, CGRectGetWidth(label.frame), CGRectGetHeight(label.frame));
	return label;
}

@end
