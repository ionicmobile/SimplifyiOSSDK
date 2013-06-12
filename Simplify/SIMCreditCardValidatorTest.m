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
#import "SIMLuhnValidator.h"
#import "SIMCurrentTimeProvider.h"

@interface SIMCreditCardValidatorTest : SIMAbstractTestCase {
    SIMCreditCardValidator* testObject;
    id mockLuhnValidator;
    id mockTimeProvider;
    BOOL yes;
    BOOL no;
}
@end

@implementation SIMCreditCardValidatorTest

-(void)setUp {
    [super setUp];
    mockLuhnValidator = [OCMockObject mockForClass:SIMLuhnValidator.class];
    mockTimeProvider = [OCMockObject mockForClass:SIMCurrentTimeProvider.class];
    testObject = [[SIMCreditCardValidator alloc] initWithLuhnValidator:mockLuhnValidator timeProvider:mockTimeProvider];
    yes = YES;
}

-(void)testWhenFormattedLuhnNumberIsSubmittedThenIsIsValid {
    [[[mockLuhnValidator expect] andReturnValue:OCMOCK_VALUE(yes)] isValid:@"378282246310005"];
    [testObject setCardNumberAsString:@"378282246310005"];
    [testObject isValidCardNumber];
    [mockLuhnValidator verify];
    
    [[[mockLuhnValidator expect] andReturnValue:OCMOCK_VALUE(yes)] isValid:@"378282246310005"];
    [testObject setCardNumberAsString:@"3782-822463-10005"];
    [testObject isValidCardNumber];
    [mockLuhnValidator verify];

    [[[mockLuhnValidator expect] andReturnValue:OCMOCK_VALUE(yes)] isValid:@"371449635398431"];
    [testObject setCardNumberAsString:@"3714-496353-98431"];
    [testObject isValidCardNumber];
    [mockLuhnValidator verify];

    [[[mockLuhnValidator expect] andReturnValue:OCMOCK_VALUE(yes)] isValid:@"378282246310005"];
    [testObject setCardNumberAsString:@"3782 822463 10005"];
    [testObject isValidCardNumber];
    [mockLuhnValidator verify];

    [[[mockLuhnValidator expect] andReturnValue:OCMOCK_VALUE(yes)] isValid:@"371449635398431"];
    [testObject setCardNumberAsString:@"3714 496353 98431"];
    [testObject isValidCardNumber];
    [mockLuhnValidator verify];
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

-(void)testWhenNoCardNumberIsSetThenCardNumberIsInvalid {
    [[[mockLuhnValidator stub] andReturnValue:OCMOCK_VALUE(no)] isValid:OCMOCK_ANY];
    GHAssertFalse(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);
}

// Source: http://en.wikipedia.org/wiki/Bank_card_number 
-(void)testWhenAmexCardIsEnteredWith15DigitsThenItHasValidLength {
    mockLuhnValidator = [OCMockObject mockForClass:SIMLuhnValidator.class];
    testObject = [[SIMCreditCardValidator alloc] initWithLuhnValidator:mockLuhnValidator timeProvider:mockTimeProvider];
    [[[mockLuhnValidator stub] andReturnValue:OCMOCK_VALUE(yes)] isValid:OCMOCK_ANY];
    [testObject setCardNumberAsString:@"37828224631000"];
    GHAssertFalse(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);
    
    [testObject setCardNumberAsString:@"378282246310005"];
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertTrue(testObject.isMaximumCardNumberLength, nil);
    
    [testObject setCardNumberAsString:@"3782822463100051"];
    GHAssertEqualObjects(testObject.formattedCardNumber, @"3782 822463 10005", nil);
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertTrue(testObject.isMaximumCardNumberLength, nil);

    mockLuhnValidator = [OCMockObject mockForClass:SIMLuhnValidator.class];
    testObject = [[SIMCreditCardValidator alloc] initWithLuhnValidator:mockLuhnValidator timeProvider:mockTimeProvider];
    [[[mockLuhnValidator stub] andReturnValue:OCMOCK_VALUE(no)] isValid:OCMOCK_ANY];
    [testObject setCardNumberAsString:@"378282246310005"];
    GHAssertFalse(testObject.isValidCardNumber, nil);
}

// Source: http://en.wikipedia.org/wiki/Bank_card_number 
-(void)testWhenVisaCardHas13Or16DigitsThenItHasValidLength {
    mockLuhnValidator = [OCMockObject mockForClass:SIMLuhnValidator.class];
    testObject = [[SIMCreditCardValidator alloc] initWithLuhnValidator:mockLuhnValidator timeProvider:mockTimeProvider];
    [[[mockLuhnValidator stub] andReturnValue:OCMOCK_VALUE(yes)] isValid:OCMOCK_ANY];

    [testObject setCardNumberAsString:@"411111111111"];
    GHAssertFalse(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"4111111111111"];
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"41111111111111"];
    GHAssertFalse(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"411111111111111"];
    GHAssertFalse(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"4111111111111111"];
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertTrue(testObject.isMaximumCardNumberLength, nil);
    
    [testObject setCardNumberAsString:@"41111111111111111"];
    GHAssertEqualObjects(testObject.formattedCardNumber, @"4111 1111 1111 1111", nil);
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertTrue(testObject.isMaximumCardNumberLength, nil);
    
    mockLuhnValidator = [OCMockObject mockForClass:SIMLuhnValidator.class];
    testObject = [[SIMCreditCardValidator alloc] initWithLuhnValidator:mockLuhnValidator timeProvider:mockTimeProvider];
    [[[mockLuhnValidator stub] andReturnValue:OCMOCK_VALUE(no)] isValid:OCMOCK_ANY];
    [testObject setCardNumberAsString:@"4111111111111111"];
    GHAssertFalse(testObject.isValidCardNumber, nil);
}

// Source: http://en.wikipedia.org/wiki/Bank_card_number 
-(void)testWhenMasterCardHas16DigitsThenItHasValidLength {
    mockLuhnValidator = [OCMockObject mockForClass:SIMLuhnValidator.class];
    testObject = [[SIMCreditCardValidator alloc] initWithLuhnValidator:mockLuhnValidator timeProvider:mockTimeProvider];
    [[[mockLuhnValidator stub] andReturnValue:OCMOCK_VALUE(yes)] isValid:OCMOCK_ANY];

    [testObject setCardNumberAsString:@"510510510510510"];
    GHAssertFalse(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"5105105105105100"];
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertTrue(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"51051051051051001"];
    GHAssertEqualObjects(testObject.formattedCardNumber, @"5105 1051 0510 5100", nil);
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertTrue(testObject.isMaximumCardNumberLength, nil);

    mockLuhnValidator = [OCMockObject mockForClass:SIMLuhnValidator.class];
    testObject = [[SIMCreditCardValidator alloc] initWithLuhnValidator:mockLuhnValidator timeProvider:mockTimeProvider];
    [[[mockLuhnValidator stub] andReturnValue:OCMOCK_VALUE(no)] isValid:OCMOCK_ANY];
    [testObject setCardNumberAsString:@"5105105105105100"];
    GHAssertFalse(testObject.isValidCardNumber, nil);
}

// Source: http://en.wikipedia.org/wiki/Bank_card_number
-(void)testWhenDiscoverHas16DigitsThenItHasValidLength {
    mockLuhnValidator = [OCMockObject mockForClass:SIMLuhnValidator.class];
    testObject = [[SIMCreditCardValidator alloc] initWithLuhnValidator:mockLuhnValidator timeProvider:mockTimeProvider];
    [[[mockLuhnValidator stub] andReturnValue:OCMOCK_VALUE(yes)] isValid:OCMOCK_ANY];

    [testObject setCardNumberAsString:@"601100099013942"];
    GHAssertFalse(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"6011000990139424"];
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertTrue(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"60110009901394245"];
    GHAssertEqualObjects(testObject.formattedCardNumber, @"6011 0009 9013 9424", nil);
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertTrue(testObject.isMaximumCardNumberLength, nil);
    
    mockLuhnValidator = [OCMockObject mockForClass:SIMLuhnValidator.class];
    testObject = [[SIMCreditCardValidator alloc] initWithLuhnValidator:mockLuhnValidator timeProvider:mockTimeProvider];
    [[[mockLuhnValidator stub] andReturnValue:OCMOCK_VALUE(no)] isValid:OCMOCK_ANY];
    [testObject setCardNumberAsString:@"601100099013942"];
    GHAssertFalse(testObject.isValidCardNumber, nil);
}

// Source: http://en.wikipedia.org/wiki/Bank_card_number 
-(void)testWhenJCBHas16DigitsThenItHasValidLength {
    mockLuhnValidator = [OCMockObject mockForClass:SIMLuhnValidator.class];
    testObject = [[SIMCreditCardValidator alloc] initWithLuhnValidator:mockLuhnValidator timeProvider:mockTimeProvider];
    [[[mockLuhnValidator stub] andReturnValue:OCMOCK_VALUE(yes)] isValid:OCMOCK_ANY];

    [testObject setCardNumberAsString:@"353011133330000"];
    GHAssertFalse(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"3530111333300000"];
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertTrue(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"35301113333000000"];
    GHAssertEqualObjects(testObject.formattedCardNumber, @"3530 1113 3330 0000", nil);
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertTrue(testObject.isMaximumCardNumberLength, nil);

    mockLuhnValidator = [OCMockObject mockForClass:SIMLuhnValidator.class];
    testObject = [[SIMCreditCardValidator alloc] initWithLuhnValidator:mockLuhnValidator timeProvider:mockTimeProvider];
    [[[mockLuhnValidator stub] andReturnValue:OCMOCK_VALUE(no)] isValid:OCMOCK_ANY];
    [testObject setCardNumberAsString:@"3530111333300000"];
    GHAssertFalse(testObject.isValidCardNumber, nil);
}

// Source: http://en.wikipedia.org/wiki/Bank_card_number 
-(void)testWhenDinersClubHas14or15or16DigitsThenItHasValidLength {
    mockLuhnValidator = [OCMockObject mockForClass:SIMLuhnValidator.class];
    testObject = [[SIMCreditCardValidator alloc] initWithLuhnValidator:mockLuhnValidator timeProvider:mockTimeProvider];
    [[[mockLuhnValidator stub] andReturnValue:OCMOCK_VALUE(yes)] isValid:OCMOCK_ANY];

    [testObject setCardNumberAsString:@"3056930902590"];
    GHAssertFalse(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"30569309025904"];
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"305693090259045"];
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"3056930902590456"];
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertTrue(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"30569309025904567"];
    GHAssertEqualObjects(testObject.formattedCardNumber, @"3056 9309 0259 0456", nil);
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertTrue(testObject.isMaximumCardNumberLength, nil);

    mockLuhnValidator = [OCMockObject mockForClass:SIMLuhnValidator.class];
    testObject = [[SIMCreditCardValidator alloc] initWithLuhnValidator:mockLuhnValidator timeProvider:mockTimeProvider];
    [[[mockLuhnValidator stub] andReturnValue:OCMOCK_VALUE(no)] isValid:OCMOCK_ANY];
    [testObject setCardNumberAsString:@"305693090259045"];
    GHAssertFalse(testObject.isValidCardNumber, nil);
}

// Source: http://en.wikipedia.org/wiki/Bank_card_number 
-(void)testWhenChinaUnionPayIs16Through19DigitsThenItHasValidLength {
    
    // China Union Pay does not use Luhn Validation
    mockLuhnValidator = [OCMockObject mockForClass:SIMLuhnValidator.class];
    testObject = [[SIMCreditCardValidator alloc] initWithLuhnValidator:mockLuhnValidator timeProvider:mockTimeProvider];
    [[[mockLuhnValidator stub] andReturnValue:OCMOCK_VALUE(no)] isValid:OCMOCK_ANY];

    [testObject setCardNumberAsString:@"622126000000000"];
    GHAssertFalse(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"6221260000000000"];
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"62212600000000000"];
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"622126000000000000"];
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"6221260000000000000"];
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertTrue(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"62212600000000000000"];
    GHAssertEqualObjects(testObject.formattedCardNumber, @"6221 2600 0000 0000 000", nil);
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertTrue(testObject.isMaximumCardNumberLength, nil);
    
    mockLuhnValidator = [OCMockObject mockForClass:SIMLuhnValidator.class];
    testObject = [[SIMCreditCardValidator alloc] initWithLuhnValidator:mockLuhnValidator timeProvider:mockTimeProvider];
    [[[mockLuhnValidator stub] andReturnValue:OCMOCK_VALUE(yes)] isValid:OCMOCK_ANY];
    [testObject setCardNumberAsString:@"6221260000000000"];
    GHAssertTrue(testObject.isValidCardNumber, nil);
}

// Source: http://en.wikipedia.org/wiki/Bank_card_number 
-(void)testWhenCardUnknownThenLengthIsBetween12and19 {
    mockLuhnValidator = [OCMockObject mockForClass:SIMLuhnValidator.class];
    testObject = [[SIMCreditCardValidator alloc] initWithLuhnValidator:mockLuhnValidator timeProvider:mockTimeProvider];
    [[[mockLuhnValidator stub] andReturnValue:OCMOCK_VALUE(yes)] isValid:OCMOCK_ANY];

    [testObject setCardNumberAsString:@"56105910810"];
    GHAssertFalse(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"561059108101"];
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"5610591081018"];
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"56105910810182"];
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"561059108101825"];
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"5610591081018250"]; // e.g., Austrailian Bankcard
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"56105910810182501"];
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"561059108101825012"];
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertFalse(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"5610591081018250123"];
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertTrue(testObject.isMaximumCardNumberLength, nil);

    [testObject setCardNumberAsString:@"56105910810182501234"];
    GHAssertEqualObjects(testObject.formattedCardNumber, @"5610 5910 8101 8250 123", nil);
    GHAssertTrue(testObject.isValidCardNumber, nil);
    GHAssertTrue(testObject.isMaximumCardNumberLength, nil);
    
    mockLuhnValidator = [OCMockObject mockForClass:SIMLuhnValidator.class];
    testObject = [[SIMCreditCardValidator alloc] initWithLuhnValidator:mockLuhnValidator timeProvider:mockTimeProvider];
    [[[mockLuhnValidator stub] andReturnValue:OCMOCK_VALUE(yes)] isValid:OCMOCK_ANY];
    [testObject setCardNumberAsString:@"561059108101"];
    GHAssertTrue(testObject.isValidCardNumber, nil);
}

-(void)testWhenNoCardIsSetThenCVCIsInvalid {
    GHAssertFalse(testObject.isValidCVC, nil);
}

-(void)testWhenCVCCodeIsSetAs3or4DigitsForAnUnknownCardThenItIsValid {
    [testObject setCardNumberAsString:@"5610591081018250"]; // e.g., Austrailian Bankcard
    [testObject setCVCCodeAsString:@"123"];
    GHAssertTrue(testObject.isValidCVC, nil);
    GHAssertFalse(testObject.isMaximumCVCLength, nil);
    
    [testObject setCVCCodeAsString:@"1234"];
    GHAssertTrue(testObject.isValidCVC, nil);
    GHAssertTrue(testObject.isMaximumCVCLength, nil);
    
    [testObject setCVCCodeAsString:@"12345"];
    GHAssertEqualObjects(testObject.formattedCVCCode, @"1234", nil);
    GHAssertTrue(testObject.isValidCVC, nil);
    GHAssertTrue(testObject.isMaximumCVCLength, nil);
}

-(void)testWhenCVCCodeIsSetAs4DigitsAndAmexThenItIsValid {
    [testObject setCardNumberAsString:@"378734493671000"];
    [testObject setCVCCodeAsString:@"123"];
    GHAssertFalse(testObject.isValidCVC, nil);
    GHAssertFalse(testObject.isMaximumCVCLength, nil);

    [testObject setCardNumberAsString:@"378734493671000"];
    [testObject setCVCCodeAsString:@"1234"];
    GHAssertTrue(testObject.isValidCVC, nil);
    GHAssertTrue(testObject.isMaximumCVCLength, nil);

    [testObject setCardNumberAsString:@"378734493671000"];
    [testObject setCVCCodeAsString:@"12345"];
    GHAssertEqualObjects(testObject.formattedCVCCode, @"1234", nil);
    GHAssertTrue(testObject.isValidCVC, nil);
    GHAssertTrue(testObject.isMaximumCVCLength, nil);
}

-(void)testWhenSpecialCharactersAreInCVCThenTheyAreIgnoredAndFormatted {
    [testObject setCardNumberAsString:@"5610591081018250"]; // e.g., Austrailian Bankcard
    [testObject setCVCCodeAsString:@"1-2-3"];
    GHAssertTrue(testObject.isValidCVC, nil);
    GHAssertEqualObjects(testObject.formattedCVCCode, @"123", nil);
    
    [testObject setCardNumberAsString:@"378734493671000"];
    [testObject setCVCCodeAsString:@"1-23 4"];
    GHAssertTrue(testObject.isValidCVC, nil);
    GHAssertEqualObjects(testObject.formattedCVCCode, @"1234", nil);
}

-(void)testWhenCVCCodeForJCBIs3CharactersThenItIsValid {
    [testObject setCardNumberAsString:@"3528123412341234"];

    [testObject setCVCCodeAsString:@"12"];
    GHAssertFalse(testObject.isValidCVC, nil);
    GHAssertFalse(testObject.isMaximumCVCLength, nil);

    [testObject setCVCCodeAsString:@"123"];
    GHAssertTrue(testObject.isValidCVC, nil);
    GHAssertTrue(testObject.isMaximumCVCLength, nil);
    
    [testObject setCVCCodeAsString:@"1234"];
    GHAssertEqualObjects(testObject.formattedCVCCode, @"123", nil);
    GHAssertTrue(testObject.isValidCVC, nil);
    GHAssertTrue(testObject.isMaximumCVCLength, nil);
}

-(void)testWhenCVCCodeForMasterCardIs3CharactersThenItIsValid {
    [testObject setCardNumberAsString:@"5555555555554444"];
    
    [testObject setCVCCodeAsString:@"12"];
    GHAssertFalse(testObject.isValidCVC, nil);
    GHAssertFalse(testObject.isMaximumCVCLength, nil);
    
    [testObject setCVCCodeAsString:@"123"];
    GHAssertTrue(testObject.isValidCVC, nil);
    GHAssertTrue(testObject.isMaximumCVCLength, nil);
    
    [testObject setCVCCodeAsString:@"1234"];
    GHAssertEqualObjects(testObject.formattedCVCCode, @"123", nil);
    GHAssertTrue(testObject.isValidCVC, nil);
    GHAssertTrue(testObject.isMaximumCVCLength, nil);
}

-(void)testWhenCVCCodeForVisaIs3CharactersThenItIsValid {
    [testObject setCardNumberAsString:@"41111111111111111"];
    
    [testObject setCVCCodeAsString:@"12"];
    GHAssertFalse(testObject.isValidCVC, nil);
    GHAssertFalse(testObject.isMaximumCVCLength, nil);
    
    [testObject setCVCCodeAsString:@"123"];
    GHAssertTrue(testObject.isValidCVC, nil);
    GHAssertTrue(testObject.isMaximumCVCLength, nil);
    
    [testObject setCVCCodeAsString:@"1234"];
    GHAssertEqualObjects(testObject.formattedCVCCode, @"123", nil);
    GHAssertTrue(testObject.isValidCVC, nil);
    GHAssertTrue(testObject.isMaximumCVCLength, nil);
}

-(void)testWhenCVCCodeForDinersClubIs3CharactersThenItIsValid {
    [testObject setCardNumberAsString:@"3000111122223333"];

    [testObject setCVCCodeAsString:@"12"];
    GHAssertFalse(testObject.isValidCVC, nil);
    GHAssertFalse(testObject.isMaximumCVCLength, nil);
    
    [testObject setCVCCodeAsString:@"123"];
    GHAssertTrue(testObject.isValidCVC, nil);
    GHAssertTrue(testObject.isMaximumCVCLength, nil);
    
    [testObject setCVCCodeAsString:@"1234"];
    GHAssertEqualObjects(testObject.formattedCVCCode, @"123", nil);
    GHAssertTrue(testObject.isValidCVC, nil);
    GHAssertTrue(testObject.isMaximumCVCLength, nil);
}

-(void)testWhenCVCCodeForDiscoverIs3CharactersThenItIsValid {
    [testObject setCardNumberAsString:@"6500111122223333"];
    
    [testObject setCVCCodeAsString:@"12"];
    GHAssertFalse(testObject.isValidCVC, nil);
    GHAssertFalse(testObject.isMaximumCVCLength, nil);
    
    [testObject setCVCCodeAsString:@"123"];
    GHAssertTrue(testObject.isValidCVC, nil);
    GHAssertTrue(testObject.isMaximumCVCLength, nil);
    
    [testObject setCVCCodeAsString:@"1234"];
    GHAssertEqualObjects(testObject.formattedCVCCode, @"123", nil);
    GHAssertTrue(testObject.isValidCVC, nil);
    GHAssertTrue(testObject.isMaximumCVCLength, nil);
}

-(void)testWhenCVCCodeForUnionPayIs3CharactersThenItIsValid {
    [testObject setCardNumberAsString:@"6221261122223333"];
    
    [testObject setCVCCodeAsString:@"12"];
    GHAssertFalse(testObject.isValidCVC, nil);
    GHAssertFalse(testObject.isMaximumCVCLength, nil);
    
    [testObject setCVCCodeAsString:@"123"];
    GHAssertTrue(testObject.isValidCVC, nil);
    GHAssertTrue(testObject.isMaximumCVCLength, nil);
    
    [testObject setCVCCodeAsString:@"1234"];
    GHAssertEqualObjects(testObject.formattedCVCCode, @"123", nil);
    GHAssertTrue(testObject.isValidCVC, nil);
    GHAssertTrue(testObject.isMaximumCVCLength, nil);
}

-(void)testWhenPartialMonthIsUsedInExpirationDateMonthIsReturned {
    [testObject setExpirationAsString:@"1"];
    GHAssertEqualObjects(testObject.formattedExpirationDate, @"1", nil);
    GHAssertEqualObjects(testObject.expirationMonth, @"1", nil);
    GHAssertNil(testObject.expirationYear, nil);
}

-(void)testWhenPartialMonthIsUsedInExpirationDateYearIsReturned {
    [testObject setExpirationAsString:@"11/0"];
    GHAssertEqualObjects(testObject.formattedExpirationDate, @"11/0", nil);
    GHAssertEqualObjects(testObject.expirationMonth, @"11", nil);
    GHAssertEqualObjects(testObject.expirationYear, @"0", nil);
}

-(void)testWhenExpirationIsSetThenItIsParsed {
    [testObject setExpirationAsString:@"1213"];
    GHAssertEqualObjects(testObject.formattedExpirationDate, @"12/13", nil);
    GHAssertEqualObjects(testObject.expirationMonth, @"12", nil);
    GHAssertEqualObjects(testObject.expirationYear, @"13", nil);
    
    [testObject setExpirationAsString:@"12-13"];
    GHAssertEqualObjects(testObject.formattedExpirationDate, @"12/13", nil);
    GHAssertEqualObjects(testObject.expirationMonth, @"12", nil);
    GHAssertEqualObjects(testObject.expirationYear, @"13", nil);
    
    [testObject setExpirationAsString:@"12/13"];
    GHAssertEqualObjects(testObject.formattedExpirationDate, @"12/13", nil);
    GHAssertEqualObjects(testObject.expirationMonth, @"12", nil);
    GHAssertEqualObjects(testObject.expirationYear, @"13", nil);
}

-(void)testWhenExpirationDateIsFirstExpiredMomentThenItIsExpired  {
    NSTimeZone* earthsLastTimezone = [NSTimeZone timeZoneWithName:@"UTC-12:00"];
    NSDateComponents* components = [[NSDateComponents alloc] init];
    [components setMonth:1];
    [components setDay:1];
    [components setYear:2012];
    [components setTimeZone:earthsLastTimezone];
    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate* firstMomentOf2012ForLastTimeZone = [calendar dateFromComponents:components];
    
    [[[mockTimeProvider expect] andReturn:firstMomentOf2012ForLastTimeZone] currentTime];
    [testObject setExpirationAsString:@"12/11"];
    GHAssertTrue(testObject.isExpired, nil);
    [mockTimeProvider verify];
}

-(void)testWhenExpirationDateIsSecondExpiredMomentThenItIsExpired  {
    NSTimeZone* earthsLastTimezone = [NSTimeZone timeZoneWithName:@"UTC-12:00"];
    NSDateComponents* components = [[NSDateComponents alloc] init];
    [components setMonth:1];
    [components setDay:1];
    [components setYear:2012];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:1];
    [components setTimeZone:earthsLastTimezone];
    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate* secondMomentOf2012ForLastTimeZone = [calendar dateFromComponents:components];
    
    [[[mockTimeProvider expect] andReturn:secondMomentOf2012ForLastTimeZone] currentTime];
    [testObject setExpirationAsString:@"12/11"];
    GHAssertTrue(testObject.isExpired, nil);
    [mockTimeProvider verify];
}

-(void)testWhenExpirationDateIsNotPassedThenItIsNotExpired {
    NSTimeZone* earthsLastTimezone = [NSTimeZone timeZoneWithName:@"UTC-12:00"];
    NSDateComponents* components = [[NSDateComponents alloc] init];
    [components setMonth:12];
    [components setDay:31];
    [components setYear:2011];
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];
    [components setTimeZone:earthsLastTimezone];
    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate* lastMomentOf2011ForLastTimeZone = [calendar dateFromComponents:components];
    [[[mockTimeProvider expect] andReturn:lastMomentOf2011ForLastTimeZone] currentTime];
    [testObject setExpirationAsString:@"12/11"];
    GHAssertFalse(testObject.isExpired, nil);
    [mockTimeProvider verify];
}

@end
