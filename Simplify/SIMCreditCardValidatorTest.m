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

// Source: http://usa.visa.com/download/merchants/cisp_what_to_do_if_compromised.pdf pg. 25, Retreived June 10, 2013.
-(void)testWhenVisaCardIsGivenThenItsTypeIsVisa {
    [testObject setCardNumberAsString:@"4"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_Visa, nil);
}

// Source: https://www209.americanexpress.com/merchant/singlevoice/pdfs/chipnpin/EMV_Terminal%20Guide.pdf pg. 34, Retreived June 10, 2013.
-(void)testWhenAmexCardIsGivenThenItsTypeIsAmex {
    [testObject setCardNumberAsString:@"34"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_AmericanExpress, nil);
    [testObject setCardNumberAsString:@"37"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_AmericanExpress, nil);
}

// Source: http://www.mastercard.com/us/merchant/pdf/BM-Entire_Manual_public.pdf pg. Section 3, pg. 16, Retreived June 10, 2013.
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

// Source: http://www.discovernetwork.com/value-added-reseller/images/Discover_IIN_Bulletin_Apr_2012.pdf Retreived June 10, 2013.
-(void)testWhenDiscoverCardIsGivenThenItsTypeIsDiscover {
    [testObject setCardNumberAsString:@"6011"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_Discover, nil);
    for ( NSUInteger value = 644; value <= 659; ++value ) {
        [testObject setCardNumberAsString:[NSString stringWithFormat:@"%d", value]];
        GHAssertEquals(testObject.cardType, SIMCreditCardType_Discover, nil);
    }
    [testObject setCardNumberAsString:@"65"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_Discover, nil);
}

// Source: http://www.discovernetwork.com/value-added-reseller/images/Discover_IIN_Bulletin_Apr_2012.pdf Retreived June 10, 2013.
-(void)testWhenDinersClubInternationlIsGivenThenItsTypeIsDCI {
    [testObject setCardNumberAsString:@"300"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_DinersClub, nil);
    [testObject setCardNumberAsString:@"301"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_DinersClub, nil);
    [testObject setCardNumberAsString:@"302"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_DinersClub, nil);
    [testObject setCardNumberAsString:@"303"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_DinersClub, nil);
    [testObject setCardNumberAsString:@"304"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_DinersClub, nil);
    [testObject setCardNumberAsString:@"305"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_DinersClub, nil);
    [testObject setCardNumberAsString:@"36"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_DinersClub, nil);
    [testObject setCardNumberAsString:@"38"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_DinersClub, nil);
    [testObject setCardNumberAsString:@"39"];
}

// Source: http://www.discovernetwork.com/value-added-reseller/images/Discover_IIN_Bulletin_Apr_2012.pdf Retreived June 10, 2013.
-(void)testWhenJCBIsGivenThenItsTypeIsJCB {
    for ( NSUInteger value = 3528; value <= 3589; ++value ) {
        [testObject setCardNumberAsString:[NSString stringWithFormat:@"%d", value]];
        GHAssertEquals(testObject.cardType, SIMCreditCardType_JCB, nil);
    }
}

// Source: http://www.discovernetwork.com/value-added-reseller/images/Discover_IIN_Bulletin_Apr_2012.pdf Retreived June 10, 2013.
-(void)testWhenChinaUnionPayIsGivenThenItsTypeIsCUP {
    for ( NSUInteger value = 622126; value <= 622925; ++value ) {
        [testObject setCardNumberAsString:[NSString stringWithFormat:@"%d", value]];
        GHAssertEquals(testObject.cardType, SIMCreditCardType_ChinaUnionPay, nil);
    }
    [testObject setCardNumberAsString:@"624"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_ChinaUnionPay, nil);
    [testObject setCardNumberAsString:@"625"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_ChinaUnionPay, nil);
    [testObject setCardNumberAsString:@"626"];
    GHAssertEquals(testObject.cardType, SIMCreditCardType_ChinaUnionPay, nil);
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

// Source: http://en.wikipedia.org/wiki/Bank_card_number 
-(void)testWhenAmexCardIsEnteredWith15DigitsThenItHasValidLength {
    [testObject setCardNumberAsString:@"37828224631000"];
    GHAssertFalse(testObject.isValidLength, nil);
    [testObject setCardNumberAsString:@"378282246310005"];
    GHAssertTrue(testObject.isValidLength, nil);
    [testObject setCardNumberAsString:@"3782822463100051"];
    GHAssertFalse(testObject.isValidLength, nil);
}

// Source: http://en.wikipedia.org/wiki/Bank_card_number 
-(void)testWhenVisaCardHas13Or16DigitsThenItHasValidLength {
    [testObject setCardNumberAsString:@"411111111111"];
    GHAssertFalse(testObject.isValidLength, nil);

    [testObject setCardNumberAsString:@"4111111111111"];
    GHAssertTrue(testObject.isValidLength, nil);

    [testObject setCardNumberAsString:@"41111111111111"];
    GHAssertFalse(testObject.isValidLength, nil);

    [testObject setCardNumberAsString:@"411111111111111"];
    GHAssertFalse(testObject.isValidLength, nil);
    
    [testObject setCardNumberAsString:@"4111111111111111"];
    GHAssertTrue(testObject.isValidLength, nil);
    
    [testObject setCardNumberAsString:@"41111111111111111"];
    GHAssertFalse(testObject.isValidLength, nil);
}

// Source: http://en.wikipedia.org/wiki/Bank_card_number 
-(void)testWhenMasterCardHas16DigitsThenItHasValidLength {
    [testObject setCardNumberAsString:@"510510510510510"];
    GHAssertFalse(testObject.isValidLength, nil);

    [testObject setCardNumberAsString:@"5105105105105100"];
    GHAssertTrue(testObject.isValidLength, nil);
    
    [testObject setCardNumberAsString:@"51051051051051001"];
    GHAssertFalse(testObject.isValidLength, nil);
}

// Source: http://en.wikipedia.org/wiki/Bank_card_number
-(void)testWhenDiscoverHas16DigitsThenItHasValidLength {
    [testObject setCardNumberAsString:@"601100099013942"];
    GHAssertFalse(testObject.isValidLength, nil);
    
    [testObject setCardNumberAsString:@"6011000990139424"];
    GHAssertTrue(testObject.isValidLength, nil);

    [testObject setCardNumberAsString:@"60110009901394245"];
    GHAssertFalse(testObject.isValidLength, nil);
}

// Source: http://en.wikipedia.org/wiki/Bank_card_number 
-(void)testWhenJCBHas16DigitsThenItHasValidLength {
    [testObject setCardNumberAsString:@"353011133330000"];
    GHAssertFalse(testObject.isValidLength, nil);

    [testObject setCardNumberAsString:@"3530111333300000"];
    GHAssertTrue(testObject.isValidLength, nil);

    [testObject setCardNumberAsString:@"35301113333000000"];
    GHAssertFalse(testObject.isValidLength, nil);
}

// Source: http://en.wikipedia.org/wiki/Bank_card_number 
-(void)testWhenDinersClubHas14or15or16DigitsThenItHasValidLength {
    [testObject setCardNumberAsString:@"3056930902590"];
    GHAssertFalse(testObject.isValidLength, nil);
    
    [testObject setCardNumberAsString:@"30569309025904"];
    GHAssertTrue(testObject.isValidLength, nil);
    
    [testObject setCardNumberAsString:@"305693090259045"];
    GHAssertTrue(testObject.isValidLength, nil);
    
    [testObject setCardNumberAsString:@"3056930902590456"];
    GHAssertTrue(testObject.isValidLength, nil);
    
    [testObject setCardNumberAsString:@"30569309025904567"];
    GHAssertFalse(testObject.isValidLength, nil);
}

// Source: http://en.wikipedia.org/wiki/Bank_card_number 
-(void)testWhenChinaUnionPayIs16Through19DigitsThenItHasValidLength {
    [testObject setCardNumberAsString:@"622126000000000"];
    GHAssertFalse(testObject.isValidLength, nil);
    [testObject setCardNumberAsString:@"6221260000000000"];
    GHAssertTrue(testObject.isValidLength, nil);
    [testObject setCardNumberAsString:@"62212600000000000"];
    GHAssertTrue(testObject.isValidLength, nil);
    [testObject setCardNumberAsString:@"622126000000000000"];
    GHAssertTrue(testObject.isValidLength, nil);
    [testObject setCardNumberAsString:@"6221260000000000000"];
    GHAssertTrue(testObject.isValidLength, nil);
    [testObject setCardNumberAsString:@"62212600000000000000"];
    GHAssertFalse(testObject.isValidLength, nil);
}

// Source: http://en.wikipedia.org/wiki/Bank_card_number 
-(void)testWhenCardUnknownThenLengthIsBetween12and19 {
    [testObject setCardNumberAsString:@"56105910810"];
    GHAssertFalse(testObject.isValidLength, nil);
    [testObject setCardNumberAsString:@"561059108101"];
    GHAssertTrue(testObject.isValidLength, nil);
    [testObject setCardNumberAsString:@"5610591081018"];
    GHAssertTrue(testObject.isValidLength, nil);
    [testObject setCardNumberAsString:@"56105910810182"];
    GHAssertTrue(testObject.isValidLength, nil);
    [testObject setCardNumberAsString:@"561059108101825"];
    GHAssertTrue(testObject.isValidLength, nil);
    [testObject setCardNumberAsString:@"5610591081018250"]; // e.g., Austrailian Bankcard
    GHAssertTrue(testObject.isValidLength, nil);
    [testObject setCardNumberAsString:@"56105910810182501"];
    GHAssertTrue(testObject.isValidLength, nil);
    [testObject setCardNumberAsString:@"561059108101825012"];
    GHAssertTrue(testObject.isValidLength, nil);
    [testObject setCardNumberAsString:@"5610591081018250123"];
    GHAssertTrue(testObject.isValidLength, nil);
    [testObject setCardNumberAsString:@"56105910810182501234"];
    GHAssertFalse(testObject.isValidLength, nil);
}

@end
