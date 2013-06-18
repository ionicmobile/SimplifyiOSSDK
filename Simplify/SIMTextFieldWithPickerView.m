#import "SIMTextFieldWithPickerView.h"

@interface SIMTextFieldWithPickerView()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic) NSArray *sortedOptionsKeys;
@end

@implementation SIMTextFieldWithPickerView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		UIPickerView *pickerView = [[UIPickerView alloc] init];
		pickerView.dataSource = self;
		pickerView.delegate = self;
		pickerView.showsSelectionIndicator = YES;
		self.inputView = pickerView;
    }
    return self;
}

- (void)setOptions:(NSDictionary *)options {
	_options = options;
	self.sortedOptionsKeys = [options.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

#pragma mark - Private methods

- (NSString *)pickerStringForRow:(NSInteger)row {
	NSString *result = nil;
	if (self.options && row < self.options.count) {
		result = self.sortedOptionsKeys[row];
	}
	return result;
}

#pragma mark - UIPickerViewDataSource methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return self.sortedOptionsKeys.count;
}

#pragma mark - UIPickerViewDelegate methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [self pickerStringForRow:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	NSString *selectedKey = [self pickerStringForRow:row];
	self.text = self.options[selectedKey];
	[pickerView resignFirstResponder];
}

@end
