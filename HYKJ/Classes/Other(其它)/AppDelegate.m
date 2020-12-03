//
//  AppDelegate.m
//  HYKJ
//
//  Created by information on 2020/6/16.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "AppDelegate.h"

// 推送
#import <CloudPushSDK/CloudPushSDK.h>
// iOS 10 notification
#import <UserNotifications/UserNotifications.h>

//检测版本更新
#import "ATAppUpdater.h"

// tool
#import "KJAccountTool.h"
#import "KJLoginResult.h"
#import "KJHYTool.h"
#import "KJLoginTool.h"

// controller
#import "KJNavigationController.h"
#import "KJLoginViewController.h"
#import "KJPushViewController.h"

API_AVAILABLE(ios(10.0))
@interface AppDelegate () <UNUserNotificationCenterDelegate>
{
    // iOS 10通知中心
    UNUserNotificationCenter *_notificationCenter;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[ATAppUpdater sharedUpdater] showUpdateWithConfirmation];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    // 阿里推送
    // APNs注册，获取deviceToken并上报
    [self registerAPNS:application];
    // 初始化SDK
    [self initCloudPush];
    
    // 先判断有无存储账号信息
    NSString *token = [KJAccountTool getToken];
    if (token) {  //之前登录成功
        [KJLoginTool loginWidthToken:token success:^(NSString * _Nonnull newToken) {
            // 1.存储模型数据
            [KJAccountTool replaceToken:newToken];
        } failure:^(NSError * _Nonnull error) {
            [KJHYTool showAlertVc];
        }];
        [KJHYTool chooseRootController];
        
        // push推送绑定账号
        [CloudPushSDK bindAccount:[KJAccountTool getUserCode] withCallback:^(CloudPushCallbackResult *res) {
            if (res.success) {
                NSLog(@"账号%@绑定成功",[KJAccountTool getUserCode]);
            } else {
                NSLog(@"账号绑定error=%@",res.error);
            }
        }];
        
    } else {  //之前没有登录成功
        self.window.rootViewController = [[KJNavigationController alloc] initWithRootViewController:[[KJLoginViewController alloc] init]];
    }
    
    return YES;
}

#pragma mark APNs Register
- (void)registerAPNS:(UIApplication *)application {
    float systemVersionNum = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersionNum >= 10.0) {
        // iOS 10 notifications
        if (@available(iOS 10.0, *)) {
            _notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
        } else {
            // Fallback on earlier versions
        }
        
        // 创建category，并注册到通知中心
        [self createCustomNotificationCategory];
        _notificationCenter.delegate = self;
        // 请求推送权限
        if (@available(iOS 10.0, *)) {
            [_notificationCenter requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    // granted
                    NSLog(@"User authored notification.");
                    // 向APNs注册，获取deviceToken
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [application registerForRemoteNotifications];
                    });
                } else {
                    // not granted
                    NSLog(@"User denied notification.");
                }
            }];
        } else {
            // Fallback on earlier versions
        }
    } else if (systemVersionNum >= 8.0) {
        // iOS 8 Notifications
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored"-Wdeprecated-declarations"
                [application registerUserNotificationSettings:
                 [UIUserNotificationSettings settingsForTypes:
                  (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                   categories:nil]];
                [application registerForRemoteNotifications];
        #pragma clang diagnostic pop
    } else {
        // iOS < 8 Notifications
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored"-Wdeprecated-declarations"
                [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
                 (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
        #pragma clang diagnostic pop
    }
}

/**
 *  创建并注册通知category(iOS 10+)
 */
- (void)createCustomNotificationCategory {
    // 自定义`action1`和`action2`
    if (@available(iOS 10.0, *)) {
        UNNotificationAction *action1 = [UNNotificationAction actionWithIdentifier:@"action1" title:@"test1" options: UNNotificationActionOptionNone];
        UNNotificationAction *action2 = [UNNotificationAction actionWithIdentifier:@"action2" title:@"test2" options: UNNotificationActionOptionNone];
        // 创建id为`test_category`的category，并注册两个action到category
        // UNNotificationCategoryOptionCustomDismissAction表明可以触发通知的dismiss回调
        UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"test_category" actions:@[action1, action2] intentIdentifiers:@[] options:
                                            UNNotificationCategoryOptionCustomDismissAction];
        // 注册category到通知中心
        [_notificationCenter setNotificationCategories:[NSSet setWithObjects:category, nil]];
    } else {
        // Fallback on earlier versions
    }
}

/*
 *  APNs注册成功回调，将返回的deviceToken上传到CloudPush服务器
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"Upload deviceToken to CloudPush server.");
    [CloudPushSDK registerDevice:deviceToken withCallback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            NSLog(@"Register deviceToken success, deviceToken: %@, deviceId: %@", [CloudPushSDK getApnsDeviceToken], [CloudPushSDK getDeviceId]);
        } else {
            NSLog(@"Register deviceToken failed, error: %@", res.error);
        }
    }];
}

/*
 *  APNs注册失败回调
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError %@", error);
}

/**
 *  App处于前台时收到通知(iOS 10+)
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler  API_AVAILABLE(ios(10.0)){
    NSLog(@"Receive a notification in foregound.");
    // 处理iOS 10通知，并上报通知打开回执
    //[self handleiOS10Notification:notification];
    // 通知不弹出
    //completionHandler(UNNotificationPresentationOptionNone);
    
    // 通知弹出，且带有声音、内容和角标
    completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge);
}

/**
 *  处理iOS 10通知(iOS 10+)
 */
- (void)handleiOS10Notification:(UNNotification *)notification  API_AVAILABLE(ios(10.0)){
    UNNotificationRequest *request = notification.request;
    UNNotificationContent *content = request.content;
    NSDictionary *userInfo = content.userInfo;
    // 通知时间
    NSDate *noticeDate = notification.date;
    // 标题
    NSString *title = content.title;
    // 副标题
    NSString *subtitle = content.subtitle;
    // 内容
    NSString *body = content.body;
    // 角标
    int badge = [content.badge intValue];
    // 取得通知自定义字段内容，例：获取key为"Extras"的内容
    NSString *url = [userInfo valueForKey:@"url"];
    if (url) {
        KJPushViewController *pushVc = [[KJPushViewController alloc] initWithDesUrl:url];
        KJNavigationController *pushNav = [[KJNavigationController alloc] initWithRootViewController:pushVc];
        pushNav.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.window.rootViewController presentViewController:pushNav animated:YES completion:nil];
    }
    // 通知角标数清0
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    // 同步角标数到服务端
//     [self syncBadgeNum:0];
    // 通知打开回执上报
    [CloudPushSDK sendNotificationAck:userInfo];
    NSLog(@"Notification, date: %@, title: %@, subtitle: %@, body: %@, badge: %d, extras: %@.", noticeDate, title, subtitle, body, badge, url);
}

/**
 *  触发通知动作时回调，比如点击、删除通知和点击自定义action(iOS 10+)
 */

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    NSString *userAction = response.actionIdentifier;
    // 点击通知打开
    if ([userAction isEqualToString:UNNotificationDefaultActionIdentifier]) {
        NSLog(@"User opened the notification.");
        // 处理iOS 10通知，并上报通知打开回执
        [self handleiOS10Notification:response.notification];
    }
    // 通知dismiss，category创建时传入UNNotificationCategoryOptionCustomDismissAction才可以触发
    if ([userAction isEqualToString:UNNotificationDismissActionIdentifier]) {
        NSLog(@"User dismissed the notification.");
    }
    NSString *customAction1 = @"action1";
    NSString *customAction2 = @"action2";
    // 点击用户自定义Action1
    if ([userAction isEqualToString:customAction1]) {
        NSLog(@"User custom action1.");
    }
    
    // 点击用户自定义Action2
    if ([userAction isEqualToString:customAction2]) {
        NSLog(@"User custom action2.");
    }
    completionHandler();
}

#pragma mark SDK Init
- (void)initCloudPush {
    // 正式上线建议关闭
    [CloudPushSDK turnOnDebug];
    // SDK初始化，手动输出appKey和appSecret
//    [CloudPushSDK asyncInit:testAppKey appSecret:testAppSecret callback:^(CloudPushCallbackResult *res) {
//        if (res.success) {
//            NSLog(@"Push SDK init success, deviceId: %@.", [CloudPushSDK getDeviceId]);
//        } else {
//            NSLog(@"Push SDK init failed, error: %@", res.error);
//        }
//    }];
    
    // SDK初始化，无需输入配置信息
    // 请从控制台下载AliyunEmasServices-Info.plist配置文件，并正确拖入工程
    [CloudPushSDK autoInit:^(CloudPushCallbackResult *res) {
        if (res.success) {
            NSLog(@"Push SDK init success, deviceId: %@.", [CloudPushSDK getDeviceId]);
        } else {
            NSLog(@"Push SDK init failed, error: %@", res.error);
        }
    }];
}

#pragma mark Notification Open
/*
 *  App处于启动状态时，通知打开回调
 */
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo {
    NSLog(@"Receive one notification.");
    // 取得APNS通知内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    // 内容
    NSString *content = [aps valueForKey:@"alert"];
    // badge数量
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue];
    // 播放声音
    NSString *sound = [aps valueForKey:@"sound"];
    // 取得通知自定义字段内容，例：获取key为"Extras"的内容
    NSString *url = [userInfo valueForKey:@"url"]; //服务端中Extras字段，key是自己定义的
    if (url) {
        KJPushViewController *pushVc = [[KJPushViewController alloc] initWithDesUrl:url];
        KJNavigationController *pushNav = [[KJNavigationController alloc] initWithRootViewController:pushVc];
        pushNav.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.window.rootViewController presentViewController:pushNav animated:YES completion:nil];
    }
    NSLog(@"content = [%@], badge = [%ld], sound = [%@], url = [%@]", content, (long)badge, sound, url);
    // iOS badge 清0
    application.applicationIconBadgeNumber = 0;
    // 同步通知角标数到服务端
    // [self syncBadgeNum:0];
    // 通知打开回执上报
    // [CloudPushSDK handleReceiveRemoteNotification:userInfo];(Deprecated from v1.8.1)
    [CloudPushSDK sendNotificationAck:userInfo];
}

@end
