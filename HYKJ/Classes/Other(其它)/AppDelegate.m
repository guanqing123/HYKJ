//
//  AppDelegate.m
//  HYKJ
//
//  Created by information on 2020/6/16.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "AppDelegate.h"

//检测版本更新
#import "ATAppUpdater.h"

// tool
#import "KJAccountTool.h"
#import "KJLoginResult.h"
#import "KJHYTool.h"

// controller
#import "KJNavigationController.h"
#import "KJLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[ATAppUpdater sharedUpdater] showUpdateWithConfirmation];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    // 先判断有无存储账号信息
    NSString *token = [KJAccountTool loginResult];
    if (token) {  //之前登录成功
        [KJHYTool chooseRootController];
    } else {  //之前没有登录成功
        self.window.rootViewController = [[KJNavigationController alloc] initWithRootViewController:[[KJLoginViewController alloc] init]];
    }
    
    return YES;
}


@end
