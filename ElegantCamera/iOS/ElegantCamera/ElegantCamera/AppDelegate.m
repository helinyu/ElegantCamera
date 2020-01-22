//
//  AppDelegate.m
//  ElegantCamera
//
//  Created by Aka on 2019/10/31.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "AppDelegate.h"
#import "ECMainViewController.h"
#import "ECBaseNavViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ECMainViewController * vc = [ECMainViewController new];
    ECBaseNavViewController *nav = [[ECBaseNavViewController alloc] initWithRootViewController:vc];
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
