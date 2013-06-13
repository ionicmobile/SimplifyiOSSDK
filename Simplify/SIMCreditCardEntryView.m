#import <QuartzCore/QuartzCore.h>
#import "UIView+Additions.h"
#import "UIColor+Additions.h"
#import "SIMCreditCardEntryView.h"
#import "SimplifyPrivate.h"
#import "SIMLayeredButton.h"
#import "SIMTextField.h"

@interface SIMCreditCardEntryView() <UITextFieldDelegate>
@property (nonatomic) UILabel* titleLabel;
@property (nonatomic) UIImageView* cardImageView;
@property (nonatomic) UITextField* creditCardNumberTextField;
@property (nonatomic) UITextField* CVCNumberTextField;
@property (nonatomic) UITextField* expirationDateTextField;
@property (nonatomic) UIButton* sendCreditCardButton;
@end

@implementation SIMCreditCardEntryView

-(id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.backgroundColor = [UIColor whiteColor];

		UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		titleLabel.font = [SimplifyPrivate boldFontOfSize:26.0f];
		titleLabel.text = @"Payment Details";
		titleLabel.textColor = [UIColor colorWithHexString:@"4a4a4a"];

		UIImageView* cardImageView = [[UIImageView alloc] initWithImage:[SimplifyPrivate imageNamed:@"card_back_32"]];

		SIMTextField* creditCardNumberTextField = [[SIMTextField alloc] initWithFrame:CGRectZero];
		creditCardNumberTextField.leftView = [UIView paddedViewWithView:cardImageView andPadding:CGSizeMake(15, 0)];
		creditCardNumberTextField.leftViewMode = UITextFieldViewModeAlways;
		creditCardNumberTextField.layer.borderColor = [UIColor simplifyBorderColor].CGColor;
		creditCardNumberTextField.layer.borderWidth = 1.0f;
		creditCardNumberTextField.layer.masksToBounds = YES;
		creditCardNumberTextField.placeholder = @"Credit Card Number";
		creditCardNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
		creditCardNumberTextField.font = [SimplifyPrivate fontOfSize:16.0f];
		creditCardNumberTextField.textOffset = CGSizeMake(60, 2);
		creditCardNumberTextField.textColor = [UIColor colorWithHexString:@"4a4a4a"];
		creditCardNumberTextField.text = @"";
		[creditCardNumberTextField becomeFirstResponder];
		creditCardNumberTextField.delegate = self;

		SIMTextField* CVCNumberTextField = [[SIMTextField alloc] initWithFrame:CGRectZero];
		CVCNumberTextField.borderStyle = UITextBorderStyleLine;
		CVCNumberTextField.leftView = [UIView paddedViewWithView:[[UIView alloc] init] andPadding:CGSizeMake(7, 0)];
		CVCNumberTextField.leftViewMode = UITextFieldViewModeAlways;
		CVCNumberTextField.layer.borderColor = [UIColor simplifyBorderColor].CGColor;
		CVCNumberTextField.layer.borderColor = [UIColor simplifyBorderColor].CGColor;
		CVCNumberTextField.layer.borderWidth = 1.0f;
		CVCNumberTextField.layer.masksToBounds = YES;
		CVCNumberTextField.placeholder = @"CVC Code";
		CVCNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
		CVCNumberTextField.font = [SimplifyPrivate fontOfSize:16.0f];
		CVCNumberTextField.textOffset = CGSizeMake(10, 2);
		CVCNumberTextField.textColor = [UIColor colorWithHexString:@"4a4a4a"];
		CVCNumberTextField.text = @"";
		CVCNumberTextField.delegate = self;

		SIMTextField* expirationDateTextField = [[SIMTextField alloc] initWithFrame:CGRectZero];
		expirationDateTextField.leftView = [UIView paddedViewWithView:[[UIView alloc] init] andPadding:CGSizeMake(7, 0)];
		expirationDateTextField.leftViewMode = UITextFieldViewModeAlways;
		expirationDateTextField.borderStyle = UITextBorderStyleLine;
		expirationDateTextField.layer.borderColor = [UIColor simplifyBorderColor].CGColor;
		expirationDateTextField.layer.borderColor = [UIColor simplifyBorderColor].CGColor;
		expirationDateTextField.layer.borderWidth = 1.0f;
		expirationDateTextField.layer.masksToBounds = YES;
		expirationDateTextField.keyboardType = UIKeyboardTypeNumberPad;
		expirationDateTextField.placeholder = @"MM/YY";
		expirationDateTextField.font = [SimplifyPrivate fontOfSize:16.0f];
		expirationDateTextField.textOffset = CGSizeMake(10, 2);
		expirationDateTextField.textColor = [UIColor colorWithHexString:@"4a4a4a"];
		expirationDateTextField.text = @"";
		expirationDateTextField.delegate = self;

		SIMLayeredButton* sendCreditCardButton = [[SIMLayeredButton alloc] init];
		[sendCreditCardButton setTitle:@"Send Card" forState:UIControlStateNormal];
		sendCreditCardButton.titleLabel.font = [SimplifyPrivate boldFontOfSize:18.0f];
		sendCreditCardButton.titleLabel.shadowColor = [UIColor blackColor];
		sendCreditCardButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
		[sendCreditCardButton addTarget:self action:@selector(sendCreditCardButtonTapped) forControlEvents:UIControlEventTouchUpInside];

		self.titleLabel = titleLabel;
		self.cardImageView = cardImageView;
		self.creditCardNumberTextField = creditCardNumberTextField;
		self.CVCNumberTextField = CVCNumberTextField;
		self.expirationDateTextField = expirationDateTextField;
		self.sendCreditCardButton = sendCreditCardButton;

		[self addSubview:titleLabel];
		[self addSubview:creditCardNumberTextField];
		[self addSubview:CVCNumberTextField];
		[self addSubview:expirationDateTextField];
		[self addSubview:sendCreditCardButton];
	}
	return self;
}

-(void)layoutSubviews {
	[super layoutSubviews];
	CGFloat textFieldHeight = 30.0f;
	CGFloat innerMarginY = 10.0;
	CGFloat outerMarginX = 20.0;
	CGFloat innerMarginX = 5.0;

	[self.titleLabel setFrameAtOriginThatFitsUnbounded:CGPointMake(outerMarginX - 4.0f, 20.0f)];

	self.creditCardNumberTextField.frame = CGRectMake(outerMarginX, innerMarginY + CGRectGetMaxY(self.titleLabel.frame),  self.bounds.size.width - 2 * outerMarginX, textFieldHeight);

	self.CVCNumberTextField.frame = CGRectMake(outerMarginX, CGRectGetMaxY(self.creditCardNumberTextField.frame) + innerMarginY, (self.bounds.size.width - innerMarginX - 2 * outerMarginX)/2,textFieldHeight);

	self.expirationDateTextField.frame = CGRectMake(CGRectGetMaxX(self.CVCNumberTextField.frame) + innerMarginX, CGRectGetMaxY(self.creditCardNumberTextField.frame) + innerMarginY, (self.bounds.size.width - innerMarginX - 2 * outerMarginX)/2,textFieldHeight);

	[self.sendCreditCardButton centerHorizonallyAtY:CGRectGetMaxY(self.expirationDateTextField.frame) + innerMarginY inBounds:self.bounds withSize:CGSizeMake(self.bounds.size.width - 2 * outerMarginX, 40)];
}

-(void)setCardType:(SIMCreditCardType)cardType {
	switch (cardType) {
	case SIMCreditCardType_AmericanExpress:
		self.cardImageView.image = [SimplifyPrivate imageNamed:@"american_express_32"];
		break;
	case SIMCreditCardType_ChinaUnionPay:
		self.cardImageView.image = [SimplifyPrivate imageNamed:@"china_union_pay_32"];
		break;
	case SIMCreditCardType_DinersClub:
		self.cardImageView.image = [SimplifyPrivate imageNamed:@"diners_club_32"];
		break;
	case SIMCreditCardType_Discover:
		self.cardImageView.image = [SimplifyPrivate imageNamed:@"discover_32"];
		break;
	case SIMCreditCardType_JCB:
		self.cardImageView.image = [SimplifyPrivate imageNamed:@"jcb_32"];
		break;
	case SIMCreditCardType_MasterCard:
		self.cardImageView.image = [SimplifyPrivate imageNamed:@"mastercard_32"];
		break;
	case SIMCreditCardType_Visa:
		self.cardImageView.image = [SimplifyPrivate imageNamed:@"visa_32"];
		break;
	case SIMCreditCardType_Unknown:
		self.cardImageView.image = [SimplifyPrivate imageNamed:@"card_back_32"];
	default:
		break;
	}
	[self setNeedsLayout];
}

-(void)setCardNumberDisplayedText:(NSString*)displayedText textInputState:(SIMTextInputState)textInputState {
	self.creditCardNumberTextField.text = displayedText;
	[self setTextField:self.creditCardNumberTextField inputState:textInputState];
}

-(void)setCVCNumberDisplayedText:(NSString*)displayedText textInputState:(SIMTextInputState)textInputState {
	self.CVCNumberTextField.text = displayedText;
	[self setTextField:self.CVCNumberTextField inputState:textInputState];
}

-(void)setExpirationDateDisplayedText:(NSString*)displayedText textInputState:(SIMTextInputState)textInputState {
	self.expirationDateTextField.text = displayedText;
	[self setTextField:self.expirationDateTextField inputState:textInputState];
}

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

-(void)setSendCreditCardButtonEnabled:(BOOL)enabled {
	self.sendCreditCardButton.enabled = enabled;
}

#pragma mark - Delegate callbacks

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)replacementString {
	NSString *resultString = [textField.text stringByReplacingCharactersInRange:range withString:replacementString];
	if (textField == self.creditCardNumberTextField) {
		[self.delegate creditCardNumberInput:resultString];
	} else if (textField == self.CVCNumberTextField) {
		[self.delegate cvcNumberInput:resultString];
	} else if (textField == self.expirationDateTextField) {
		[self.delegate expirationDateInput:resultString];
	}
	return NO;
}

-(void)sendCreditCardButtonTapped {
	[self.delegate sendCreditCardButtonTapped];
}

@end
