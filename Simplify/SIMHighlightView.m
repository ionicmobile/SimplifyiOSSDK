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

#import "SIMHighlightView.h"
#import "SIMShapeView.h"

@interface SIMHighlightView()

@property (nonatomic, strong) SIMShapeView *rightCornerHighlightView;
@property (nonatomic, strong) SIMShapeView *leftCornerHighlightView;
@property (nonatomic, strong) UIView *highlightView;
@property (nonatomic) CGFloat previousCornerRadius;

@end

@implementation SIMHighlightView

+ (id)topHighlight {
	return [[self alloc] init];
}

+ (id)bottomHighlight {
	SIMHighlightView *highlightView = [[self alloc] init];
	highlightView.highlightOrientation = SIMHighlightViewOrientationBottom;
	return highlightView;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		self.rightCornerHighlightView = [[SIMShapeView alloc] init];
		self.rightCornerHighlightView.shapeLayer.lineWidth = 1.0;
		self.rightCornerHighlightView.shapeLayer.fillColor = [UIColor clearColor].CGColor;
		[self addSubview:self.rightCornerHighlightView];
		
		self.leftCornerHighlightView = [[SIMShapeView alloc] init];
		self.leftCornerHighlightView.shapeLayer.lineWidth = 1.0;
		self.leftCornerHighlightView.shapeLayer.fillColor = [UIColor clearColor].CGColor;
		[self addSubview:self.leftCornerHighlightView];
		
		self.highlightView = [[UIView alloc] init];
		[self addSubview:self.highlightView];
		
		self.highlightColor = [UIColor colorWithWhite:1.0 alpha:0.15];
		self.cornerRadius = 5.0;
    }
    return self;
}

- (void)setHighlightColor:(UIColor *)highlightColor {
	if (highlightColor != _highlightColor) {
		_highlightColor = highlightColor;
		self.highlightView.backgroundColor = highlightColor;
		self.leftCornerHighlightView.shapeLayer.strokeColor = highlightColor.CGColor;
		self.rightCornerHighlightView.shapeLayer.strokeColor = highlightColor.CGColor;
	}
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
	if (cornerRadius != _cornerRadius) {
		_cornerRadius = cornerRadius;
		self.layer.cornerRadius = cornerRadius;
	}
}

- (void)setHighlightOrientation:(SIMHighlightViewOrientation)highlightOrientation {
	self.transform = highlightOrientation == SIMHighlightViewOrientationBottom ? CGAffineTransformMakeScale(1.0, -1.0) : CGAffineTransformIdentity;
}

- (void)layoutSubviews {
	CGFloat cornerRadius = self.layer.cornerRadius;
	CGRect highlightFrame = CGRectMake(0.0, 0.0, cornerRadius + 1.0, cornerRadius + 1.0);
	
	if (self.previousCornerRadius != cornerRadius) {
		UIBezierPath *leftHighlightPath = [UIBezierPath bezierPath];
		[leftHighlightPath addArcWithCenter:CGPointMake(cornerRadius + 0.5, cornerRadius + 0.5) radius:cornerRadius startAngle:M_PI endAngle:3 * M_PI_2 clockwise:YES];
		[leftHighlightPath addLineToPoint:CGPointMake(cornerRadius + 1.0, 0.5)];
		self.leftCornerHighlightView.shapeLayer.path = leftHighlightPath.CGPath;
		
		UIBezierPath *rightHighlightPath = [UIBezierPath bezierPath];
		[rightHighlightPath addArcWithCenter:CGPointMake(0.5, cornerRadius + 0.5) radius:cornerRadius startAngle:0 endAngle:3 * M_PI_2 clockwise:NO];
		[rightHighlightPath addLineToPoint:CGPointMake(0.0, 0.5)];
		self.rightCornerHighlightView.shapeLayer.path = rightHighlightPath.CGPath;
		
		self.previousCornerRadius = self.layer.cornerRadius;
	}
	
	self.leftCornerHighlightView.frame = highlightFrame;
	self.rightCornerHighlightView.frame = CGRectOffset(highlightFrame, CGRectGetWidth(self.layer.bounds) - CGRectGetMaxX(self.leftCornerHighlightView.frame), 0.0);
	self.highlightView.frame = CGRectMake(CGRectGetMaxX(self.leftCornerHighlightView.frame), 0.0, CGRectGetMinX(self.rightCornerHighlightView.frame) - CGRectGetMaxX(self.leftCornerHighlightView.frame), 1.0);
}

- (CGSize)sizeThatFits:(CGSize)size {
	size.height = self.cornerRadius + 1.0;
	size.width = MAX(size.width, 2.0 * (self.cornerRadius + 1.0));
	return size;
}

@end
