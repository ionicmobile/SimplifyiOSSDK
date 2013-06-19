#import "SIMGeneralValidationStrategy.h"

@interface SIMSpecificValuesValidationStrategy : NSObject<SIMGeneralValidationStrategy>

- (id)initWithValidValues:(NSArray *)validValues;

@end
