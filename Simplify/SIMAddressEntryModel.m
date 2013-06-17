#import "SIMAddressEntryModel.h"

@interface SIMAddressEntryModel ()
@property (nonatomic, readwrite) SIMTextRequiredTextFieldModel *nameModel;
@property (nonatomic, readwrite) SIMStateTextFieldModel *stateModel;
@end

@implementation SIMAddressEntryModel

- (id)init {
	if (self = [super init]) {
		self.nameModel = [[SIMTextRequiredTextFieldModel alloc] init];
		self.stateModel = [[SIMStateTextFieldModel alloc] init];
	}
	return self;
}

@end
