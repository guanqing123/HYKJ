//
//  KJHYTool.m
//  HYKJ
//
//  Created by information on 2020/6/27.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJHYTool.h"

// controller
#import "KJTabBarController.h"

@implementation KJHYTool

+ (void)chooseRootController {
    
    NSString *key = @"CFBundleVersion";
    
    //取出沙盒中存储的上次使用的软件的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    //获取当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        [[UIApplication sharedApplication] delegate].window.rootViewController = [[KJTabBarController alloc] init];
//        [UIApplication sharedApplication].keyWindow.rootViewController = [[KJTabBarController alloc] init];
    } else { //新版本
         [[UIApplication sharedApplication] delegate].window.rootViewController = [[KJTabBarController alloc] init];
//        [UIApplication sharedApplication].keyWindow.rootViewController = [[KJTabBarController alloc] init];
        //存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
    
}

@end
