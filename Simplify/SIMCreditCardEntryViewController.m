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

#import "SIMCreditCardEntryViewController.h"
#import "SIMCreditCardEntryView.h"
#import "SIMCreditCardValidator.h"
#import "SIMCurrentTimeProvider.h"
#import "SIMLuhnValidator.h"
#import "SIMCreditCardNetwork.h"

@interface SIMCreditCardEntryViewController()
@property (nonatomic, strong) SIMCreditCardNetwork *creditCardNetwork;
@property (nonatomic, strong) SIMCreditCardValidator* ccValidator;
@property (nonatomic, strong) SIMCreditCardEntryView* ccEntryView;
@end

@implementation SIMCreditCardEntryViewController

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)loadView {
    [super loadView];
	SIMCreditCardNetwork *creditCardNetwork = [[SIMCreditCardNetwork alloc] init];
    SIMLuhnValidator* luhnValidator = [[SIMLuhnValidator alloc] init];
    SIMCurrentTimeProvider* timeProvider = [[SIMCurrentTimeProvider alloc] init];
    SIMCreditCardValidator* ccValidator = [[SIMCreditCardValidator alloc] initWithLuhnValidator:luhnValidator timeProvider:timeProvider];
    SIMCreditCardEntryView* ccEntryView = [[SIMCreditCardEntryView alloc] initWithFrame:self.view.bounds];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doneButtonTapped) name:SIMCreditCardEntryViewDoneButtonTapped object:ccEntryView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ccChanged:) name:SIMCreditCardEntryViewCardNumberChanged object:ccEntryView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cvcChanged:) name:SIMCreditCardEntryViewCVCNumberChanged object:ccEntryView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(expiryChanged:) name:SIMCreditCardEntryViewExpirationChanged object:ccEntryView];
	
    self.creditCardNetwork = creditCardNetwork;
    self.ccValidator = ccValidator;
    self.ccEntryView = ccEntryView;
    
    [self.view addSubview:ccEntryView];
}

-(void)doneButtonTapped {
	NSError *error = nil;
	NSString *unformattedCardNumber = [self.ccValidator.formattedCardNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
	SIMCardToken *cardToken = [self.creditCardNetwork createCardTokenWithExpirationMonth:self.ccValidator.expirationMonth
																		  expirationYear:self.ccValidator.expirationYear
																			  cardNumber:unformattedCardNumber
																					 cvc:self.ccValidator.formattedCVCCode
																				   error:&error];
	if (error) {
		NSLog(@"network error: %@", error);
	} else {
		NSLog(@"Card Token: %@", cardToken);
	}
}

-(void)ccChanged:(NSNotification*)notification {
    [self.ccValidator setCardNumberAsString:notification.userInfo[SIMCreditCardEntryViewCardNumberKey]];
    [self.ccEntryView setCardNumber:self.ccValidator.formattedCardNumber isValid:self.ccValidator.isValidCardNumber isMaximumLength:self.ccValidator.isMaximumCVCLength];
    [self.ccEntryView setCardType:self.ccValidator.cardType];
}

-(void)cvcChanged:(NSNotification*)notification {
    [self.ccValidator setCVCCodeAsString:notification.userInfo[SIMCreditCardEntryViewCVCNumberKey]];
    [self.ccEntryView setCVCCode:self.ccValidator.formattedCVCCode];
}

-(void)expiryChanged:(NSNotification*)notification {
    [self.ccValidator setExpirationAsString:notification.userInfo[SIMCreditCardEntryViewExpirationKey]];
    [self.ccEntryView setExpirationDate:self.ccValidator.formattedExpirationDate];
	
}

@end
