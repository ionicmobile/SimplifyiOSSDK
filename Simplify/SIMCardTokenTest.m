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
#import "SIMCreditCardToken.h"

@interface SIMCardTokenTest : SIMAbstractTestCase {
	SIMCreditCardToken* testObject;
}
@end

@implementation SIMCardTokenTest


- (void)testFromDictionary_BuildsObjectFromDictionaryCorrectly {
	NSDictionary *cardDictionary = @{
			@"name" : @"myCard",
			@"type" : @"someType",
			@"last4" : @"1234",
			@"addressLine1" : @"100 Happy Drive",
			@"addressLine2" : @"Apartment A",
			@"addressCity" : @"Saint Louis",
			@"addressState" : @"Missouri",
			@"addressZip" : @"63333",
			@"addressCountry" : @"USA",
			@"expMonth" : @"02",
			@"expYear" : @"15",
			@"dateCreated" : @"1371130986562"
	};
	NSDictionary *dictionary = @{@"id" : @"myCardTokenId", @"card" : cardDictionary};

	testObject = [SIMCreditCardToken cardTokenFromDictionary:dictionary];

	GHAssertEqualStrings(testObject.token, @"myCardTokenId", nil);
	GHAssertEqualStrings(testObject.name, @"myCard", nil);
	GHAssertEqualStrings(testObject.type, @"someType", nil);
	GHAssertEqualStrings(testObject.last4, @"1234", nil);
	GHAssertEqualStrings(testObject.addressLine1, @"100 Happy Drive", nil);
	GHAssertEqualStrings(testObject.addressLine2, @"Apartment A", nil);
	GHAssertEqualStrings(testObject.addressCity, @"Saint Louis", nil);
	GHAssertEqualStrings(testObject.addressState, @"Missouri", nil);
	GHAssertEqualStrings(testObject.addressZip, @"63333", nil);
	GHAssertEqualStrings(testObject.addressCountry, @"USA", nil);
	GHAssertEqualStrings(testObject.expMonth, @"02", nil);
	GHAssertEqualStrings(testObject.expYear, @"15", nil);
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:1371130986562 / 1000];
	GHAssertEqualObjects(testObject.dateCreated, date, nil);
}

@end
