#import "SIMCreditCardToken.h"

@interface SIMCreditCardNetwork : NSObject

- (SIMCreditCardToken *)createCardTokenWithExpirationMonth:(NSString *)expirationMonth
                                      expirationYear:(NSString *)expirationYear
			                              cardNumber:(NSString *)cardNumber
						                         cvc:(NSString *)cvc
						                       error:(NSError **)error;

@end
