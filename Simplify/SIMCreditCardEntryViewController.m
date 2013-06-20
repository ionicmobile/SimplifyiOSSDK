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

#import "SIMCreditCardEntryViewController.h"
#import "SIMAddressEntryModel.h"
#import "SIMCreditCardEntryModel.h"
#import "SIMCreditCardEntryView.h"
#import "SIMAddressEntryViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface SIMCreditCardEntryViewController() <SIMCreditCardEntryViewDelegate>
@property (nonatomic) SIMCreditCardEntryModel *model;
@property (nonatomic) SIMCreditCardEntryView *internalView;
@property (nonatomic) SIMAddressEntryViewController *addressViewController;
@end

@implementation SIMCreditCardEntryViewController

- (id)initWithPublicApiToken:(NSString *)publicApiToken addressView:(BOOL)showAddressView {
	if (self = [super init]) {
		SIMCreditCardNetwork *creditCardNetwork = [[SIMCreditCardNetwork alloc] initWithPublicApiToken:publicApiToken];
		SIMLuhnValidator *luhnValidator = [[SIMLuhnValidator alloc] init];
		SIMCurrentTimeProvider *timeProvider = [[SIMCurrentTimeProvider alloc] init];
		SIMCreditCardValidator *creditCardValidator = [[SIMCreditCardValidator alloc] initWithLuhnValidator:luhnValidator timeProvider:timeProvider];
		SIMCreditCardEntryModel *model = [[SIMCreditCardEntryModel alloc] initWithCreditCardNetwork:creditCardNetwork creditCardValidator:creditCardValidator];

		UIView *extraView = nil;
		if (showAddressView) {
			self.addressViewController = [[SIMAddressEntryViewController alloc] init];
			extraView = self.addressViewController.view;
		}

		SIMCreditCardEntryView *view = [[SIMCreditCardEntryView alloc] initWithExtraView:extraView];

		self.model = model;
		self.internalView = view;
	}
	return self;
}

- (void)loadView {
	[super loadView];
	self.view = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:self.view.bounds];
	self.internalView.frame = self.view.bounds;
	[self.view addSubview:self.internalView];
	self.internalView.delegate = self;
}

- (void)updateCardTypeAndCreditCardButtonEnabled {
	[self.internalView setCardType:self.model.creditCardType];
	[self.internalView setSendCreditCardButtonEnabled:self.model.canSendCreditCard];
}

#pragma mark - SIMCreditCardEntryViewDelegate Methods

- (void)control:(SIMCreditCardEntryControl)control setInput:(NSString *)input {
	SIMTextFieldState *textFieldState = [self.model stateForControl:control withInput:input];
	[self.internalView setTextFieldState:textFieldState forControl:control];
	[self updateCardTypeAndCreditCardButtonEnabled];
}

- (void)sendCreditCardButtonTapped {
	NSError *error = nil;
	SIMCreditCardToken *creditCardToken = [self.model sendForCreditCardTokenUsingAddress:self.addressViewController.address error:&error];
	[self.delegate receivedCreditCardToken:creditCardToken error:error];
}

- (void)cancelButtonTapped {
	[self.delegate tokenGenerationCancelled];
}

@end
