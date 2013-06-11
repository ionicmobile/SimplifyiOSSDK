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
@property (nonatomic, strong) UILabel* creditCardNumberLabel;
@property (nonatomic, strong) UIImageView* cardImageView;
@property (nonatomic, strong) UITextField* creditCardNumberTextField;
@property (nonatomic, strong) UILabel* CVCNumberLabel;
@property (nonatomic, strong) UITextField* CVCNumberTextField;
@property (nonatomic, strong) UILabel* expirationDateLabel;
@property (nonatomic, strong) UITextField* expirationDateTextField;
@property (nonatomic, strong) UIButton* button;
@end

@implementation SIMCreditCardEntryView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( self ) {
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel* creditCardNumberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        creditCardNumberLabel.text = @"Card No.";
        creditCardNumberLabel.font = [SimplifyPrivate fontOfSize:14.0f];
        
        UIImageView* cardImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        UITextField* creditCardNumberTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        creditCardNumberTextField.leftView = cardImageView;
        creditCardNumberTextField.layer.borderColor = [UIColor simplifyBorderColor].CGColor;
        creditCardNumberTextField.layer.borderWidth = 1.0f;
        creditCardNumberTextField.layer.masksToBounds = YES;
         
        UILabel* CVCNumberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        CVCNumberLabel.text = @"CVC No.";
        CVCNumberLabel.font = [SimplifyPrivate fontOfSize:14.0f];
        
        UITextField* CVCNumberTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        CVCNumberTextField.borderStyle = UITextBorderStyleLine;
        CVCNumberTextField.layer.borderColor = [UIColor simplifyBorderColor].CGColor;
        CVCNumberTextField.layer.borderColor = [UIColor simplifyBorderColor].CGColor;
        CVCNumberTextField.layer.borderWidth = 1.0f;
        CVCNumberTextField.layer.masksToBounds = YES;

        UILabel* expirationDateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        expirationDateLabel.text = @"Expiration Date";
        expirationDateLabel.font = [SimplifyPrivate fontOfSize:14.0f];

        UITextField* expirationDateTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        expirationDateTextField.borderStyle = UITextBorderStyleLine;
        expirationDateTextField.layer.borderColor = [UIColor simplifyBorderColor].CGColor;
        expirationDateTextField.layer.borderColor = [UIColor simplifyBorderColor].CGColor;
        expirationDateTextField.layer.borderWidth = 1.0f;
        expirationDateTextField.layer.masksToBounds = YES;

        SIMLayeredButton* button = [[SIMLayeredButton alloc] init];
        [button setTitle:@"Make Charge" forState:UIControlStateNormal];
        button.titleLabel.font = [SimplifyPrivate boldFontOfSize:18.0f];
        button.titleLabel.shadowColor = [UIColor blackColor];
        button.titleLabel.shadowOffset = CGSizeMake(0, -1);
        
        self.creditCardNumberLabel = creditCardNumberLabel;
        self.creditCardNumberTextField = creditCardNumberTextField;
        self.CVCNumberLabel = CVCNumberLabel;
        self.CVCNumberTextField = CVCNumberTextField;
        self.expirationDateLabel = expirationDateLabel;
        self.expirationDateTextField = expirationDateTextField;
        self.button = button;
        
        [self addSubview:creditCardNumberLabel];
        [self addSubview:creditCardNumberTextField];
        [self addSubview:CVCNumberLabel];
        [self addSubview:CVCNumberTextField];
        [self addSubview:expirationDateLabel];
        [self addSubview:expirationDateTextField];
        [self addSubview:button];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    CGFloat textFieldHeight = 30.0f;
    CGFloat innerMarginY = 10.0;
    CGFloat outerMarginX = 20.0;
    CGFloat innerMarginX = 5.0;
    [self.creditCardNumberLabel setFrameAtOriginThatFitsUnbounded:CGPointMake(outerMarginX, innerMarginY + 3)];
    self.creditCardNumberTextField.frame = CGRectMake(CGRectGetMaxX(self.creditCardNumberLabel.frame) + innerMarginX, innerMarginY,  self.bounds.size.width - CGRectGetWidth(self.creditCardNumberLabel.frame) - innerMarginX - 2 * outerMarginX, textFieldHeight);
    
    [self.CVCNumberLabel setFrameAtOriginThatFitsUnbounded:CGPointMake(outerMarginX, CGRectGetMaxY(self.creditCardNumberTextField.frame) + innerMarginY + 3)];
    self.CVCNumberTextField.frame = CGRectMake(CGRectGetMaxX(self.CVCNumberLabel.frame) + innerMarginX, CGRectGetMaxY(self.creditCardNumberTextField.frame) + innerMarginY, self.bounds.size.width - CGRectGetWidth(self.CVCNumberLabel.frame) - innerMarginX - 2 * outerMarginX,textFieldHeight);
    
    [self.expirationDateLabel setFrameAtOriginThatFitsUnbounded:CGPointMake(outerMarginX, CGRectGetMaxY(self.CVCNumberTextField.frame) + innerMarginY + 3)];
    self.expirationDateTextField.frame = CGRectMake(CGRectGetMaxX(self.expirationDateLabel.frame) + innerMarginX, CGRectGetMaxY(self.CVCNumberTextField.frame) + innerMarginY, self.bounds.size.width - CGRectGetWidth(self.expirationDateLabel.frame) - innerMarginX - 2* outerMarginX,textFieldHeight);
    
    [self.button centerHorizonallyAtY:CGRectGetMaxY(self.expirationDateTextField.frame) + innerMarginY inBounds:self.bounds withSize:CGSizeMake(200, 50)];
}

-(void)setCardNumber:(NSString*)cardNumber {
    
    [self setNeedsLayout];
}

-(void)setCardType:(SIMCreditCardType)cardType {
    switch (cardType) {
        case SIMCreditCardType_AmericanExpress:
            self.cardImageView.image = [UIImage imageNamed:@"american_express_32"];
            break;
        case SIMCreditCardType_ChinaUnionPay:
            self.cardImageView.image = [UIImage imageNamed:@"china_union_pay_32"];
            break;
        case SIMCreditCardType_DinersClub:
            self.cardImageView.image = [UIImage imageNamed:@"diners_club_32"];
            break;
        case SIMCreditCardType_Discover:
            self.cardImageView.image = [UIImage imageNamed:@"discover_32"];
            break;
        case SIMCreditCardType_JCB:
            self.cardImageView.image = [UIImage imageNamed:@"jcb_32"];
            break;
        case SIMCreditCardType_MasterCard:
            self.cardImageView.image = [UIImage imageNamed:@"mastercard_32"];
            break;
        case SIMCreditCardType_Visa:
            self.cardImageView.image = [UIImage imageNamed:@"visa_32"];
            break;
        case SIMCreditCardType_Unknown:
            self.cardImageView.image = [UIImage imageNamed:@"card_back_32"];
        default:
            break;            
    }
    [self setNeedsLayout];
}

-(void)setCVCCode:(NSString*)cvcCode {
 
    [self setNeedsLayout];
}

@end
