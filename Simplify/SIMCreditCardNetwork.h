#import "SIMCreditCardToken.h"
#import "SIMAddress.h"

@interface SIMCreditCardNetwork : NSObject

- (id)initWithPublicApiToken:(NSString *)publicApiToken;

- (SIMCreditCardToken *)createCardTokenWithExpirationMonth:(NSString *)expirationMonth
											expirationYear:(NSString *)expirationYear
												cardNumber:(NSString *)cardNumber
													   cvc:(NSString *)cvc
												   address:(SIMAddress *)address
													 error:(NSError **)error;

@end
