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

#import "SIMCreditCardToken.h"

@interface SIMCreditCardToken ()

@property (nonatomic, readwrite) NSString *token;
@property (nonatomic, readwrite) NSString *id;
@property (nonatomic, readwrite) NSString *name;
@property (nonatomic, readwrite) NSString *type;
@property (nonatomic, readwrite) NSString *last4;
@property (nonatomic, readwrite) NSString *addressLine1;
@property (nonatomic, readwrite) NSString *addressLine2;
@property (nonatomic, readwrite) NSString *addressCity;
@property (nonatomic, readwrite) NSString *addressState;
@property (nonatomic, readwrite) NSString *addressZip;
@property (nonatomic, readwrite) NSString *addressCountry;
@property (nonatomic, readwrite) NSNumber *expMonth;
@property (nonatomic, readwrite) NSNumber *expYear;
@property (nonatomic, readwrite) NSDate *dateCreated;

@end

@implementation SIMCreditCardToken

- (id)initWithToken:(NSString *)token
                 id:(NSString *)id
               name:(NSString *)name
	           type:(NSString *)type
		      last4:(NSString *)last4
	   addressLine1:(NSString *)addressLine1
	   addressLine2:(NSString *)addressLine2
		addressCity:(NSString *)addressCity
	   addressState:(NSString *)addressState
		 addressZip:(NSString *)addressZip
	 addressCountry:(NSString *)addressCountry
		   expMonth:(NSNumber *)expMonth
			expYear:(NSNumber *)expYear
		dateCreated:(NSDate *)dateCreated {
	if (self = [super init]) {
		self.token = token;
		self.id = id;
		self.name = name;
		self.type = type;
		self.last4 = last4;
		self.addressLine1 = addressLine1;
		self.addressLine2 = addressLine2;
		self.addressCity = addressCity;
		self.addressState = addressState;
		self.addressZip = addressZip;
		self.addressCountry = addressCountry;
		self.expMonth = expMonth;
		self.expYear = expYear;
		self.dateCreated = dateCreated;
	}
	return self;
}

+ (SIMCreditCardToken *)cardTokenFromDictionary:(NSDictionary *)dictionary {
	SIMCreditCardToken *cardToken = [[SIMCreditCardToken alloc] init];
	cardToken.token = dictionary[@"id"];
	cardToken.id = dictionary[@"card"][@"id"];
	cardToken.name = dictionary[@"card"][@"name"];
	cardToken.type = dictionary[@"card"][@"type"];
	cardToken.last4 = dictionary[@"card"][@"last4"];
	cardToken.addressLine1 = dictionary[@"card"][@"addressLine1"];
	cardToken.addressLine2 = dictionary[@"card"][@"addressLine2"];
	cardToken.addressCity = dictionary[@"card"][@"addressCity"];
	cardToken.addressState = dictionary[@"card"][@"addressState"];
	cardToken.addressZip = dictionary[@"card"][@"addressZip"];
	cardToken.addressCountry = dictionary[@"card"][@"addressCountry"];
	cardToken.expMonth = dictionary[@"card"][@"expMonth"];
	cardToken.expYear = dictionary[@"card"][@"expYear"];
	NSString *date = [dictionary[@"card"][@"dateCreated"] description];
	cardToken.dateCreated = [[NSDate alloc] initWithTimeIntervalSince1970:[date longLongValue] / 1000];
	return cardToken;
}

@end
