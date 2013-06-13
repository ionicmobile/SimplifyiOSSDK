#import <UIKit/UIKit.h>
#import "SIMCreditCardValidator.h"

@protocol SIMCreditCardEntryViewDelegate
-(void)cardNumberChanged:(NSString*)cardNumber;
-(void)cvcNumberChanged:(NSString*)cvcNumber;
-(void)expirationDateChanged:(NSString*)expirationDate;
-(void)doneButtonTapped;
@end

@interface SIMCreditCardEntryView : UIView
@property (nonatomic, weak) id<SIMCreditCardEntryViewDelegate> delegate;
-(void)setCardNumber:(NSString*)cardNumber isValid:(BOOL)valid isMaximumLength:(BOOL)maximumLength;
-(void)setCardType:(SIMCreditCardType)cardType;
-(void)setCVCCode:(NSString*)cvcCode isValid:(BOOL)valid isMaximumLength:(BOOL)maximumLength;
-(void)setExpirationDate:(NSString*)expiration isValid:(BOOL)valid;
-(void)setButtonEnabled:(BOOL)enabled;
@end
