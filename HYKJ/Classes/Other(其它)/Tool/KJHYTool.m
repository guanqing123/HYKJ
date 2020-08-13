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
#import "KJLoginViewController.h"

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

+ (void)clearTokenGoToLoginVc {
    //清空沙盒中的token
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:token];
    [defaults removeObjectForKey:userCode];
    [defaults removeObjectForKey:fullName];
    [defaults removeObjectForKey:phone];
    [defaults synchronize];
    
    //跳转登录页
    [[UIApplication sharedApplication] delegate].window.rootViewController = [[KJLoginViewController alloc] init];
}

+ (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows)
        {
            if (tempWindow.windowLevel == UIWindowLevelNormal)
            {
                window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}

+ (void)showAlertVc {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提醒" message:@"token无效,请重新登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [KJHYTool clearTokenGoToLoginVc];
    }];
    [alertVc addAction:sureAction];
    [[KJHYTool getCurrentVC] presentViewController:alertVc animated:YES completion:nil];
}

@end
