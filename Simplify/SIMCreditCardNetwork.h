#import "SIMCreditCardToken.h"

@interface SIMCreditCardNetwork : NSObject

- (SIMCreditCardToken *)createCardTokenWithExpirationMonth:(NSString *)expirationMonth
											expirationYear:(NSString *)expirationYear
												cardNumber:(NSString *)cardNumber
													   cvc:(NSString *)cvc
													  name:(NSString *)name
											  addressLine1:(NSString *)addressLine1
											  addressLine2:(NSString *)addressLine2
													  city:(NSString *)city
													 state:(NSString *)state
													   zip:(NSString *)zip
													 error:(NSError **)error;

@end
