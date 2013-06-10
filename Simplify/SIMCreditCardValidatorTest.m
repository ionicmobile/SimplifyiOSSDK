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

#import "SIMAbstractTestCase.h"
#import "SIMCreditCardValidator.h"

@interface SIMCreditCardValidatorTest : SIMAbstractTestCase {
    SIMCreditCardValidator* testObject;
}
@end

@implementation SIMCreditCardValidatorTest

-(void)setUp {
    [super setUp];
    testObject = [[SIMCreditCardValidator alloc] init];
}

-(void)testWhenNonLuhnNumberIsSubmittedThenItIsInvalid {
    [testObject setCardNumberAsString:@"79927398710"];
    GHAssertFalse([testObject isLuhnValid], nil);
    [testObject setCardNumberAsString:@"79927398711"];
    GHAssertFalse([testObject isLuhnValid], nil);
    [testObject setCardNumberAsString:@"79927398712"];
    GHAssertFalse([testObject isLuhnValid], nil);
    [testObject setCardNumberAsString:@"79927398714"];
    GHAssertFalse([testObject isLuhnValid], nil);
    [testObject setCardNumberAsString:@"79927398715"];
    GHAssertFalse([testObject isLuhnValid], nil);
    [testObject setCardNumberAsString:@"79927398716"];
    GHAssertFalse([testObject isLuhnValid], nil);
    [testObject setCardNumberAsString:@"79927398717"];
    GHAssertFalse([testObject isLuhnValid], nil);
    [testObject setCardNumberAsString:@"79927398718"];
    GHAssertFalse([testObject isLuhnValid], nil);
    [testObject setCardNumberAsString:@"79927398719"];
    GHAssertFalse([testObject isLuhnValid], nil);
}

-(void)testWhenLuhnNumberIsSubmittedThenIsIsValid {
    [testObject setCardNumberAsString:@"378282246310005"];
    GHAssertTrue([testObject isLuhnValid], nil);
    [testObject setCardNumberAsString:@"378282246310005"];
    GHAssertTrue([testObject isLuhnValid], nil);
    [testObject setCardNumberAsString:@"371449635398431"];
    GHAssertTrue([testObject isLuhnValid], nil);
    [testObject setCardNumberAsString:@"378282246310005"];
    GHAssertTrue([testObject isLuhnValid], nil);
    [testObject setCardNumberAsString:@"371449635398431"];
    GHAssertTrue([testObject isLuhnValid], nil);
}

-(void)testWhenFormattedLuhnNumberIsSubmittedThenIsIsValid {
    [testObject setCardNumberAsString:@"378282246310005"];
    GHAssertTrue([testObject isLuhnValid], nil);
    [testObject setCardNumberAsString:@"3782-822463-10005"];
    GHAssertTrue([testObject isLuhnValid], nil);
    [testObject setCardNumberAsString:@"3714-496353-98431"];
    GHAssertTrue([testObject isLuhnValid], nil);
    [testObject setCardNumberAsString:@"3782 822463 10005"];
    GHAssertTrue([testObject isLuhnValid], nil);
    [testObject setCardNumberAsString:@"3714 496353 98431"];
    GHAssertTrue([testObject isLuhnValid], nil);
}

-(void)testWhenUnknownCardIsEncounteredThenItsTypeIsUnknown {
    [testObject setCardNumberAsString:@"1"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_Unknown, nil);
}

-(void)testWhenVisaCardIsGivenThenItsTypeIsVisa {
    [testObject setCardNumberAsString:@"4"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_Visa, nil);
}

-(void)testWhenAmexCardIsGivenThenItsTypeIsAmex {
    [testObject setCardNumberAsString:@"34"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_AmericanExpress, nil);
    [testObject setCardNumberAsString:@"37"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_AmericanExpress, nil);
}

-(void)testWhenMasterCardIsGivenThenItsTypeIsMasterCard {
    [testObject setCardNumberAsString:@"51"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_MasterCard, nil);
    [testObject setCardNumberAsString:@"52"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_MasterCard, nil);
    [testObject setCardNumberAsString:@"53"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_MasterCard, nil);
    [testObject setCardNumberAsString:@"54"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_MasterCard, nil);
    [testObject setCardNumberAsString:@"55"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_MasterCard, nil);
}

-(void)testWhenDiscoverCardIsGivenThenItsTypeIsDiscover {
    [testObject setCardNumberAsString:@"65"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_Discover, nil);
    [testObject setCardNumberAsString:@"6011"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_Discover, nil);
    [testObject setCardNumberAsString:@"644"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_Discover, nil);
    [testObject setCardNumberAsString:@"645"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_Discover, nil);
    [testObject setCardNumberAsString:@"646"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_Discover, nil);
    [testObject setCardNumberAsString:@"647"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_Discover, nil);
    [testObject setCardNumberAsString:@"648"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_Discover, nil);
    [testObject setCardNumberAsString:@"649"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_Discover, nil);
}

-(void)testWhenAmexNumberIsGivenWithSeparatorsThenItIsParsedCorrectly {
    [testObject setCardNumberAsString:@"3787--344936-/ 71000"];
    GHAssertEqualObjects(testObject.formattedCardNumber, @"3787 344936 71000", nil);
}

-(void)testWhenVisaNumberIsGivenWithSeparatorsThenItIsParsedCorrectly {
    [testObject setCardNumberAsString:@"4111-11111111/1111"];
    GHAssertEqualObjects(testObject.formattedCardNumber, @"4111 1111 1111 1111", nil);
}

-(void)testWhenDiscoverNumberIsGivenThenItIsParsedCorrectly {
    [testObject setCardNumberAsString:@"6011111111111117"];
    GHAssertEqualObjects(testObject.formattedCardNumber, @"6011 1111 1111 1117", nil);
}

-(void)testWhenMasterCardNumberIsGivenThenItIsParsedCorrectly {
    [testObject setCardNumberAsString:@"5555555555554444"];
    GHAssertEqualObjects(testObject.formattedCardNumber, @"5555 5555 5555 4444", nil);
}

@end
