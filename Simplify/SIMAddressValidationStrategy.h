#import "SIMTextFieldState.h"
#import "SIMAddressEntryControl.h"

@protocol SIMAddressValidationStrategy <NSObject>

- (BOOL)validatesControl:(SIMAddressEntryControl)control;

- (SIMTextFieldState *)stateForControl:(SIMAddressEntryControl)control withInput:(NSString *)input;

@end
