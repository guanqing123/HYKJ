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

/// 存储登录之后的信息
/// @param loginResult 需要保存的登录信息
+ (void)saveLoginResult:(KJLoginResult *)loginResult;

/**
 返回存储的登录信息

 @return loginResult
 */
+ (NSString *)loginResult;

@end

NS_ASSUME_NONNULL_END
