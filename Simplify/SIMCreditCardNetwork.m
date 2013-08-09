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

#import "SIMCreditCardNetwork.h"

NSString *kSimplifyCommerceDefaultAPIBaseLiveUrl = @"https://sandbox.simplify.com/v1/api/";

@interface SIMCreditCardNetwork()

@property (nonatomic) NSString *publicApiToken;

@end

@implementation SIMCreditCardNetwork

- (id)initWithPublicApiToken:(NSString *)publicApiToken {
	if (self = [super init]) {
		self.publicApiToken = publicApiToken;
	}
	return self;
}

- (SIMCreditCardToken *)createCardTokenWithExpirationMonth:(NSString *)expirationMonth
											expirationYear:(NSString *)expirationYear
												cardNumber:(NSString *)cardNumber
													   cvc:(NSString *)cvc
												   address:(SIMAddress *)address
													 error:(NSError **)error {
	SIMCreditCardToken *cardToken = nil;

	NSURL *url = [[[NSURL alloc] initWithString:kSimplifyCommerceDefaultAPIBaseLiveUrl] URLByAppendingPathComponent:@"payment/cardToken"];
    
    NSMutableDictionary *addressData = [NSMutableDictionary dictionaryWithDictionary:@{@"number":[self urlEncoded:cardNumber], @"expMonth":[self urlEncoded:expirationMonth], @"expYear": [self urlEncoded:expirationYear], @"cvc": [self urlEncoded:cvc]}];
    
    if (address.name.length) {
        addressData[@"name"] = address.name;
	}
	if (address.addressLine1.length) {
        addressData[@"addressLine1"] = address.addressLine1;
	}
	if (address.addressLine2.length) {
        addressData[@"addressLine2"] = address.addressLine2;
	}
	if (address.city.length) {
        addressData[@"addressCity"] = address.city;
	}
	if (address.state.length) {
        addressData[@"addressState"] = address.state;
    }
	if (address.zip.length) {
        addressData[@"addressZip"] = address.zip;
	}
	if (address.country.length) {
        addressData[@"addressCountry"] = address.country;
	}

    NSDictionary *cardData = @{@"key": [self urlEncoded:self.publicApiToken], @"card":addressData};
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:cardData options:0 error:error];

	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:0];

    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    request.HTTPBody = jsonData;
    
	request.HTTPMethod = @"POST";

	if (!*error) {
		NSHTTPURLResponse *response = nil;
		NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:error];
		if (!*error) {
			if (response.statusCode >= 200 && response.statusCode < 300) {
				NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
				cardToken = [SIMCreditCardToken cardTokenFromDictionary:json];
			} else {
				NSString *errorMessage = [NSString stringWithFormat:@"Received bad status code of: %d. Expected between 200-299", response.statusCode];
				NSError *newError = [NSError errorWithDomain:@"com.simplify.simplifyiossdk" code:1 userInfo:@{NSLocalizedDescriptionKey:errorMessage}];
				*error = newError;
			}
		}
	}
	return cardToken;
}

- (NSString *)urlEncoded:(NSString *)value {
    return (__bridge_transfer NSString *) CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef) value, NULL, (__bridge CFStringRef) @"!*'();:@&=+$,/?%#[]-.", kCFStringEncodingUTF8);
}

@end
