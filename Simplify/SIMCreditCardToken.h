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

/**
 The SIMCreditCardToken represents a Simplify credit card that has been built by the user.
 */
@interface SIMCreditCardToken : NSObject

@property (nonatomic, readonly) NSString *token;
@property (nonatomic, readonly) NSString *id;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *type;
@property (nonatomic, readonly) NSString *last4;
@property (nonatomic, readonly) NSString *addressLine1;
@property (nonatomic, readonly) NSString *addressLine2;
@property (nonatomic, readonly) NSString *addressCity;
@property (nonatomic, readonly) NSString *addressState;
@property (nonatomic, readonly) NSString *addressZip;
@property (nonatomic, readonly) NSString *addressCountry;
@property (nonatomic, readonly) NSNumber *expMonth;
@property (nonatomic, readonly) NSNumber *expYear;
@property (nonatomic, readonly) NSDate *dateCreated;

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
		dateCreated:(NSDate *)dateCreated;

+ (SIMCreditCardToken *)cardTokenFromDictionary:(NSDictionary *)dictionary;

@end
