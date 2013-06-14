#import <UIKit/UIKit.h>
#import "SIMTextInputState.h"
#import "SIMTextField.h"

// NOTE: we currently assume a US address.
@interface SIMAddressEntryView : UIView
@property (nonatomic, readonly) SIMTextField* nameTextField;
@property (nonatomic, readonly) SIMTextField* line1TextField;
@property (nonatomic, readonly) SIMTextField* line2TextField;
@property (nonatomic, readonly) SIMTextField* cityTextField;
@property (nonatomic, readonly) SIMTextField* stateTextField;
@property (nonatomic, readonly) SIMTextField* zipTextField;
@property (nonatomic, readonly) SIMTextField* countryTextField;
@end
