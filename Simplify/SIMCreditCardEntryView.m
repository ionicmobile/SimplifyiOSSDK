/* Copyright (c) 2013, Asynchrony Solutions, Inc.
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are met:
 *
 *    * Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *
 *    * Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *
 *    * Neither the name of Asynchrony Solutions, Inc. nor the
 *      names of its contributors may be used to endorse or promote products
 *      derived from this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 *  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 *  DISCLAIMED. IN NO EVENT SHALL ASYNCHRONY SOLUTIONS, INC. BE LIABLE FOR ANY
 *  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 *  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 *  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

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
@property (nonatomic) UIButton* cancelButton;
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
		titleLabel.textColor = [UIColor simplifyDarkTextColor];

		UIImageView* cardImageView = [[UIImageView alloc] initWithImage:[SimplifyPrivate imageNamed:@"blank"]];

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

		SIMLayeredButton* cancelButton = [[SIMLayeredButton alloc] init];
		[cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
		cancelButton.titleLabel.font = [SimplifyPrivate boldFontOfSize:18.0f];
		cancelButton.titleLabel.shadowColor = [UIColor blackColor];
		cancelButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
		[cancelButton addTarget:self action:@selector(cancelButtonTapped) forControlEvents:UIControlEventTouchUpInside];

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
		self.cancelButton = cancelButton;
		self.sendCreditCardButton = sendCreditCardButton;

		if (extraView) {
			[self addSubview:extraView];
			self.extraView = extraView;
		}

		[self addSubview:titleLabel];
		[self addSubview:creditCardNumberTextField];
		[self addSubview:CVCNumberTextField];
		[self addSubview:expirationDateTextField];
		[self addSubview:cancelButton];
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

	CGFloat buttonWidth = (fullWidth - innerMarginX) / 2;
	self.cancelButton.frame = CGRectMake(outerMarginX, nextY, buttonWidth, 40);
	self.sendCreditCardButton.frame = CGRectMake(CGRectGetMaxX(self.cancelButton.frame) + innerMarginX, nextY, buttonWidth, 40);
}

-(void)setCardType:(SIMCreditCardType)cardType {
	switch (cardType) {
	case SIMCreditCardType_AmericanExpress:
		self.cardImageView.image = [SimplifyPrivate imageNamed:@"amex"];
		break;
	case SIMCreditCardType_ChinaUnionPay:
		self.cardImageView.image = [SimplifyPrivate imageNamed:@"china-union"];
		break;
	case SIMCreditCardType_DinersClub:
		self.cardImageView.image = [SimplifyPrivate imageNamed:@"diners"];
		break;
	case SIMCreditCardType_Discover:
		self.cardImageView.image = [SimplifyPrivate imageNamed:@"discover"];
		break;
	case SIMCreditCardType_JCB:
		self.cardImageView.image = [SimplifyPrivate imageNamed:@"jcb"];
		break;
	case SIMCreditCardType_MasterCard:
		self.cardImageView.image = [SimplifyPrivate imageNamed:@"mastercard"];
		break;
	case SIMCreditCardType_Visa:
		self.cardImageView.image = [SimplifyPrivate imageNamed:@"visa"];
		break;
	case SIMCreditCardType_Unknown:
		self.cardImageView.image = [SimplifyPrivate imageNamed:@"blank"];
	default:
		break;
	}
	[self setNeedsLayout];
}

- (void)setTextField:(UITextField *)textField inputState:(SIMTextInputState)inputState {
	switch (inputState) {
	case SIMTextInputStateBad:
		textField.backgroundColor = [UIColor simplifyLightRedColor];
		break;
	case SIMTextInputStateGood:
		textField.backgroundColor = [UIColor simplifyLightGreenColor];
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

- (void)sendCreditCardButtonTapped {
	[self.delegate sendCreditCardButtonTapped];
}

- (void)cancelButtonTapped {
	[self.delegate cancelButtonTapped];
}

@end
