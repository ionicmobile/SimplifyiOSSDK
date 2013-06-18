#import <UIKit/UIKit.h>
#import "SIMTextFieldWithPickerView.h"

// NOTE: we currently assume a US address.
@interface SIMAddressEntryView : UIView
@property (nonatomic, readonly) SIMTextField* nameTextField;
@property (nonatomic, readonly) SIMTextField* line1TextField;
@property (nonatomic, readonly) SIMTextField* line2TextField;
@property (nonatomic, readonly) SIMTextField* cityTextField;
@property (nonatomic, readonly) SIMTextFieldWithPickerView* stateTextField;
@property (nonatomic, readonly) SIMTextField* zipTextField;
@property (nonatomic, readonly) SIMTextField* countryTextField;
@end
