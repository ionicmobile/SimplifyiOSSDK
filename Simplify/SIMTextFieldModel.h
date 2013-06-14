#import <UIKit/UIKit.h>

@protocol SIMTextFieldModelProtocol<NSObject>
- (void)attachToTextField:(UITextField *)textField;
@optional
- (void)textField:(UITextField *)textField input:(NSString *)input;
@end

@interface SIMTextFieldModel : NSObject<SIMTextFieldModelProtocol>
@end
