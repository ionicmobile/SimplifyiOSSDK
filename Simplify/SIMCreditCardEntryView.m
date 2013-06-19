#import "UIView+Additions.h"
#import "UIColor+Additions.h"
#import "SIMCreditCardEntryView.h"
#import "SimplifyPrivate.h"
#import "SIMLayeredButton.h"
#import "SIMTextFieldFactory.h"

@interface SIMCreditCardEntryView() <UITextFieldDelegate>
@property (nonatomic) UIView *extraView;
@property (nonatomic) UILabel* titleLabel;
@property (nonatomic) UIImageView* cardImageView;
@property (nonatomic) UITextField* creditCardNumberTextField;
@property (nonatomic) UITextField* CVCNumberTextField;
@property (nonatomic) UITextField* expirationDateTextField;
@property (nonatomic) UIButton* sendCreditCardButton;
@end

@implementation SIMCreditCardEntryView

- (id)init {
	return [self initWithExtraView:nil];
}

- (id)initWithExtraView:(UIView *)extraView {
	if (self = [super init]) {
		self.backgroundColor = [UIColor whiteColor];

		UILabel* titleLabel = [[UILabel alloc] init];
		titleLabel.font = [SimplifyPrivate boldFontOfSize:26.0f];
		titleLabel.text = @"Payment Details";
		titleLabel.textColor = [UIColor colorWithHexString:@"4a4a4a"];

		UIImageView* cardImageView = [[UIImageView alloc] initWithImage:[SimplifyPrivate imageNamed:@"card_back_32"]];

		SIMTextFieldFactory* factory = [[SIMTextFieldFactory alloc] init];

		SIMTextField* creditCardNumberTextField = [factory createTextFieldWithPlaceholderText:@"Credit Card Number" keyboardType:UIKeyboardTypeNumberPad];
		creditCardNumberTextField.leftView = [UIView paddedViewWithView:cardImageView andPadding:CGSizeMake(15, 0)];
		creditCardNumberTextField.textOffset = CGSizeMake(60, 2);
		[creditCardNumberTextField becomeFirstResponder];
		creditCardNumberTextField.delegate = self;

		SIMTextField* expirationDateTextField = [factory createTextFieldWithPlaceholderText:@"MM/YY" keyboardType:UIKeyboardTypeNumberPad];
		expirationDateTextField.delegate = self;

		SIMTextField* CVCNumberTextField = [factory createTextFieldWithPlaceholderText:@"CVC Code" keyboardType:UIKeyboardTypeNumberPad];
		CVCNumberTextField.delegate = self;

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

		if (extraView) {
			[self addSubview:extraView];
			self.extraView = extraView;
		}

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

	CGFloat fullWidth = CGRectGetWidth(self.bounds) - 2 * outerMarginX;

	self.creditCardNumberTextField.frame = CGRectMake(outerMarginX, innerMarginY + CGRectGetMaxY(self.titleLabel.frame),  fullWidth, textFieldHeight);
	CGFloat expirationAndCVCWidth = floorf(fullWidth * 0.45);
	self.expirationDateTextField.frame = CGRectMake(outerMarginX, CGRectGetMaxY(self.creditCardNumberTextField.frame) + innerMarginY, expirationAndCVCWidth, textFieldHeight);
	self.CVCNumberTextField.frame = CGRectMake(fullWidth + outerMarginX - expirationAndCVCWidth, CGRectGetMaxY(self.creditCardNumberTextField.frame) + innerMarginY, expirationAndCVCWidth, textFieldHeight);

	CGFloat nextY = CGRectGetMaxY(self.expirationDateTextField.frame) + innerMarginY;
	if (self.extraView) {
		CGSize addressEntrySize = [self.extraView sizeThatFits:self.bounds.size];
		self.extraView.frame = CGRectMake(0, nextY, CGRectGetWidth(self.bounds), addressEntrySize.height);
		nextY = CGRectGetMaxY(self.extraView.frame) + innerMarginY;
	}
	[self.sendCreditCardButton centerHorizonallyAtY:nextY inBounds:self.bounds withSize:CGSizeMake(self.bounds.size.width - 2 * outerMarginX, 40)];
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

- (void)setTextFieldState:(SIMTextFieldState *)textFieldState forControl:(SIMCreditCardEntryControl)control {
	switch (control) {
		case SIMCreditCardEntryControlCreditCardNumber:
			self.creditCardNumberTextField.text = textFieldState.text;
			[self setTextField:self.creditCardNumberTextField inputState:textFieldState.inputState];
			break;
		case SIMCreditCardEntryControlCVCNumber:
			self.CVCNumberTextField.text = textFieldState.text;
			[self setTextField:self.CVCNumberTextField inputState:textFieldState.inputState];
			break;
		case SIMCreditCardEntryControlExpirationDate:
			self.expirationDateTextField.text = textFieldState.text;
			[self setTextField:self.expirationDateTextField inputState:textFieldState.inputState];
			break;
		default:
			break;
	}
}

- (void)setSendCreditCardButtonEnabled:(BOOL)enabled {
	self.sendCreditCardButton.enabled = enabled;
}

#pragma mark - Delegate callbacks

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)replacementString {
	NSString *resultString = [textField.text stringByReplacingCharactersInRange:range withString:replacementString];
	SIMCreditCardEntryControl control = 0;
	if (textField == self.creditCardNumberTextField) {
		control = SIMCreditCardEntryControlCreditCardNumber;
	} else if (textField == self.CVCNumberTextField) {
		control = SIMCreditCardEntryControlCVCNumber;
	} else if (textField == self.expirationDateTextField) {
		control = SIMCreditCardEntryControlExpirationDate;
	}

	if (control) {
		[self.delegate control:control setInput:resultString];
	}
	return NO;
}

-(void)sendCreditCardButtonTapped {
	[self.delegate sendCreditCardButtonTapped];
}

@end
