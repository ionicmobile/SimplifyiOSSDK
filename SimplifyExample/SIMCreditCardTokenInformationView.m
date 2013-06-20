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

#import "SIMCreditCardTokenInformationView.h"
#import "UIColor+Additions.h"

@implementation SIMCreditCardTokenInformationView

- (id)initWithFrame:(CGRect)frame creditCardToken:(SIMCreditCardToken *)creditCardToken {
	if (self = [super initWithFrame:frame]) {
		CGFloat yOffset = 0.0;
		UILabel *titleLabel = [self createLabelWithSize:26.0f text:@"Token Information" yOffset:yOffset];
		[self addSubview:titleLabel];
		yOffset = CGRectGetMaxY(titleLabel.frame) + 6.0;

		UILabel *tokenLabel = [self createLabelWithSize:14.0f text:[NSString stringWithFormat:@"Token: %@", creditCardToken.token] yOffset:yOffset];
		[self addSubview:tokenLabel];
		yOffset = CGRectGetMaxY(tokenLabel.frame) + 6.0;

		UILabel *idLabel = [self createLabelWithSize:14.0f text:[NSString stringWithFormat:@"Id: %@", creditCardToken.id] yOffset:yOffset];
		[self addSubview:idLabel];
		yOffset = CGRectGetMaxY(idLabel.frame) + 6.0;

		UILabel *typeAndLast4Label = [self createLabelWithSize:14.0f text:[NSString stringWithFormat:@"Type: %@\t\tLast4: %@", creditCardToken.type, creditCardToken.last4] yOffset:yOffset];
		[self addSubview:typeAndLast4Label];
		yOffset = CGRectGetMaxY(typeAndLast4Label.frame) + 6.0;

		if (creditCardToken.name.length) {
			UILabel *nameLabel = [self createLabelWithSize:14.0f text:[NSString stringWithFormat:@"%@", creditCardToken.name] yOffset:yOffset];
			[self addSubview:nameLabel];
			yOffset = CGRectGetMaxY(nameLabel.frame) + 2.0;
		}

		if (creditCardToken.addressLine1.length) {
			UILabel *addressLine1Label = [self createLabelWithSize:14.0f text:creditCardToken.addressLine1 yOffset:yOffset];
			[self addSubview:addressLine1Label];
			yOffset = CGRectGetMaxY(addressLine1Label.frame) + 2.0;
		}
		if (creditCardToken.addressLine2.length) {
			UILabel *addressLine2Label = [self createLabelWithSize:14.0f text:creditCardToken.addressLine2 yOffset:yOffset];
			[self addSubview:addressLine2Label];
			yOffset = CGRectGetMaxY(addressLine2Label.frame) + 2.0;
		}
		if (creditCardToken.addressCity.length && creditCardToken.addressState.length && creditCardToken.addressZip.length) {
			NSString *text = [NSString stringWithFormat:@"%@, %@ %@",creditCardToken.addressCity, creditCardToken.addressState, creditCardToken.addressZip];
			UILabel *cityStateZipLabel = [self createLabelWithSize:14.0f text:text yOffset:yOffset];
			[self addSubview:cityStateZipLabel];
		}
	}
	return self;
}

- (UILabel *)createLabelWithSize:(CGFloat)size text:(NSString *)text yOffset:(CGFloat)yOffset {
	UILabel* label = [[UILabel alloc] init];
	label.font = [UIFont boldSystemFontOfSize:size];
	label.text = text;
	label.textColor = [UIColor simplifyDarkTextColor];
	label.backgroundColor = UIColor.clearColor;
	[label sizeToFit];
	label.frame = CGRectMake(0, yOffset, CGRectGetWidth(self.frame), CGRectGetHeight(label.frame));
	return label;
}

@end
