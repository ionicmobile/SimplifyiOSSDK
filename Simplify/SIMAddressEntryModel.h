#import "SIMTextFieldState.h"
#import "SIMCreditCardEntryControl.h"

@interface SIMAddressEntryModel : NSObject
@property (nonatomic, readonly) NSDictionary *stateOptions;

- (SIMTextFieldState *)stateForControl:(SIMCreditCardEntryControl)control withInput:(NSString *)input;

@end
