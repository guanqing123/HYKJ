//
//  KJDingDanTool.h
//  HYKJ
//
//  Created by information on 2020/8/27.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KJDingDanParam.h"
#import "KJDingDanResult.h"

#import "KJDingDanDetail.h"

NS_ASSUME_NONNULL_BEGIN

@interface KJDingDanTool : NSObject

/// 获取订单列表
/// @param dingdanParam 请求参数
/// @param success 成功回调
/// @param failure 失败回调
+ (void)getDingDanList:(KJDingDanParam *)dingdanParam success:(void(^)(KJDingDanResult *result))success failure:(void(^)(NSError *error))failure;


/// 获取订单详情
/// @param detailParam 请求参数
/// @param success 成功回调
/// @param failure 失败回调
+ (void)getDingDanDetail:(NSDictionary *)detailParam success:(void(^)(NSArray *details))success failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
