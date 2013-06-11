/*
 * Copyright (c) 2013, MasterCard International Incorporated
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, are
 * permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this list of
 * conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of
 * conditions and the following disclaimer in the documentation and/or other materials
 * provided with the distribution.
 * Neither the name of the MasterCard International Incorporated nor the names of its
 * contributors may be used to endorse or promote products derived from this software
 * without specific prior written permission.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
 * SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
 * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
 * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

#import "SIMLayeredButton.h"
#import <QuartzCore/QuartzCore.h>
#import "SIMGradientView.h"
#import "SIMHighlightView.h"
#import "UIColor+Additions.h"

@interface SIMLayeredButton()

@property (nonatomic, strong) SIMGradientView *mainBackgroundView;
@property (nonatomic, strong) SIMHighlightView *highlightView;

@end

@implementation SIMLayeredButton

- (id)init {
    if (self = [super init]) {
		self.backgroundColor = [UIColor colorWithHexString:@"#B42C10"];
		self.layer.cornerRadius = 10.0;
		
		self.mainBackgroundView = [[SIMGradientView alloc] init];
		self.mainBackgroundView.layer.cornerRadius = self.layer.cornerRadius - 1.0;
		self.mainBackgroundView.backgroundColor = [self fillColor];
		self.mainBackgroundView.userInteractionEnabled = NO;
		self.mainBackgroundView.gradientLayer.colors = @[(id)[UIColor colorWithHexString:@"#DDFF8057"].CGColor,(id)[UIColor colorWithHexString:@"#DDFC411D"].CGColor];
		self.mainBackgroundView.clipsToBounds = YES;
		[self addSubview:self.mainBackgroundView];
		
		self.highlightView = [[SIMHighlightView alloc] init];
		self.highlightView.highlightColor = [UIColor colorWithWhite:1.0 alpha:0.5];
		self.highlightView.cornerRadius = self.mainBackgroundView.layer.cornerRadius;
		[self.mainBackgroundView addSubview:self.highlightView];
    }
    return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	self.mainBackgroundView.frame = CGRectInset(self.bounds, 1.0, 1.0);
	
	CGRect highlightViewFrame = CGRectInset(self.mainBackgroundView.bounds, -1.0, 0.0);
	highlightViewFrame.size = [self.highlightView sizeThatFits:self.bounds.size];
	self.highlightView.frame = highlightViewFrame;
}

- (UIColor *)fillColor {
	UIColor *color = [UIColor colorWithWhite:0.353 alpha:1.0];
	if (self.highlighted) {
		color = [UIColor colorWithRed:1.0 green:0.471 blue:0.0 alpha:1.0];
	} else if (self.selected) {
		color = [UIColor colorWithRed:0.0 green:0.494 blue:1.0 alpha:1.0];
	}
	return color;
}

- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	[self updateFillColor:!self.highlighted];
}

- (void)setSelected:(BOOL)selected {
	[super setSelected:selected];
	[self updateFillColor:NO];
}

- (void)updateFillColor:(BOOL)animated {
	void (^animationBlock)(void) = ^(void) {
		self.mainBackgroundView.backgroundColor = [self fillColor];
    };
	
	if (animated) {
		[UIView animateWithDuration:0.25
							  delay:0.0
							options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
						 animations:animationBlock
						 completion:nil];
	} else {
		animationBlock();
	}
}

@end
