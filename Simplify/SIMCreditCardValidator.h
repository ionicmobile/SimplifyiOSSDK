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

#import <Foundation/Foundation.h>
#import "SIMLuhnValidator.h"
#import "SIMCurrentTimeProvider.h"

typedef enum {
    SIMCreditCardType_Unknown,
    SIMCreditCardType_AmericanExpress,
    SIMCreditCardType_Visa,
    SIMCreditCardType_MasterCard,
    SIMCreditCardType_Discover,
    SIMCreditCardType_DinersClub,
    SIMCreditCardType_JCB,
    SIMCreditCardType_ChinaUnionPay,
} SIMCreditCardType;

@interface SIMCreditCardValidator : NSObject
@property (nonatomic, readonly) SIMCreditCardType cardType;
@property (nonatomic, strong, readonly) NSString* formattedCardNumber;
@property (nonatomic, strong, readonly) NSString* formattedCVCCode;
@property (nonatomic, strong, readonly) NSString* formattedExpirationDate;
@property (nonatomic, strong, readonly) NSString* expirationMonth;
@property (nonatomic, strong, readonly) NSString* expirationYear;
@property (nonatomic, readonly) BOOL isValidCardNumber;
@property (nonatomic, readonly) BOOL isValidCVC;
@property (nonatomic, readonly) BOOL isExpired;

-(id)initWithLuhnValidator:(SIMLuhnValidator*)luhnValidator timeProvider:(SIMCurrentTimeProvider*)timeProvider;
-(void)setCardNumberAsString:(NSString*)string;
-(void)setCVCCodeAsString:(NSString*)string;
-(void)setExpirationAsString:(NSString*)string;

@end