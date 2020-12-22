//
//  AppDelegate.m
//  EncryptDemo
//
//  Created by Oila on 2020/12/13.
//  Copyright © 2020 Oila. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    ViewController *loginVC = [[ViewController alloc]init];
    UINavigationController *mainNC = [[UINavigationController alloc]initWithRootViewController:loginVC];
    UIWindow *mainWin = [UIApplication sharedApplication].delegate.window;
    mainWin.rootViewController = mainNC;
    
    return YES;
}



@end
