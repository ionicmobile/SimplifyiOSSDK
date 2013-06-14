#import "SIMAddressEntryModel.h"

@interface SIMAddressEntryModel ()
@property (nonatomic, readwrite) SIMTextRequiredTextFieldModel *nameModel;
@end

@implementation SIMAddressEntryModel

- (id)init {
	if (self = [super init]) {
		self.nameModel = [[SIMTextRequiredTextFieldModel alloc] init];
	}
	return self;
}

@end
