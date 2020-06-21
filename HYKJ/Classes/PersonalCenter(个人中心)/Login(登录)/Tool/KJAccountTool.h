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
 返回存储的登录信息

 @return loginResult
 */
+ (KJLoginResult *)loginResult;

@end

NS_ASSUME_NONNULL_END
