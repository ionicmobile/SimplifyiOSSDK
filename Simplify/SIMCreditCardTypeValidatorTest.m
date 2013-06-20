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

#import "SIMAbstractTestCase.h"
#import "SIMCreditCardTypeValidator.h"

@interface SIMCreditCardTypeValidatorTest : SIMAbstractTestCase {
	SIMCreditCardTypeValidator* testObject;
}
@end

@implementation SIMCreditCardTypeValidatorTest

- (void)setUp {
	[super setUp];
	testObject = [[SIMCreditCardTypeValidator alloc] init];
}

- (void)tearDown {
	[super tearDown];
}

-(void)testWhenUnknownCardIsEncounteredThenItsTypeIsUnknown {
	SIMCreditCardType creditCardType = [testObject creditCardTypeForCreditCardNumber:@"1"];
	GHAssertEquals(creditCardType, SIMCreditCardType_Unknown, nil);
}

// Source: http://usa.visa.com/download/merchants/cisp_what_to_do_if_compromised.pdf pg. 25, Retreived June 10, 2013.
-(void)testWhenVisaCardIsGivenThenItsTypeIsVisa {
	SIMCreditCardType creditCardType = [testObject creditCardTypeForCreditCardNumber:@"4"];
	GHAssertEquals(creditCardType, SIMCreditCardType_Visa, nil);
}

// Source: https://www209.americanexpress.com/merchant/singlevoice/pdfs/chipnpin/EMV_Terminal%20Guide.pdf pg. 34, Retreived June 10, 2013.
-(void)testWhenAmexCardIsGivenThenItsTypeIsAmex {
	SIMCreditCardType creditCardType = [testObject creditCardTypeForCreditCardNumber:@"34"];
	GHAssertEquals(creditCardType, SIMCreditCardType_AmericanExpress, nil);
	creditCardType = [testObject creditCardTypeForCreditCardNumber:@"37"];
	GHAssertEquals(creditCardType, SIMCreditCardType_AmericanExpress, nil);
}

// Source: http://www.mastercard.com/us/merchant/pdf/BM-Entire_Manual_public.pdf pg. Section 3, pg. 16, Retreived June 10, 2013.
-(void)testWhenMasterCardIsGivenThenItsTypeIsMasterCard {
	SIMCreditCardType creditCardType = [testObject creditCardTypeForCreditCardNumber:@"51"];
	GHAssertEquals(creditCardType, SIMCreditCardType_MasterCard, nil);
	creditCardType = [testObject creditCardTypeForCreditCardNumber:@"52"];
	GHAssertEquals(creditCardType, SIMCreditCardType_MasterCard, nil);
	creditCardType = [testObject creditCardTypeForCreditCardNumber:@"53"];
	GHAssertEquals(creditCardType, SIMCreditCardType_MasterCard, nil);
	creditCardType = [testObject creditCardTypeForCreditCardNumber:@"54"];
	GHAssertEquals(creditCardType, SIMCreditCardType_MasterCard, nil);
	creditCardType = [testObject creditCardTypeForCreditCardNumber:@"55"];
	GHAssertEquals(creditCardType, SIMCreditCardType_MasterCard, nil);
}

// Source: http://www.discovernetwork.com/value-added-reseller/images/Discover_IIN_Bulletin_Apr_2012.pdf Retreived June 10, 2013.
-(void)testWhenDiscoverCardIsGivenThenItsTypeIsDiscover {
	SIMCreditCardType creditCardType = [testObject creditCardTypeForCreditCardNumber:@"6011"];
	GHAssertEquals(creditCardType, SIMCreditCardType_Discover, nil);
	for ( NSUInteger value = 644; value <= 659; ++value ) {
		creditCardType = [testObject creditCardTypeForCreditCardNumber:[NSString stringWithFormat:@"%d", value]];
		GHAssertEquals(creditCardType, SIMCreditCardType_Discover, nil);
	}
	creditCardType = [testObject creditCardTypeForCreditCardNumber:@"65"];
	GHAssertEquals(creditCardType, SIMCreditCardType_Discover, nil);
}

// Source: http://www.discovernetwork.com/value-added-reseller/images/Discover_IIN_Bulletin_Apr_2012.pdf Retreived June 10, 2013.
-(void)testWhenDinersClubInternationlIsGivenThenItsTypeIsDCI {
	SIMCreditCardType creditCardType = [testObject creditCardTypeForCreditCardNumber:@"300"];
	GHAssertEquals(creditCardType, SIMCreditCardType_DinersClub, nil);
	creditCardType = [testObject creditCardTypeForCreditCardNumber:@"301"];
	GHAssertEquals(creditCardType, SIMCreditCardType_DinersClub, nil);
	creditCardType = [testObject creditCardTypeForCreditCardNumber:@"302"];
	GHAssertEquals(creditCardType, SIMCreditCardType_DinersClub, nil);
	creditCardType = [testObject creditCardTypeForCreditCardNumber:@"303"];
	GHAssertEquals(creditCardType, SIMCreditCardType_DinersClub, nil);
	creditCardType = [testObject creditCardTypeForCreditCardNumber:@"304"];
	GHAssertEquals(creditCardType, SIMCreditCardType_DinersClub, nil);
	creditCardType = [testObject creditCardTypeForCreditCardNumber:@"305"];
	GHAssertEquals(creditCardType, SIMCreditCardType_DinersClub, nil);
	creditCardType = [testObject creditCardTypeForCreditCardNumber:@"36"];
	GHAssertEquals(creditCardType, SIMCreditCardType_DinersClub, nil);
	creditCardType = [testObject creditCardTypeForCreditCardNumber:@"38"];
	GHAssertEquals(creditCardType, SIMCreditCardType_DinersClub, nil);
	creditCardType = [testObject creditCardTypeForCreditCardNumber:@"39"];
	GHAssertEquals(creditCardType, SIMCreditCardType_DinersClub, nil);
}

// Source: http://www.discovernetwork.com/value-added-reseller/images/Discover_IIN_Bulletin_Apr_2012.pdf Retreived June 10, 2013.
-(void)testWhenJCBIsGivenThenItsTypeIsJCB {
	for ( NSUInteger value = 3528; value <= 3589; ++value ) {
		SIMCreditCardType creditCardType = [testObject creditCardTypeForCreditCardNumber:[NSString stringWithFormat:@"%d", value]];
		GHAssertEquals(creditCardType, SIMCreditCardType_JCB, nil);
	}
}

// Source: http://www.discovernetwork.com/value-added-reseller/images/Discover_IIN_Bulletin_Apr_2012.pdf Retreived June 10, 2013.
-(void)testWhenChinaUnionPayIsGivenThenItsTypeIsCUP {
	for ( NSUInteger value = 622126; value <= 622925; ++value ) {
		SIMCreditCardType creditCardType = [testObject creditCardTypeForCreditCardNumber:[NSString stringWithFormat:@"%d", value]];
		GHAssertEquals(creditCardType, SIMCreditCardType_ChinaUnionPay, nil);
	}
	SIMCreditCardType creditCardType = [testObject creditCardTypeForCreditCardNumber:@"624"];
	GHAssertEquals(creditCardType, SIMCreditCardType_ChinaUnionPay, nil);
	creditCardType = [testObject creditCardTypeForCreditCardNumber:@"625"];
	GHAssertEquals(creditCardType, SIMCreditCardType_ChinaUnionPay, nil);
	creditCardType = [testObject creditCardTypeForCreditCardNumber:@"626"];
	GHAssertEquals(creditCardType, SIMCreditCardType_ChinaUnionPay, nil);
}

@end
