#import "SIMAddressEntryView.h"
#import "SIMTextField.h"

@interface SIMAddressEntryView ()
@property (nonatomic) UITextField* addressNameTextField;
@property (nonatomic) UITextField* addressLine1TextField;
@property (nonatomic) UITextField* addressLine2TextField;
@property (nonatomic) UITextField* addressCityTextField;
@property (nonatomic) UITextField* addressStateTextField;
@property (nonatomic) UITextField* addressZipTextField;
@end

@implementation SIMAddressEntryView

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		SIMTextField* addressNameTextField = [[SIMTextField alloc] init];
	}
	return self;
}

@end
