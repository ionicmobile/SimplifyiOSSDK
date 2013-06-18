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
@property (nonatomic, readwrite) SIMTextFieldWithPickerView* stateTextField;
@property (nonatomic, readwrite) SIMTextField* zipTextField;
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
		SIMTextField* line1TextField = [factory createTextFieldWithPlaceholderText:@"Address Line 1" keyboardType:UIKeyboardTypeDefault];
		SIMTextField* line2TextField = [factory createTextFieldWithPlaceholderText:@"Address Line 2" keyboardType:UIKeyboardTypeDefault];
		SIMTextField* cityTextField = [factory createTextFieldWithPlaceholderText:@"City" keyboardType:UIKeyboardTypeDefault];
		SIMTextFieldWithPickerView* stateTextField = [factory createTextFieldWithPickerViewAndPlaceholderText:@"ST" keyboardType:UIKeyboardTypeAlphabet];
		SIMTextField* zipTextField = [factory createTextFieldWithPlaceholderText:@"Zip" keyboardType:UIKeyboardTypeNumberPad];

		[self addSubview:addressLabel];
		[self addSubview:nameTextField];
		[self addSubview:line1TextField];
		[self addSubview:line2TextField];
		[self addSubview:cityTextField];
		[self addSubview:stateTextField];
		[self addSubview:zipTextField];

		self.addressLabel = addressLabel;
		self.nameTextField = nameTextField;
		self.line1TextField = line1TextField;
		self.line2TextField = line2TextField;
		self.cityTextField = cityTextField;
		self.stateTextField = stateTextField;
		self.zipTextField = zipTextField;
	}
	return self;
}

#define TextFieldHeight 30.0
#define InnerMarginY 10.0

- (void)layoutSubviews {
	[super layoutSubviews];
	CGFloat outerMarginX = 20.0;

	[self.addressLabel setFrameAtOriginThatFitsUnbounded:CGPointMake(outerMarginX - 4.0f, 0.0f)];

	CGFloat fullWidth = self.bounds.size.width - 2 * outerMarginX;

	self.nameTextField.frame = CGRectMake(outerMarginX, InnerMarginY + CGRectGetMaxY(self.addressLabel.frame),  fullWidth, TextFieldHeight);
	self.line1TextField.frame = CGRectMake(outerMarginX, InnerMarginY + CGRectGetMaxY(self.nameTextField.frame),  fullWidth, TextFieldHeight);
	self.line2TextField.frame = CGRectMake(outerMarginX, InnerMarginY + CGRectGetMaxY(self.line1TextField.frame),  fullWidth, TextFieldHeight);
	CGFloat cityStateZipYOffset = InnerMarginY + CGRectGetMaxY(self.line2TextField.frame);
	self.cityTextField.frame = CGRectMake(outerMarginX, cityStateZipYOffset, floorf(fullWidth * 0.55), TextFieldHeight);
	self.stateTextField.frame = CGRectMake(CGRectGetMaxX(self.cityTextField.frame), cityStateZipYOffset, floorf(fullWidth * 0.2), TextFieldHeight);
	self.zipTextField.frame = CGRectMake(CGRectGetMaxX(self.stateTextField.frame), cityStateZipYOffset, floorf(fullWidth * 0.25), TextFieldHeight);
}

- (CGSize)sizeThatFits:(CGSize)size {
	CGFloat textFieldCount = 4.0;
	return CGSizeMake(size.width, 30.0 + TextFieldHeight * textFieldCount + InnerMarginY * (textFieldCount + 1));
}

- (void)setStateOptions:(NSDictionary *)stateOptions {
	self.stateTextField.options = stateOptions;
}

- (void)setTextFieldState:(SIMTextFieldState *)textFieldState forControl:(SIMAddressEntryControl)control {
	
}

#pragma mark - Private methods

- (UITextField *)textFieldForControl:(SIMAddressEntryControl)control {
	return nil;
}

- (SIMAddressEntryControl)controlForTextField:(UITextField *)textField {
	return 0;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)replacementString {
	NSString *resultString = [textField.text stringByReplacingCharactersInRange:range withString:replacementString];
	SIMAddressEntryControl control = [self controlForTextField:textField];
	if (control) {
		[self.delegate control:control setInput:resultString];
	}
	return NO;
}

@end
