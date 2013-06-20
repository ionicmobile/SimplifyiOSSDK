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
	// As GET, add parameters to URL
	NSMutableString *parameters = [NSMutableString stringWithFormat:@"?key=%@", [self urlEncoded:self.publicApiToken]];
	[parameters appendFormat:@"&%@=%@", [self urlEncoded:@"card[number]"], cardNumber];
	[parameters appendFormat:@"&%@=%@", [self urlEncoded:@"card[expMonth]"], expirationMonth];
	[parameters appendFormat:@"&%@=%@", [self urlEncoded:@"card[expYear]"], expirationYear];
	[parameters appendFormat:@"&%@=%@", [self urlEncoded:@"card[cvc]"], cvc];
	if (address.name.length) {
		[parameters appendFormat:@"&%@=%@", [self urlEncoded:@"card[name]"], [self urlEncoded:address.name]];
	}
	if (address.addressLine1.length) {
		[parameters appendFormat:@"&%@=%@", [self urlEncoded:@"card[addressLine1]"], [self urlEncoded:address.addressLine1]];
	}
	if (address.addressLine2.length) {
		[parameters appendFormat:@"&%@=%@", [self urlEncoded:@"card[addressLine2]"], [self urlEncoded:address.addressLine2]];
	}
	if (address.city.length) {
		[parameters appendFormat:@"&%@=%@", [self urlEncoded:@"card[addressCity]"], [self urlEncoded:address.city]];
	}
	if (address.state.length) {
		[parameters appendFormat:@"&%@=%@", [self urlEncoded:@"card[addressState]"], [self urlEncoded:address.state]];
	}
	if (address.zip.length) {
		[parameters appendFormat:@"&%@=%@", [self urlEncoded:@"card[addressZip]"], [self urlEncoded:address.zip]];
	}
	if (address.country.length) {
		[parameters appendFormat:@"&%@=%@", [self urlEncoded:@"card[addressCountry]"], [self urlEncoded:address.country]];
	}

	url = [NSURL URLWithString:[[url absoluteString] stringByAppendingString:parameters]];
	NSLog(@"url: %@", url);

	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:0];

	[request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request addValue:@"application/json" forHTTPHeaderField:@"Accept"];

	// As GET, add parameters to URL
	request.HTTPMethod = @"GET";

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
    return (__bridge_transfer NSString *) CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef) value, NULL,
                                                                                  (__bridge CFStringRef) @"!*'();:@&=+$,/?%#[]-.", kCFStringEncodingUTF8);
}

@end
