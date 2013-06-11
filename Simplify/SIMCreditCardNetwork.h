#import "SIMCardToken.h"

@interface SIMCreditCardNetwork : NSObject

- (SIMCardToken *)createCardTokenWithExpirationMonth:(NSString *)expirationMonth
                                      expirationYear:(NSString *)expirationYear
			                              cardNumber:(NSString *)cardNumber
						                         cvc:(NSString *)cvc
						                       error:(NSError **)error;

@end
