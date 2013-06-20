/* Copyright (c) 2013, Asynchrony Solutions, Inc.
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are met:
 *
 *    * Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *
 *    * Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *
 *    * Neither the name of Asynchrony Solutions, Inc. nor the
 *      names of its contributors may be used to endorse or promote products
 *      derived from this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 *  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 *  DISCLAIMED. IN NO EVENT SHALL ASYNCHRONY SOLUTIONS, INC. BE LIABLE FOR ANY
 *  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 *  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 *  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

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
