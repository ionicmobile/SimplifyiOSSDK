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

#define IS_EVEN(x) (!((x)%2))
#define IS_ODD(x) (!IS_EVEN(x))

#import "SIMCreditCardValidator.h"
#import "NSString+Simplify.h"

@interface SIMCreditCardValidator()
@property (nonatomic, strong) NSString* digitsOnlyString;
@end

@implementation SIMCreditCardValidator

-(SIMCreditCardType)cardType {
    if ([self.digitsOnlyString hasAnyPrefix:@[@"34",@"37"]]) {
        return SIMCreditCardType_AmericanExpress;
    } else if ([self.digitsOnlyString hasAnyPrefix:@[@"65",@"6011",@"644",@"645",@"646",@"647",@"648",@"649"]]) {
        return SIMCreditCardType_Discover;
    } else if ([self.digitsOnlyString hasAnyPrefix:@[@"51",@"52",@"53",@"54",@"55"]]) {
        return SIMCreditCardType_MasterCard;
    } else if ([self.digitsOnlyString hasPrefix:@"4"]) {
        return SIMCreditCardType_Visa;
    } else if ([self.digitsOnlyString hasAnyPrefix:@[@"300",@"301",@"302",@"303",@"304",@"305",@"36", @"38", @"39"]]) {
        return SIMCreditCardType_DinersClub;
    } else if ([self.digitsOnlyString hasAnyPrefix:@[ @"624", @"625", @"626"]]) {
        return SIMCreditCardType_ChinaUnionPay;
    } else {
        NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
        if (self.digitsOnlyString.length >= 4 ) {
            NSNumber* firstFourDigits = [formatter numberFromString:[self.digitsOnlyString substringToIndex:4]];
            if ( firstFourDigits.unsignedIntegerValue >= 3528 && firstFourDigits.unsignedIntegerValue <= 3589 ) {
                return SIMCreditCardType_JCB;
            }
        }
        if ( self.digitsOnlyString.length >= 6 ) {
            NSNumber* firstSixDigits = [formatter numberFromString:[self.digitsOnlyString substringToIndex:6]];
            if ( firstSixDigits.unsignedIntegerValue >= 622126 && firstSixDigits.unsignedIntegerValue <= 622925 ) {
                return SIMCreditCardType_ChinaUnionPay;
            }
        }
    }
    return SIMCreditCardType_Unknown;
}

-(void)setCardNumberAsString:(NSString*)string {
    NSCharacterSet* nonDecimals = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    self.digitsOnlyString = [[string componentsSeparatedByCharactersInSet:nonDecimals] componentsJoinedByString:@""];
}

-(NSString*)formattedCardNumber {
    switch (self.cardType) {
        case SIMCreditCardType_AmericanExpress: {
            return [self.digitsOnlyString stringDividedByString:@" " beforeIndicies:@[ @4, @10 ]];
        }
        default:
            return [self.digitsOnlyString stringDividedByString:@" " beforeIndicies:@[ @4, @8, @12]];
    }
}

-(BOOL)isLuhnValid {
    NSUInteger checksum = 0;
    for ( NSInteger i = self.digitsOnlyString.length - 1; i >= 0;  --i ) {
        NSUInteger value = [self valueOf:[self.digitsOnlyString characterAtIndex:i]];
        NSUInteger doubleValue = value * 2;
        if ( IS_ODD(self.digitsOnlyString.length - i) ) {
            checksum += value;
        } else if ( doubleValue <= 9 ) {
            checksum += doubleValue;
        } else {
            checksum += 1 + (doubleValue - 10);
        }
    }
    return ((checksum % 10) == 0);
}

-(BOOL)isValidLength {
    switch (self.cardType) {
        case SIMCreditCardType_AmericanExpress:
            return self.digitsOnlyString.length == 15;
        case SIMCreditCardType_Visa:
            return self.digitsOnlyString.length == 13 || self.digitsOnlyString.length == 16;
        case SIMCreditCardType_Discover:
        case SIMCreditCardType_MasterCard:
        case SIMCreditCardType_JCB:
            return self.digitsOnlyString.length == 16;
        case SIMCreditCardType_DinersClub:
            return self.digitsOnlyString.length >= 14 && self.digitsOnlyString.length <= 16;
        case SIMCreditCardType_ChinaUnionPay:
            return self.digitsOnlyString.length >= 16 && self.digitsOnlyString.length <= 19;
        default:
            return self.digitsOnlyString.length >= 12 && self.digitsOnlyString.length <= 19;
    }
}

#pragma mark - helpers

-(NSUInteger)valueOf:(unichar)c {
    return c - '0';
}

@end
