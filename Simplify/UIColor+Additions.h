#import <UIKit/UIKit.h>

#define SIMColorNormal [UIColor clearColor]
#define SIMColorBad [UIColor colorWithHexString:@"ffcccc"]
#define SIMColorGood [UIColor colorWithHexString:@"ccffcc"]

@interface UIColor (Additions)

+(UIColor*)simplifyBorderColor;

+(UIColor*)colorWithHexString:(NSString *)hexString;

@end
