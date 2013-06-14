#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "SIMAddressEntryView.h"
#import "UIView+Additions.h"
#import "UIColor+Additions.h"
#import "SimplifyPrivate.h"
#import "SIMTextFieldFactory.h"

@interface SIMAddressEntryView ()
@property (nonatomic) UILabel* addressLabel;
@property (nonatomic, readwrite) SIMTextField* nameTextField;
@property (nonatomic, readwrite) SIMTextField* line1TextField;
@property (nonatomic, readwrite) SIMTextField* line2TextField;
@property (nonatomic, readwrite) SIMTextField* cityTextField;
@property (nonatomic, readwrite) SIMTextField* stateTextField;
@property (nonatomic, readwrite) SIMTextField* zipTextField;
@property (nonatomic, readwrite) SIMTextField* countryTextField;
@end

@implementation SIMAddressEntryView

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {

		UILabel* addressLabel = [[UILabel alloc] init];
		addressLabel.font = [SimplifyPrivate boldFontOfSize:24.0f];
		addressLabel.text = @"Address";
		addressLabel.textColor = [UIColor colorWithHexString:@"4a4a4a"];

		SIMTextFieldFactory* factory = [[SIMTextFieldFactory alloc] init];

		SIMTextField* nameTextField = [factory createTextFieldWithPlaceholderText:@"Full Name" keyboardType:UIKeyboardTypeDefault];

		[self addSubview:addressLabel];
		[self addSubview:nameTextField];

		self.addressLabel = addressLabel;
		self.nameTextField = nameTextField;
	}
	return self;
}

-(void)layoutSubviews {
	[super layoutSubviews];
	CGFloat textFieldHeight = 30.0f;
	CGFloat innerMarginY = 10.0;
	CGFloat outerMarginX = 20.0;
	CGFloat innerMarginX = 5.0;

	[self.addressLabel setFrameAtOriginThatFitsUnbounded:CGPointMake(outerMarginX - 4.0f, 0.0f)];

	self.nameTextField.frame = CGRectMake(outerMarginX, innerMarginY + CGRectGetMaxY(self.addressLabel.frame),  self.bounds.size.width - 2 * outerMarginX, textFieldHeight);
}

- (CGSize)sizeThatFits:(CGSize)size {
	return CGSizeMake(size.width, 80.0);
}

@end
