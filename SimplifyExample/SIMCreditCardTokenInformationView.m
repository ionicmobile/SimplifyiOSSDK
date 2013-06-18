#import "SIMCreditCardTokenInformationView.h"
#import "UIColor+Additions.h"

@implementation SIMCreditCardTokenInformationView

- (id)initWithFrame:(CGRect)frame creditCardToken:(SIMCreditCardToken *)creditCardToken {
	if (self = [super initWithFrame:frame]) {
		CGFloat midX = CGRectGetMidX(frame);
		UILabel* tokenLabel = [[UILabel alloc] init];
		tokenLabel.font = [UIFont boldSystemFontOfSize:26.0f];
		tokenLabel.text = @"Token Information";
		tokenLabel.textColor = [UIColor colorWithHexString:@"4a4a4a"];
		tokenLabel.backgroundColor = UIColor.clearColor;
		[tokenLabel sizeToFit];
		tokenLabel.frame = CGRectMake(midX - CGRectGetWidth(tokenLabel.frame) / 2, 0, CGRectGetWidth(tokenLabel.frame), CGRectGetHeight(tokenLabel.frame));

		[self addSubview:tokenLabel];
	}
	return self;
}

@end
