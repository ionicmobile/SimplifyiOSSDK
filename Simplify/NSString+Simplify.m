#import "NSString+Simplify.h"

@implementation NSString (Simplify)

-(BOOL)hasAnyPrefix:(NSArray*)prefixes {
    for (NSString* prefix in prefixes ) {
        if ( [self hasPrefix:prefix] ) {
            return YES;
        }
    }
    return NO;
}

-(NSString*)stringDividedByString:(NSString*)dividerString beforeIndicies:(NSArray*)indices {
    NSMutableString* newString = [NSMutableString string];
    for ( NSUInteger index = 0; index < self.length; ++index ) {
        unichar character = [self characterAtIndex:index];
        if ( [indices containsObject:@(index)] ) {
            [newString appendString:dividerString];
        }
        [newString appendString:[NSString stringWithCharacters:&character length:1]];
    }
    return newString;
}

-(NSString*)safeSubstringByTrimmingToLength:(NSUInteger)length {
    if ( self.length > length) {
        NSMutableString* mutableSelf = [self mutableCopy];
        return [mutableSelf substringToIndex:length];
    }
    return self;
}

-(NSString*)safeSubstringFromIndex:(NSUInteger)beginIndex toIndex:(NSUInteger)endIndex {
    NSString* substring = [self safeSubstringByTrimmingToLength:endIndex];
    if (  beginIndex < substring.length ) {
        return [substring substringFromIndex:beginIndex];
    }
    return nil;
}

@end
