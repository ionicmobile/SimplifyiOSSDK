#import "UIView+Additions.h"
#import "UIColor+Additions.h"
#import "SIMCreditCardEntryView.h"
#import "SimplifyPrivate.h"
#import "SIMLayeredButton.h"
#import "SIMTextFieldFactory.h"

@interface SIMCreditCardEntryView() <UITextFieldDelegate>
@property (nonatomic) SIMAddressEntryView *addressEntryView;
@property (nonatomic) UILabel* titleLabel;
@property (nonatomic) UIImageView* cardImageView;
@property (nonatomic) UITextField* creditCardNumberTextField;
@property (nonatomic) UITextField* CVCNumberTextField;
@property (nonatomic) UITextField* expirationDateTextField;
@property (nonatomic) UIButton* sendCreditCardButton;
@end

@implementation SIMCreditCardEntryView

- (id)init {
	return [self initWithAddressEntryView:nil];
}

- (id)initWithAddressEntryView:(SIMAddressEntryView*)addressEntryView {
	if (self = [super init]) {
		self.backgroundColor = [UIColor whiteColor];

		UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		titleLabel.font = [SimplifyPrivate boldFontOfSize:26.0f];
		titleLabel.text = @"Payment Details";
		titleLabel.textColor = [UIColor colorWithHexString:@"4a4a4a"];

		UIImageView* cardImageView = [[UIImageView alloc] initWithImage:[SimplifyPrivate imageNamed:@"card_back_32"]];

		SIMTextFieldFactory* factory = [[SIMTextFieldFactory alloc] init];

		SIMTextField* creditCardNumberTextField = [factory createTextFieldWithPlaceholderText:@"Credit Card Number" keyboardType:UIKeyboardTypeNumberPad];
		creditCardNumberTextField.leftView = [UIView paddedViewWithView:cardImageView andPadding:CGSizeMake(15, 0)];
		[creditCardNumberTextField becomeFirstResponder];
		creditCardNumberTextField.delegate = self;

		SIMTextField* CVCNumberTextField = [factory createTextFieldWithPlaceholderText:@"CVC Code" keyboardType:UIKeyboardTypeNumberPad];
		CVCNumberTextField.delegate = self;

		SIMTextField* expirationDateTextField = [factory createTextFieldWithPlaceholderText:@"MM/YY" keyboardType:UIKeyboardTypeNumberPad];
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

		if (addressEntryView) {
			[self addSubview:addressEntryView];
			self.addressEntryView = addressEntryView;
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

	self.creditCardNumberTextField.frame = CGRectMake(outerMarginX, innerMarginY + CGRectGetMaxY(self.titleLabel.frame),  self.bounds.size.width - 2 * outerMarginX, textFieldHeight);

	self.CVCNumberTextField.frame = CGRectMake(outerMarginX, CGRectGetMaxY(self.creditCardNumberTextField.frame) + innerMarginY, (self.bounds.size.width - innerMarginX - 2 * outerMarginX)/2,textFieldHeight);

	self.expirationDateTextField.frame = CGRectMake(CGRectGetMaxX(self.CVCNumberTextField.frame) + innerMarginX, CGRectGetMaxY(self.creditCardNumberTextField.frame) + innerMarginY, (self.bounds.size.width - innerMarginX - 2 * outerMarginX)/2,textFieldHeight);

	CGFloat nextY = CGRectGetMaxY(self.expirationDateTextField.frame) + innerMarginY;
	if (self.addressEntryView) {
		CGSize addressEntrySize = [self.addressEntryView sizeThatFits:self.bounds.size];
		self.addressEntryView.frame = CGRectMake(0, nextY, CGRectGetWidth(self.bounds), addressEntrySize.height);
		nextY = CGRectGetMaxY(self.addressEntryView.frame) + innerMarginY;
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
