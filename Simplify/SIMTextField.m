
#import "SIMTextField.h"

@implementation SIMTextField

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignFirstResponder)];
		UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
		toolbar.items = @[barButton];
		self.inputAccessoryView = toolbar;
	}
	return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + self.textOffset.width, bounds.origin.y +  self.textOffset.height,
					  bounds.size.width - self.textOffset.width*2, bounds.size.height -  self.textOffset.height*2);
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + self.textOffset.width, bounds.origin.y +  self.textOffset.height,
					  bounds.size.width - self.textOffset.width*2, bounds.size.height -  self.textOffset.height);
}

@end
