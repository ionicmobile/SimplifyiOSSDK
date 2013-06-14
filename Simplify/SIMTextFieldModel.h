@protocol SIMModelDrivenTextFieldProtocol;
#import "UIColor+Additions.h"

#define SIMTextColorNormal [UIColor clearColor]
#define SIMTextColorBad [UIColor colorWithHexString:@"ffcccc"]
#define SIMTextColorGood [UIColor colorWithHexString:@"ccffcc"]

@protocol SIMTextFieldModelProtocol<NSObject>
@optional
- (void)textField:(id<SIMModelDrivenTextFieldProtocol>)textField input:(NSString *)input;
@end

@interface SIMTextFieldModel : NSObject<SIMTextFieldModelProtocol>
@end
