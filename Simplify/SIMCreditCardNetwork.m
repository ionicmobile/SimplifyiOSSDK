#import "SIMCreditCardNetwork.h"

@interface SIMCreditCardNetwork ()
@end

NSString *kSimplifyCommerceDefaultAPIBaseLiveUrl = @"http://labs.mastercard.com/payments-api-latest/api/";

@implementation SIMCreditCardNetwork

- (SIMCardToken *)createCardTokenWithExpirationMonth:(NSString *)expirationMonth
                                      expirationYear:(NSString *)expirationYear
			                              cardNumber:(NSString *)cardNumber
						                         cvc:(NSString *)cvc
						                       error:(NSError **)error {
	NSURL *url = [[[NSURL alloc] initWithString:kSimplifyCommerceDefaultAPIBaseLiveUrl] URLByAppendingPathComponent:@"payment/cardToken"];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:0];
	[request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
	NSHTTPURLResponse *response = nil;
	NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:error];
	SIMCardToken *cardToken = nil;
	if (!error && response.statusCode >= 200 && response.statusCode < 300) {
		NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
		cardToken = [SIMCardToken cardTokenFromDictionary:json];
	}
	return cardToken;
}

@end
