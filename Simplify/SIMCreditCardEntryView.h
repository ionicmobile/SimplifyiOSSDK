#import <UIKit/UIKit.h>
#import "SIMTextInputState.h"
#import "SIMCreditCardType.h"
#import "SIMAddressEntryView.h"
#import "SIMCreditCardEntryControl.h"
#import "SIMTextFieldState.h"

@protocol SIMCreditCardEntryViewDelegate
- (void)control:(SIMCreditCardEntryControl)control setInput:(NSString *)input;
- (void)sendCreditCardButtonTapped;
@end

@interface SIMCreditCardEntryView : UIView
@property (nonatomic, weak) id<SIMCreditCardEntryViewDelegate> delegate;
- (id)initWithAddressEntryView:(SIMAddressEntryView*)addressEntryView;

- (void)setTextFieldState:(SIMTextFieldState *)textFieldState forControl:(SIMCreditCardEntryControl)control;

- (void)setCardType:(SIMCreditCardType)cardType;
- (void)setSendCreditCardButtonEnabled:(BOOL)enabled;
@end
