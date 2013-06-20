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

#import <UIKit/UIKit.h>
#import "SIMCreditCardToken.h"

/**
  The delegate that provides a callback once a credit card token (or error) was received from the server.
*/
@protocol SIMCreditCardEntryViewControllerDelegate <NSObject>

/**
 The user cancelled this attempt to generate a SIMCreditCardToken object from a credit card.
 */
- (void)tokenGenerationCancelled;

/**
 The user finished sending a credit card to Simplify, and either an error or a SIMCreditCardToken was returned.
 */
- (void)receivedCreditCardToken:(SIMCreditCardToken *)creditCardToken error:(NSError *)error;

@end

/**
  The UIViewController subclass that provides a SIMCreditCardToken object, representing a credit card token from the Simplify server.
*/
@interface SIMCreditCardEntryViewController : UIViewController

/**
 To use this class, set yourself as the delegate so you receive notification when the user cancels or sends a credit card.
 */
@property (nonatomic, weak) id<SIMCreditCardEntryViewControllerDelegate>delegate;

/**
 Initializes a new SIMCreditCardEntryViewController. Make sure to set yourself as the delegate of this object!

 @param publicApiToken the public API token you received when signing up to the Simplify API.
 @param showAddressView shows entry information for a US address if true.
 */
- (id)initWithPublicApiToken:(NSString *)publicApiToken addressView:(BOOL)showAddressView;

@end
