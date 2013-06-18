#import <UIKit/UIKit.h>

#define CGSizeUnbounded CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)

@interface UIView (Asynchrony)
-(void)centerInBounds:(CGRect)bounds offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY;
-(void)centerHorizonallyAtY:(CGFloat)y inBounds:(CGRect)bounds withSize:(CGSize)size;
-(void)centerHorizonallyAtY:(CGFloat)y inBounds:(CGRect)bounds thatFits:(CGSize)size;
-(void)centerVerticallyAtX:(CGFloat)x inBounds:(CGRect)bounds withSize:(CGSize)size;
-(void)centerVerticallyAtX:(CGFloat)x inBounds:(CGRect)bounds thatFits:(CGSize)size;
-(void)centerVerticallyAtX:(CGFloat)x inBounds:(CGRect)bounds withSize:(CGSize)size offsetY:(CGFloat)offsetY;
-(void)centerVerticallyAtX:(CGFloat)x inBounds:(CGRect)bounds thatFits:(CGSize)size offsetY:(CGFloat)offsetY;

-(void)topRightAlignedAtPointUnbounded:(CGPoint)point;
-(void)rightAlignedAtX:(CGFloat)x centeredVerticallyInBounds:(CGRect)bounds offsetY:(CGFloat)offsetY;

-(void)setFrameAtOrigin:(CGPoint)origin;
-(void)setFrameAtOriginThatFitsUnbounded:(CGPoint)origin;
-(void)setFrameAtOrigin:(CGPoint)origin thatFits:(CGSize)size;
-(void)snapToGrid;

+(UIView*)paddedViewWithView:(UIView*)view andPadding:(CGSize)padding;

- (void)activateNextResponder;

@end