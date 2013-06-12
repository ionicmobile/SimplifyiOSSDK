/*
 * Copyright (c) 2013, MasterCard International Incorporated
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, are
 * permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this list of
 * conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of
 * conditions and the following disclaimer in the documentation and/or other materials
 * provided with the distribution.
 * Neither the name of the MasterCard International Incorporated nor the names of its
 * contributors may be used to endorse or promote products derived from this software
 * without specific prior written permission.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
 * SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
 * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
 * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

#import <QuartzCore/QuartzCore.h>
#import "UIView+Additions.h"
#import "UIColor+Additions.h"
#import "SIMCreditCardEntryView.h"
#import "SimplifyPrivate.h"
#import "SIMLayeredButton.h"

@interface SIMCreditCardEntryView()
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIImageView* cardImageView;
@property (nonatomic, strong) UITextField* creditCardNumberTextField;
@property (nonatomic, strong) UITextField* CVCNumberTextField;
@property (nonatomic, strong) UITextField* expirationDateTextField;
@property (nonatomic, strong) UIButton* button;
@end

@implementation SIMCreditCardEntryView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( self ) {
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.font = [SimplifyPrivate boldFontOfSize:26.0f];
        titleLabel.text = @"Payment Details";
        titleLabel.textColor = [UIColor colorWithHexString:@"4a4a4a"];
        
        UIImageView* cardImageView = [[UIImageView alloc] initWithImage:[SimplifyPrivate imageNamed:@"card_back_32"]];
        
        UITextField* creditCardNumberTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        creditCardNumberTextField.leftView = [UIView paddedViewWithView:cardImageView andPadding:CGSizeMake(15, 0)];
        creditCardNumberTextField.leftViewMode = UITextFieldViewModeAlways;
        creditCardNumberTextField.layer.borderColor = [UIColor simplifyBorderColor].CGColor;
        creditCardNumberTextField.layer.borderWidth = 1.0f;
        creditCardNumberTextField.layer.masksToBounds = YES;
        creditCardNumberTextField.placeholder = @"Credit Card Number";
        creditCardNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
        [creditCardNumberTextField becomeFirstResponder];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ccChanged) name:UITextFieldTextDidChangeNotification object:creditCardNumberTextField];
        
        UITextField* CVCNumberTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        CVCNumberTextField.borderStyle = UITextBorderStyleLine;
        CVCNumberTextField.leftView = [UIView paddedViewWithView:[[UIView alloc] init] andPadding:CGSizeMake(7, 0)];
        CVCNumberTextField.leftViewMode = UITextFieldViewModeAlways;
        CVCNumberTextField.layer.borderColor = [UIColor simplifyBorderColor].CGColor;
        CVCNumberTextField.layer.borderColor = [UIColor simplifyBorderColor].CGColor;
        CVCNumberTextField.layer.borderWidth = 1.0f;
        CVCNumberTextField.layer.masksToBounds = YES;
        CVCNumberTextField.placeholder = @"CVC Code";
        CVCNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cvcChanged) name:UITextFieldTextDidChangeNotification object:CVCNumberTextField];

        UITextField* expirationDateTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        expirationDateTextField.leftView = [UIView paddedViewWithView:[[UIView alloc] init] andPadding:CGSizeMake(7, 0)];
        expirationDateTextField.leftViewMode = UITextFieldViewModeAlways;
        expirationDateTextField.borderStyle = UITextBorderStyleLine;
        expirationDateTextField.layer.borderColor = [UIColor simplifyBorderColor].CGColor;
        expirationDateTextField.layer.borderColor = [UIColor simplifyBorderColor].CGColor;
        expirationDateTextField.layer.borderWidth = 1.0f;
        expirationDateTextField.layer.masksToBounds = YES;
        expirationDateTextField.keyboardType = UIKeyboardTypeNumberPad;
        expirationDateTextField.placeholder = @" Expiration";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(expiryChanged) name:UITextFieldTextDidChangeNotification object:expirationDateTextField];

        SIMLayeredButton* button = [[SIMLayeredButton alloc] init];
        [button setTitle:@"Done" forState:UIControlStateNormal];
        button.titleLabel.font = [SimplifyPrivate boldFontOfSize:18.0f];
        button.titleLabel.shadowColor = [UIColor blackColor];
        button.titleLabel.shadowOffset = CGSizeMake(0, -1);
		[button addTarget:self action:@selector(doneButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        
        self.titleLabel = titleLabel;
        self.cardImageView = cardImageView;
        self.creditCardNumberTextField = creditCardNumberTextField;
        self.CVCNumberTextField = CVCNumberTextField;
        self.expirationDateTextField = expirationDateTextField;
        self.button = button;
        
        [self addSubview:titleLabel];
        [self addSubview:creditCardNumberTextField];
        [self addSubview:CVCNumberTextField];
        [self addSubview:expirationDateTextField];
        [self addSubview:button];
    }
    return self;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    
    [self.button centerHorizonallyAtY:CGRectGetMaxY(self.expirationDateTextField.frame) + innerMarginY inBounds:self.bounds withSize:CGSizeMake(self.bounds.size.width - 2 * outerMarginX, 50)];
}

-(void)doneButtonTapped {
	[[NSNotificationCenter defaultCenter] postNotificationName:SIMCreditCardEntryViewDoneButtonTapped object:self];
}

-(void)setCardNumber:(NSString*)cardNumber isValid:(BOOL)valid isMaximumLength:(BOOL)maximumLength {
    self.creditCardNumberTextField.text = cardNumber;
    if ( maximumLength && valid ) {
        self.creditCardNumberTextField.backgroundColor = [UIColor colorWithHexString:@"ccffcc"];
        [self.CVCNumberTextField becomeFirstResponder];
    } else if ( maximumLength && !valid ) {
        self.creditCardNumberTextField.backgroundColor = [UIColor colorWithHexString:@"ffcccc"];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
    [self setNeedsLayout];
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

-(void)setCVCCode:(NSString*)cvcCode {
    self.CVCNumberTextField.text = cvcCode;
    [self setNeedsLayout];
}

-(void)setExpirationDate:(NSString*)expiration {
    self.expirationDateTextField.text = expiration;
    [self setNeedsLayout];
}

-(void)setButtonEnabled:(BOOL)enabled {
    self.button.enabled = enabled;
}

#pragma mark - helpers

-(void)ccChanged {
    NSString* cc = self.creditCardNumberTextField.text ? self.creditCardNumberTextField.text : @"";
    [[NSNotificationCenter defaultCenter] postNotificationName:SIMCreditCardEntryViewCardNumberChanged object:self userInfo:@{
        SIMCreditCardEntryViewCardNumberKey : cc
     }];
}

-(void)cvcChanged {
    NSString* cvc = self.CVCNumberTextField.text ? self.CVCNumberTextField.text : @"";
    [[NSNotificationCenter defaultCenter] postNotificationName:SIMCreditCardEntryViewCVCNumberChanged object:self userInfo:@{
        SIMCreditCardEntryViewCVCNumberKey : cvc
     }];
}

-(void)expiryChanged {
    NSString* expiry = self.expirationDateTextField.text ? self.expirationDateTextField.text : @"";
    [[NSNotificationCenter defaultCenter] postNotificationName:SIMCreditCardEntryViewExpirationChanged object:self userInfo:@{
        SIMCreditCardEntryViewExpirationKey : expiry
     }];
}

@end
