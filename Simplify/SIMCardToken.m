#import "SIMCardToken.h"

@interface SIMCardToken ()

@property (nonatomic, readwrite) NSString *token;
@property (nonatomic, readwrite) NSString *name;
@property (nonatomic, readwrite) NSString *type;
@property (nonatomic, readwrite) NSString *last4;
@property (nonatomic, readwrite) NSString *addressLine1;
@property (nonatomic, readwrite) NSString *addressLine2;
@property (nonatomic, readwrite) NSString *addressCity;
@property (nonatomic, readwrite) NSString *addressState;
@property (nonatomic, readwrite) NSString *addressZip;
@property (nonatomic, readwrite) NSString *addressCountry;
@property (nonatomic, readwrite) NSNumber *expMonth;
@property (nonatomic, readwrite) NSNumber *expYear;
@property (nonatomic, readwrite) NSDate *dateCreated;

@end

@implementation SIMCardToken

- (id)initWithToken:(NSString *)token
               name:(NSString *)name
	           type:(NSString *)type
		      last4:(NSString *)last4
	   addressLine1:(NSString *)addressLine1
	   addressLine2:(NSString *)addressLine2
		addressCity:(NSString *)addressCity
	   addressState:(NSString *)addressState
		 addressZip:(NSString *)addressZip
	 addressCountry:(NSString *)addressCountry
		   expMonth:(NSNumber *)expMonth
			expYear:(NSNumber *)expYear
		dateCreated:(NSDate *)dateCreated {
	if (self = [super init]) {
		self.token = token;
		self.name = name;
		self.type = type;
		self.last4 = last4;
		self.addressLine1 = addressLine1;
		self.addressLine2 = addressLine2;
		self.addressCity = addressCity;
		self.addressState = addressState;
		self.addressZip = addressZip;
		self.addressCountry = addressCountry;
		self.expMonth = expMonth;
		self.expYear = expYear;
		self.dateCreated = dateCreated;
	}
	return self;
}

+ (SIMCardToken *)cardTokenFromDictionary:(NSDictionary *)dictionary {
	SIMCardToken *cardToken = [[SIMCardToken alloc] init];
	cardToken.token = dictionary[@"id"];
	cardToken.name = dictionary[@"card"][@"name"];
	cardToken.type = dictionary[@"card"][@"type"];
	cardToken.last4 = dictionary[@"card"][@"last4"];
	cardToken.addressLine1 = dictionary[@"card"][@"addressLine1"];
	cardToken.addressLine2 = dictionary[@"card"][@"addressLine2"];
	cardToken.addressCity = dictionary[@"card"][@"addressCity"];
	cardToken.addressState = dictionary[@"card"][@"addressState"];
	cardToken.addressZip = dictionary[@"card"][@"addressZip"];
	cardToken.addressCountry = dictionary[@"card"][@"addressCountry"];
	cardToken.expMonth = dictionary[@"card"][@"expMonth"];
	cardToken.expYear = dictionary[@"card"][@"expYear"];
	NSString *date = [dictionary[@"card"][@"dateCreated"] description];
	cardToken.dateCreated = [[NSDate alloc] initWithTimeIntervalSince1970:[date longLongValue] / 1000];
	return cardToken;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"tokenId:%@\nlast4 digits:%@ expMonth:%@ expYear:%@\ncardType:%@ dateCreated:%@\nAddress\n%@\n%@\n%@\n%@, %@ %@\n%@",
			self.token,
			self.last4, [self.expMonth description], [self.expYear description],
			self.type, [self.dateCreated description],
			self.name ? self.name : @"", self.addressLine1 ? self.addressLine1 : @"", self.addressLine2 ? self.addressLine2 : @"", self.addressCity ? self.addressCity : @"", self.addressState ? self.addressState : @"", self.addressZip ? self.addressZip : @"", self.addressCountry ? self.addressCountry : @""];
}

@end
