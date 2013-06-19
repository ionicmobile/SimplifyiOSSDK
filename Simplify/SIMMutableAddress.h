#import "SIMAddress.h"

@interface SIMMutableAddress : SIMAddress

@property (nonatomic, readwrite) NSString *name;
@property (nonatomic, readwrite) NSString *addressLine1;
@property (nonatomic, readwrite) NSString *addressLine2;
@property (nonatomic, readwrite) NSString *city;
@property (nonatomic, readwrite) NSString *state;
@property (nonatomic, readwrite) NSString *zip;

@end
