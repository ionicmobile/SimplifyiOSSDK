#import "SIMCreditCardTokenInformationView.h"
#import "UIColor+Additions.h"

@implementation SIMCreditCardTokenInformationView

- (id)initWithFrame:(CGRect)frame creditCardToken:(SIMCreditCardToken *)creditCardToken {
	if (self = [super initWithFrame:frame]) {
		CGFloat yOffset = 0.0;
		UILabel *titleLabel = [self createLabelWithSize:26.0f text:@"Token Information" yOffset:yOffset];
		[self addSubview:titleLabel];
		yOffset = CGRectGetMaxY(titleLabel.frame) + 6.0;
		
		UILabel *idLabel = [self createLabelWithSize:14.0f text:[NSString stringWithFormat:@"Id: %@", creditCardToken.token] yOffset:yOffset];
		[self addSubview:idLabel];
		yOffset = CGRectGetMaxY(idLabel.frame) + 6.0;

		UILabel *typeAndLast4Label = [self createLabelWithSize:14.0f text:[NSString stringWithFormat:@"Type: %@\t\tLast4: %@", creditCardToken.type, creditCardToken.last4] yOffset:yOffset];
		[self addSubview:typeAndLast4Label];
		yOffset = CGRectGetMaxY(typeAndLast4Label.frame) + 6.0;

		if (creditCardToken.name.length) {
			UILabel *nameLabel = [self createLabelWithSize:14.0f text:[NSString stringWithFormat:@"Name: %@", creditCardToken.name] yOffset:yOffset];
			[self addSubview:nameLabel];
			yOffset = CGRectGetMaxY(nameLabel.frame) + 6.0;
		}
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
	label.frame = CGRectMake(0, yOffset, CGRectGetWidth(self.frame), CGRectGetHeight(label.frame));
	return label;
}

@end
