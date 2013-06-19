#import <UIKit/UIKit.h>
#import "SIMTextFieldWithPickerView.h"
#import "SIMAddressEntryControl.h"
#import "SIMTextFieldState.h"

@protocol SIMAddressEntryViewDelegate

- (void)control:(SIMAddressEntryControl)control setInput:(NSString *)input;

@end

// NOTE: we currently assume a US address.
@interface SIMAddressEntryView : UIView

@property (nonatomic, weak) id<SIMAddressEntryViewDelegate> delegate;

- (void)setStateOptions:(NSDictionary *)stateOptions;
- (void)setTextFieldState:(SIMTextFieldState *)textFieldState forControl:(SIMAddressEntryControl)control;

@end
