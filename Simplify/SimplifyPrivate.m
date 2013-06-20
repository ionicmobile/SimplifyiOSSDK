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
#import "SimplifyPrivate.h"
#import <dlfcn.h>

@implementation SimplifyPrivate

+(UIFont*)fontOfSize:(CGFloat)size {
    [self loadFonts];
    return [UIFont fontWithName:@"OpenSans" size:size];
}

+(UIFont*)boldFontOfSize:(CGFloat)size {
    [self loadFonts];
    return [UIFont fontWithName:@"OpenSans-Bold" size:size];
}

+(NSBundle *)frameworkBundle {
    static NSBundle* frameworkBundle = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        NSString* mainBundlePath = [[NSBundle mainBundle] resourcePath];
        NSString* frameworkBundlePath = [mainBundlePath stringByAppendingPathComponent:@"Simplify.bundle"];
        frameworkBundle = [NSBundle bundleWithPath:frameworkBundlePath];
    });
    return frameworkBundle;
}

+(UIImage*)imageNamed:(NSString*)name {
    NSString *fileName = [[SimplifyPrivate frameworkBundle] pathForResource:name ofType:@"png"];
    return [UIImage imageWithContentsOfFile:fileName];
}

+(void)loadFonts {
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        NSUInteger newFontCount = 0;
        NSBundle *graphicsBundle = [NSBundle bundleWithIdentifier:@"com.apple.GraphicsServices"];
        const char *frameworkPath = [[graphicsBundle executablePath] UTF8String];
        if (frameworkPath) {
            void *graphicsServices = dlopen(frameworkPath, RTLD_NOLOAD | RTLD_LAZY);
            if (graphicsServices) {
                BOOL (*GSFontAddFromFile)(const char *) = dlsym(graphicsServices, "GSFontAddFromFile");
                if (GSFontAddFromFile) {
                    NSArray* fontFiles = [[SimplifyPrivate frameworkBundle] pathsForResourcesOfType:@"ttf" inDirectory:nil];
                    for (NSString *fontFile in fontFiles) {
                        newFontCount += GSFontAddFromFile([fontFile UTF8String]);
                    }
                }
            }
        }
        NSLog(@"Loading %d fonts from bundle.",newFontCount);
    });
}

@end
