#import "SIMCreditCardNetwork.h"

@interface SIMCreditCardNetwork ()
@end

NSString *kSimplifyCommerceDefaultAPIBaseLiveUrl = @"https://sandbox.simplify.com/v1/api/";

@implementation SIMCreditCardNetwork

- (SIMCardToken *)createCardTokenWithExpirationMonth:(NSString *)expirationMonth
                                      expirationYear:(NSString *)expirationYear
			                              cardNumber:(NSString *)cardNumber
						                         cvc:(NSString *)cvc
						                       error:(NSError **)error {
	NSString *publicKey = @"sbpb_OTY1YmI4N2UtYTJiOS00ZWUzLTliMGItZTFmYzQ2OTRmYmQ3";
	SIMCardToken *cardToken = nil;
	
	NSURL *url = [[[NSURL alloc] initWithString:kSimplifyCommerceDefaultAPIBaseLiveUrl] URLByAppendingPathComponent:@"payment/cardToken"];
	// As GET, add parameters to URL
	NSMutableString *parameters = [NSMutableString stringWithFormat:@"?key=%@", [self urlEncoded:publicKey]];
	[parameters appendFormat:@"&%@=%@", [self urlEncoded:@"card[number]"], cardNumber];
	[parameters appendFormat:@"&%@=%@", [self urlEncoded:@"card[expMonth]"], expirationMonth];
	[parameters appendFormat:@"&%@=%@", [self urlEncoded:@"card[expYear]"], expirationYear];
	[parameters appendFormat:@"&%@=%@", [self urlEncoded:@"card[cvc]"], cvc];
	[parameters appendFormat:@"&%@=%@", [self urlEncoded:@"card[name]"], [self urlEncoded:cardNumber]];
	url = [NSURL URLWithString:[[url absoluteString] stringByAppendingString:parameters]];

	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:0];

	[request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
	
	// As GET, add parameters to URL
	request.HTTPMethod = @"GET";
	
	// As POST, add JSON to body
//	request.HTTPMethod = @"POST";
//	NSDictionary *requestJson = @{
//		@"key" : publicKey,
//		@"card[number]" : cardNumber,
//		@"card[expMonth]" : expirationMonth,
//		@"card[expYear]" : expirationYear,
//		@"card[cvc]" : cvc,
//		@"card[name]" : @"John Doe",
//	};
//	request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestJson options:0 error:error];
	
	if (!*error) {
		NSHTTPURLResponse *response = nil;
		NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:error];
		if (!*error) {
			if (!*error && response.statusCode >= 200 && response.statusCode < 300) {
				NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
				NSLog(@"json: %@", json);
				cardToken = [SIMCardToken cardTokenFromDictionary:json];
			}
		}
	}
	if (*error) {
		NSLog(@"%@", *error);
	}
	return cardToken;
}

- (NSString *)urlEncoded:(NSString *)value {
    return (__bridge_transfer NSString *) CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef) value, NULL,
                                                                                  (__bridge CFStringRef) @"!*'();:@&=+$,/?%#[]-.", kCFStringEncodingUTF8);
}

@end
