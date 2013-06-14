#import <UIKit/UIKit.h>
#import "SIMTextInputState.h"
#import "SIMModelDrivenTextField.h"

// NOTE: we currently assume a US address.
@interface SIMAddressEntryView : UIView
@property (nonatomic, readonly) SIMModelDrivenTextField* nameTextField;
@property (nonatomic, readonly) SIMModelDrivenTextField* line1TextField;
@property (nonatomic, readonly) SIMModelDrivenTextField* line2TextField;
@property (nonatomic, readonly) SIMModelDrivenTextField* cityTextField;
@property (nonatomic, readonly) SIMModelDrivenTextField* stateTextField;
@property (nonatomic, readonly) SIMModelDrivenTextField* zipTextField;
@property (nonatomic, readonly) SIMModelDrivenTextField* countryTextField;
@end
