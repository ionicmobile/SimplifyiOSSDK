#import "SIMTextFieldState.h"
#import "SIMAddressEntryControl.h"
#import "SIMAddress.h"

@interface SIMAddressEntryModel : NSObject

@property (nonatomic, readonly) NSDictionary *stateOptions;

- (SIMTextFieldState *)stateForControl:(SIMAddressEntryControl)control withInput:(NSString *)input;

- (SIMAddress *)createAddressFromInput;

@end
