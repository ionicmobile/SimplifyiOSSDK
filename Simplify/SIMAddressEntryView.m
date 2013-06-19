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
		SIMTextFieldWithPickerView* stateTextField = [factory createTextFieldWithPickerViewAndPlaceholderText:@"State" keyboardType:UIKeyboardTypeAlphabet];
		SIMTextField* zipTextField = [factory createTextFieldWithPlaceholderText:@"Zip" keyboardType:UIKeyboardTypeNumberPad];

		nameTextField.delegate = self;
		line1TextField.delegate = self;
		line2TextField.delegate = self;
		cityTextField.delegate = self;
		stateTextField.delegate = self;
		zipTextField.delegate = self;

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
	self.cityTextField.frame = CGRectMake(outerMarginX, InnerMarginY + CGRectGetMaxY(self.line2TextField.frame), fullWidth, TextFieldHeight);
	CGFloat stateZipYOffset = InnerMarginY + CGRectGetMaxY(self.cityTextField.frame);
	CGFloat stateZipWidth = floorf(fullWidth * 0.45);
	self.stateTextField.frame = CGRectMake(outerMarginX, stateZipYOffset, stateZipWidth, TextFieldHeight);
	self.zipTextField.frame = CGRectMake(fullWidth + outerMarginX - stateZipWidth, stateZipYOffset, stateZipWidth, TextFieldHeight);
}

- (CGSize)sizeThatFits:(CGSize)size {
	CGFloat rows = 5.0;
	return CGSizeMake(size.width, 30.0 + (TextFieldHeight * rows) + (InnerMarginY * (rows + 1)));
}

- (void)setStateOptions:(NSDictionary *)stateOptions {
	self.stateTextField.options = stateOptions;
}

- (void)setTextFieldState:(SIMTextFieldState *)textFieldState forControl:(SIMAddressEntryControl)control {
	UITextField *textField = [self textFieldForControl:control];
	textField.text = textFieldState.text;
	[self setTextField:textField inputState:textFieldState.inputState];
}

#pragma mark - Private methods

- (void)setTextField:(UITextField *)textField inputState:(SIMTextInputState)inputState {
	switch (inputState) {
	case SIMTextInputStateBad:
		textField.backgroundColor = [UIColor colorWithHexString:@"ffcccc"];
		break;
	case SIMTextInputStateGood:
		textField.backgroundColor = [UIColor colorWithHexString:@"ccffcc"];
		break;
	case SIMTextInputStateNormal:
	default:
		textField.backgroundColor = [UIColor clearColor];
		break;
	}
}

- (UITextField *)textFieldForControl:(SIMAddressEntryControl)control {
	UITextField *result = nil;
	switch (control) {
	case SIMAddressEntryControlName:
		result = self.nameTextField;
		break;
	case SIMAddressEntryControlLine1:
		result = self.line1TextField;
		break;
	case SIMAddressEntryControlLine2:
		result = self.line2TextField;
		break;
	case SIMAddressEntryControlCity:
		result = self.cityTextField;
		break;
	case SIMAddressEntryControlState:
		result = self.stateTextField;
		break;
	case SIMAddressEntryControlZip:
		result = self.zipTextField;
		break;
	}
	return result;
}

- (SIMAddressEntryControl)controlForTextField:(UITextField *)textField {
	SIMAddressEntryControl control = 0;
	if (textField == self.nameTextField) {
		control = SIMAddressEntryControlName;
	} else if (textField == self.line1TextField) {
		control = SIMAddressEntryControlLine1;
	} else if (textField == self.line2TextField) {
		control = SIMAddressEntryControlLine2;
	} else if (textField == self.cityTextField) {
		control = SIMAddressEntryControlCity;
	} else if (textField == self.stateTextField) {
		control = SIMAddressEntryControlState;
	} else if (textField == self.zipTextField) {
		control = SIMAddressEntryControlZip;
	}
	return control;
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
