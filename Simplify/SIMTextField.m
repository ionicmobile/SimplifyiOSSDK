
#import "SIMTextField.h"

@implementation SIMTextField

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + self.textOffset.width, bounds.origin.y +  self.textOffset.height, bounds.size.width - self.textOffset.width*2, bounds.size.height -  self.textOffset.height*2);
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + self.textOffset.width, bounds.origin.y +  self.textOffset.height, bounds.size.width - self.textOffset.width*2, bounds.size.height -  self.textOffset.height);
}

@end
