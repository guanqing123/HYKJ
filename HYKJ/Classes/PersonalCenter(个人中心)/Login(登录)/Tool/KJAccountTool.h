//
//  KJAccountTool.h
//  HYKJ
//
//  Created by information on 2020/6/17.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class KJLoginResult;

@interface KJAccountTool : NSObject

/**
 保存登录结果信息
 
 */
+ (void)saveLoginResult:(KJLoginResult *)loginResult;

/**
 延长token有效期
 
 */
+ (void)replaceToken:(NSString *)newToken;

/**
 返回存储的登录信息

 @return loginResult
 */
+ (NSString *)getToken;

/**
 userCode

 */
+ (NSString *)getUserCode;

/**
 fullName
 
 */
+ (NSString *)getFullName;

@end

NS_ASSUME_NONNULL_END
