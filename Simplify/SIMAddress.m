#import "SIMAddress.h"

@interface SIMAddress()

@property (nonatomic, readwrite) NSString *name;
@property (nonatomic, readwrite) NSString *addressLine1;
@property (nonatomic, readwrite) NSString *addressLine2;
@property (nonatomic, readwrite) NSString *city;
@property (nonatomic, readwrite) NSString *state;
@property (nonatomic, readwrite) NSString *zip;
@property (nonatomic, readwrite) NSString *country;

@end

@implementation SIMAddress

- (id)initWithName:(NSString *)name
	  addressLine1:(NSString *)addressLine1
	  addressLine2:(NSString *)addressLine2
			  city:(NSString *)city
			 state:(NSString *)state
			   zip:(NSString *)zip {
	if (self = [super init]) {
		self.name = name;
		self.addressLine1 = addressLine1;
		self.addressLine2 = addressLine2;
		self.city = city;
		self.state = state;
		self.zip = zip;
		self.country = @"USA";
	}
	return self;
}

@end
