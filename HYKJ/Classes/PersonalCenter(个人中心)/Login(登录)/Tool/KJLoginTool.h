//
//  KJLoginTool.h
//  HYKJ
//
//  Created by information on 2020/6/27.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KJLoginParam.h"
#import "KJLoginResult.h"
#import "KJCyResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface KJLoginTool : NSObject

/// 用户登录
/// @param loginParam 登录参数
/// @param success 成功回调
/// @param failure 失败回调
+ (void)loginWithAccountAndPassword:(KJLoginParam *)loginParam success:(void(^)(KJLoginResult *loginResult))success failure:(void(^)(NSError *error))failure;


/// token 换 token
/// @param token 老token
/// @param success 成功回调
/// @param failure 失败回调
+ (void)loginWidthToken:(NSString *)token success:(void(^)(NSString *newToken))success failure:(void(^)(NSError *error))failure;


/// 获取产业列表
/// @param success 成功回调
/// @param failure 失败回调
+ (void)getCysuccess:(void(^)(NSArray *cys))success failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
