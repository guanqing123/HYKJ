//
//  KJHYTool.h
//  HYKJ
//
//  Created by information on 2020/6/27.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJHYTool : NSObject

/// 选择跟控制器
+ (void)chooseRootController;

// 清空token,跳转登录
+ (void)clearTokenGoToLoginVc;

// 获取当前Vc
+ (UIViewController *)getCurrentVC;

// show Alert
+ (void)showAlertVc;

@end

NS_ASSUME_NONNULL_END
