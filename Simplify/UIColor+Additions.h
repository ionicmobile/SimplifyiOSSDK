#import <UIKit/UIKit.h>

@interface UIColor (Additions)

+(UIColor*)simplifyBorderColor;
+(UIColor*)simplifyDarkTextColor;
+(UIColor*)simplifyLightRedColor;
+(UIColor*)simplifyLightGreenColor;
+(UIColor*)simplifyDarkRedColor;
+(UIColor*)simplifyLightOrangeColor;
+(UIColor*)simplifyDarkOrangeColor;
+(UIColor*)simplifyOrangeColor;

+(UIColor*)colorWithHexString:(NSString *)hexString;

@end
