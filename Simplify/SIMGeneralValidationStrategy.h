#import "SIMTextFieldState.h"
#import "SIMAddressEntryControl.h"

@protocol SIMGeneralValidationStrategy <NSObject>

- (SIMTextFieldState *)stateForInput:(NSString *)input;

@end
