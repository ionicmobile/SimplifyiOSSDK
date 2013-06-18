#import "SIMAppDelegate.h"
#import "SIMExampleViewController.h"

@implementation SIMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[SIMExampleViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
