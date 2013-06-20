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

#import "SIMCreditCardTypeValidator.h"
#import "NSString+Simplify.h"

@implementation SIMCreditCardTypeValidator

- (SIMCreditCardType)creditCardTypeForCreditCardNumber:(NSString *)creditCardNumber {
	if ([creditCardNumber hasAnyPrefix:@[@"34",@"37"]]) {
		return SIMCreditCardType_AmericanExpress;
	} else if ([creditCardNumber hasAnyPrefix:@[@"65",@"6011",@"644",@"645",@"646",@"647",@"648",@"649"]]) {
		return SIMCreditCardType_Discover;
	} else if ([creditCardNumber hasAnyPrefix:@[@"51",@"52",@"53",@"54",@"55"]]) {
		return SIMCreditCardType_MasterCard;
	} else if ([creditCardNumber hasPrefix:@"4"]) {
		return SIMCreditCardType_Visa;
	} else if ([creditCardNumber hasAnyPrefix:@[@"300",@"301",@"302",@"303",@"304",@"305",@"36", @"38", @"39"]]) {
		return SIMCreditCardType_DinersClub;
	} else if ([creditCardNumber hasAnyPrefix:@[ @"624", @"625", @"626"]]) {
		return SIMCreditCardType_ChinaUnionPay;
	} else {
		NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
		if (creditCardNumber.length >= 4 ) {
			NSNumber* firstFourDigits = [formatter numberFromString:[creditCardNumber substringToIndex:4]];
			if ( firstFourDigits.unsignedIntegerValue >= 3528 && firstFourDigits.unsignedIntegerValue <= 3589 ) {
				return SIMCreditCardType_JCB;
			}
		}
		if ( creditCardNumber.length >= 6 ) {
			NSNumber* firstSixDigits = [formatter numberFromString:[creditCardNumber substringToIndex:6]];
			if ( firstSixDigits.unsignedIntegerValue >= 622126 && firstSixDigits.unsignedIntegerValue <= 622925 ) {
				return SIMCreditCardType_ChinaUnionPay;
			}
		}
	}
	return SIMCreditCardType_Unknown;
}

@end
