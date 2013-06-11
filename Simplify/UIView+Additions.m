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

#import "UIView+Additions.h"

@implementation UIView (Asynchrony)

-(void)centerInBounds:(CGRect)bounds offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY {
    CGSize sz = [self sizeThatFits:CGSizeMake(bounds.size.width - 2 * offsetX, bounds.size.height - offsetY)];
    self.frame = CGRectMake(offsetX + (bounds.size.width-sz.width)/2, offsetY, sz.width - 2 * offsetX, sz.height);
}

-(void)centerHorizonallyAtY:(CGFloat)y inBounds:(CGRect)bounds withSize:(CGSize)size {
    self.frame = CGRectMake(roundf((bounds.size.width-size.width)/2), y, size.width, size.height);
}

-(void)centerHorizonallyAtY:(CGFloat)y inBounds:(CGRect)bounds thatFits:(CGSize)size {
    [self centerHorizonallyAtY:y inBounds:bounds withSize:[self sizeThatFits:size]];
}

-(void)centerVerticallyAtX:(CGFloat)x inBounds:(CGRect)bounds withSize:(CGSize)size {
    [self centerVerticallyAtX:x inBounds:bounds withSize:size offsetY:0];
}

-(void)centerVerticallyAtX:(CGFloat)x inBounds:(CGRect)bounds thatFits:(CGSize)size {
    [self centerVerticallyAtX:x inBounds:bounds withSize:[self sizeThatFits:size] offsetY:0];
}

-(void)centerVerticallyAtX:(CGFloat)x inBounds:(CGRect)bounds withSize:(CGSize)size offsetY:(CGFloat)offsetY {
    self.frame = CGRectMake(x, roundf((bounds.size.height-size.height)/2) + offsetY, size.width, size.height);
}

-(void)centerVerticallyAtX:(CGFloat)x inBounds:(CGRect)bounds thatFits:(CGSize)size offsetY:(CGFloat)offsetY {
    [self centerVerticallyAtX:x inBounds:bounds withSize:[self sizeThatFits:size] offsetY:offsetY];
}

-(void)topRightAlignedAtPointUnbounded:(CGPoint)point {
    CGSize sz = [self sizeThatFits:CGSizeUnbounded];
    self.frame = CGRectMake(point.x - sz.width, point.y, sz.width, sz.height);
}

-(void)rightAlignedAtX:(CGFloat)x centeredVerticallyInBounds:(CGRect)bounds offsetY:(CGFloat)offsetY {
    CGSize sz = [self sizeThatFits:CGSizeUnbounded];
    CGFloat y = offsetY + ((bounds.size.height - sz.height)/2);
    self.frame = CGRectMake(x - sz.width, y, sz.width, sz.height);
}

-(void)setFrameAtOrigin:(CGPoint)origin {
    self.frame = CGRectMake(origin.x, origin.y, self.frame.size.width, self.frame.size.height);
}

-(void)setFrameAtOriginThatFitsUnbounded:(CGPoint)origin {
    [self setFrameAtOrigin:origin thatFits:CGSizeUnbounded];
}

-(void)setFrameAtOrigin:(CGPoint)origin thatFits:(CGSize)size {
    CGSize fitSize = [self sizeThatFits:size];
    self.frame = CGRectMake(origin.x, origin.y, fitSize.width, fitSize.height);
}

-(void)snapToGrid {
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat x = roundf(self.frame.origin.x * scale) / scale;
    CGFloat y = roundf(self.frame.origin.y * scale) / scale;
    CGFloat width = roundf(self.frame.size.width * scale) / scale;
    CGFloat height = roundf(self.frame.size.height * scale) / scale;
    self.frame = CGRectMake(x, y, width, height);
}

+(UIView*)paddedViewWithView:(UIView*)view andPadding:(CGSize)padding {
    CGSize viewSize = [view sizeThatFits:CGSizeUnbounded];
    UIView* containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewSize.width + padding.width * 2, viewSize.height + padding.height * 2)];
    [containerView addSubview:view];
    view.frame = CGRectMake(padding.width, padding.height, viewSize.width, viewSize.height);
    return containerView;
}


@end