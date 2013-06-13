#import <UIKit/UIKit.h>
#import "SIMTextInputState.h"
#import "SIMCreditCardType.h"

@protocol SIMCreditCardEntryViewDelegate
-(void)creditCardNumberInput:(NSString*)input;
-(void)cvcNumberInput:(NSString*)input;
-(void)expirationDateInput:(NSString*)input;
-(void)sendCreditCardButtonTapped;
@end

@interface SIMCreditCardEntryView : UIView
@property (nonatomic, weak) id<SIMCreditCardEntryViewDelegate> delegate;
-(void)setCardType:(SIMCreditCardType)cardType;
-(void)setCardNumberDisplayedText:(NSString*)displayedText textInputState:(SIMTextInputState)textInputState;
-(void)setCVCNumberDisplayedText:(NSString*)displayedText textInputState:(SIMTextInputState)textInputState;
-(void)setExpirationDateDisplayedText:(NSString*)displayedText textInputState:(SIMTextInputState)textInputState;
-(void)setSendCreditCardButtonEnabled:(BOOL)enabled;
@end
