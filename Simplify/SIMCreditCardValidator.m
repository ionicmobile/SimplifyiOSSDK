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


#import "SIMCreditCardValidator.h"
#import "NSString+Simplify.h"

@interface SIMCreditCardValidator()
@property (nonatomic, strong) SIMLuhnValidator* luhnValidator;
@property (nonatomic, strong) SIMCurrentTimeProvider* timeProvider;

@property (nonatomic, strong, readwrite) NSString* expirationMonth;
@property (nonatomic, strong, readwrite) NSString* expirationYear;

@property (nonatomic, strong) NSString* digitsOnlyCardNumberString;
@property (nonatomic, strong) NSString* digitsOnlyCVCNumberString;
@property (nonatomic, strong) NSString* digitsOnlyExpirationDateString;
@end

@implementation SIMCreditCardValidator

-(id)initWithLuhnValidator:(SIMLuhnValidator*)luhnValidator timeProvider:(SIMCurrentTimeProvider*)timeProvider {
    self = [super init];
    if ( self ) {
        self.luhnValidator = luhnValidator;
        self.timeProvider = timeProvider;
    }
    return self;
}

-(SIMCreditCardType)cardType {
    if ([self.digitsOnlyCardNumberString hasAnyPrefix:@[@"34",@"37"]]) {
        return SIMCreditCardType_AmericanExpress;
    } else if ([self.digitsOnlyCardNumberString hasAnyPrefix:@[@"65",@"6011",@"644",@"645",@"646",@"647",@"648",@"649"]]) {
        return SIMCreditCardType_Discover;
    } else if ([self.digitsOnlyCardNumberString hasAnyPrefix:@[@"51",@"52",@"53",@"54",@"55"]]) {
        return SIMCreditCardType_MasterCard;
    } else if ([self.digitsOnlyCardNumberString hasPrefix:@"4"]) {
        return SIMCreditCardType_Visa;
    } else if ([self.digitsOnlyCardNumberString hasAnyPrefix:@[@"300",@"301",@"302",@"303",@"304",@"305",@"36", @"38", @"39"]]) {
        return SIMCreditCardType_DinersClub;
    } else if ([self.digitsOnlyCardNumberString hasAnyPrefix:@[ @"624", @"625", @"626"]]) {
        return SIMCreditCardType_ChinaUnionPay;
    } else {
        NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
        if (self.digitsOnlyCardNumberString.length >= 4 ) {
            NSNumber* firstFourDigits = [formatter numberFromString:[self.digitsOnlyCardNumberString substringToIndex:4]];
            if ( firstFourDigits.unsignedIntegerValue >= 3528 && firstFourDigits.unsignedIntegerValue <= 3589 ) {
                return SIMCreditCardType_JCB;
            }
        }
        if ( self.digitsOnlyCardNumberString.length >= 6 ) {
            NSNumber* firstSixDigits = [formatter numberFromString:[self.digitsOnlyCardNumberString substringToIndex:6]];
            if ( firstSixDigits.unsignedIntegerValue >= 622126 && firstSixDigits.unsignedIntegerValue <= 622925 ) {
                return SIMCreditCardType_ChinaUnionPay;
            }
        }
    }
    return SIMCreditCardType_Unknown;
}

-(void)setCardNumberAsString:(NSString*)string {
    NSCharacterSet* nonDecimals = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    self.digitsOnlyCardNumberString = [[string componentsSeparatedByCharactersInSet:nonDecimals] componentsJoinedByString:@""];
    if ( self.digitsOnlyCardNumberString.length > self.maximumCardNumberLength) {
        NSMutableString* digitsOnly = [self.digitsOnlyCardNumberString mutableCopy];
        self.digitsOnlyCardNumberString = [digitsOnly substringToIndex:self.maximumCardNumberLength];
    }
}

-(void)setCVCCodeAsString:(NSString*)string {
    NSCharacterSet* nonDecimals = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    self.digitsOnlyCVCNumberString = [[string componentsSeparatedByCharactersInSet:nonDecimals] componentsJoinedByString:@""];
    if ( self.digitsOnlyCVCNumberString.length > self.maximumCVCLength) {
        NSMutableString* digitsOnly = [self.digitsOnlyCVCNumberString mutableCopy];
        self.digitsOnlyCVCNumberString = [digitsOnly substringToIndex:self.maximumCVCLength];
    }
}

-(void)setExpirationAsString:(NSString*)string {
    NSCharacterSet* nonDecimals = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    self.digitsOnlyExpirationDateString = [[string componentsSeparatedByCharactersInSet:nonDecimals] componentsJoinedByString:@""];
}

-(NSString*)formattedCardNumber {
    switch (self.cardType) {
        case SIMCreditCardType_AmericanExpress: {
            return [self.digitsOnlyCardNumberString stringDividedByString:@" " beforeIndicies:@[ @4, @10 ]];
        }
        default:
            return [self.digitsOnlyCardNumberString stringDividedByString:@" " beforeIndicies:@[ @4, @8, @12, @16]];
    }
}

-(NSString*)formattedCVCCode {
    return _digitsOnlyCVCNumberString;
}

-(NSString*)formattedExpirationDate {
    NSMutableString* expirationDate = [NSMutableString string];
    if ( self.expirationMonth ) {
        [expirationDate appendString:self.expirationMonth];
        if (self.expirationYear ) {
            [expirationDate appendString:@"/"];
            [expirationDate appendString:self.expirationYear];
        }
        return expirationDate;
    }
    return nil;
}

-(NSString*)expirationMonth {
    if ( self.digitsOnlyExpirationDateString.length >= 2 ) {
        return [self.digitsOnlyExpirationDateString substringToIndex:2];
    } else if (self.digitsOnlyExpirationDateString.length >= 1 ) {
        return [self.digitsOnlyExpirationDateString substringToIndex:1];
    }
    return nil;
}

-(NSString*)expirationYear {
    if ( self.digitsOnlyExpirationDateString.length >= 4 ) {
        return [[self.digitsOnlyExpirationDateString substringFromIndex:2] substringToIndex:2];
    } else if (self.digitsOnlyExpirationDateString.length >= 3 ) {
        return [[self.digitsOnlyExpirationDateString substringFromIndex:2] substringToIndex:1];
    }
    return nil;
}

-(BOOL)isValid {
    return NO;
}

-(NSArray*)validCardNumberLengths {
    switch (self.cardType) {
        case SIMCreditCardType_AmericanExpress:
            return @[ @15 ];
        case SIMCreditCardType_Visa:
            return @[ @13, @16 ];
        case SIMCreditCardType_Discover:
        case SIMCreditCardType_MasterCard:
        case SIMCreditCardType_JCB:
            return @[ @16 ];
        case SIMCreditCardType_DinersClub:
            return @[ @14, @15, @16 ];
        case SIMCreditCardType_ChinaUnionPay:
            return @[ @16, @17, @18, @19];
        default:
            break;
    }
    return @[@12, @13, @14, @15, @16, @17, @18, @19];
}

-(NSArray*)validCVCLengths {
    switch (self.cardType) {
        case SIMCreditCardType_AmericanExpress:
            return @[ @4 ];
        case SIMCreditCardType_JCB:
        case SIMCreditCardType_MasterCard:
        case SIMCreditCardType_Visa:
        case SIMCreditCardType_DinersClub:
        case SIMCreditCardType_Discover:
        case SIMCreditCardType_ChinaUnionPay:
            return @[ @3 ];
        default:
            break;
    }
    return @[ @3, @4 ];
}

-(NSUInteger)maximumCardNumberLength {
    return [self.validCardNumberLengths.lastObject unsignedIntegerValue];
}

-(NSUInteger)maximumCVCLength {
    return [self.validCVCLengths.lastObject unsignedIntegerValue];
}

-(BOOL)isValidCardNumberLength {
    return [self.validCardNumberLengths containsObject:@(self.digitsOnlyCardNumberString.length)];
}

-(BOOL)isMaximumCardNumberLength {
    return [self.validCardNumberLengths.lastObject isEqual:@(self.digitsOnlyCardNumberString.length)];
}

-(BOOL)isValidCardNumber {
    return self.isValidCardNumberLength && ([self.luhnValidator isValid:self.digitsOnlyCardNumberString] || self.cardType == SIMCreditCardType_ChinaUnionPay);
}

-(BOOL)isValidCVC {
    return [self.validCVCLengths containsObject:@(self.digitsOnlyCVCNumberString.length)];
}

-(BOOL)isMaximumCVCLength {
    return [self.validCVCLengths.lastObject isEqual:@(self.digitsOnlyCVCNumberString.length)];
}

-(BOOL)isExpired {
    NSTimeZone* earthsLastTimezone = [NSTimeZone timeZoneWithName:@"UTC-12:00"];
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    NSNumber* expirationMonth = [numberFormatter numberFromString:self.expirationMonth];
    NSNumber* expirationYear = [numberFormatter numberFromString:self.expirationYear];
    NSDateComponents *expirationComponents = [[NSDateComponents alloc] init];
    [expirationComponents setMonth:expirationMonth.unsignedIntValue];
    [expirationComponents setDay:1];
    [expirationComponents setYear:2000 + expirationYear.unsignedIntValue];
    [expirationComponents setTimeZone:earthsLastTimezone];
    
    NSDateComponents* monthComponents = [[NSDateComponents alloc] init];
    [monthComponents setMonth:1];
    [monthComponents setTimeZone:earthsLastTimezone];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate* beginExpirationMonth = [calendar dateFromComponents:expirationComponents];
    NSDate* justPastExpirationMonth = [calendar dateByAddingComponents:monthComponents toDate:beginExpirationMonth options:0];
    
    NSDate* currentTime = self.timeProvider.currentTime;
    return [justPastExpirationMonth compare:currentTime] == NSOrderedAscending || [justPastExpirationMonth compare:currentTime] == NSOrderedSame;
}


@end
