#import "SIMTextField.h"

@interface SIMTextField()

@end

@implementation SIMTextField

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
//		UISegmentedControl *tabNavigation = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Previous", @"Next", nil]];
//		tabNavigation.segmentedControlStyle = UISegmentedControlStyleBar;
//		tabNavigation.momentary = YES;
//		[tabNavigation addTarget:self action:@selector(segmentedControlHandler:) forControlEvents:UIControlEventValueChanged];
//		UIBarButtonItem *barSegment = [[UIBarButtonItem alloc] initWithCustomView:tabNavigation];
		UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
		UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignFirstResponder)];

		UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
		toolbar.barStyle = UIBarStyleBlackTranslucent;
		toolbar.items = @[flexButton, doneButton];
		self.inputAccessoryView = toolbar;
	}
	return self;
}

//If we want, we can use this commented code to get "Previous", "Next", "Done" buttons above the keyboard.
- (void)segmentedControlHandler:(id)sender {
	UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
	if ([segmentedControl selectedSegmentIndex] == 0) {
		NSLog(@"Previous");
	} else {
		NSLog(@"Next");
	}
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
