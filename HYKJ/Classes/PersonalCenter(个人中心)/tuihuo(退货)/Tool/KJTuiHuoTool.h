//
//  KJTuiHuoTool.h
//  HYKJ
//
//  Created by information on 2020/8/21.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KJNode.h"

#import "KJTuiHuoZDParam.h"
#import "KJTuiHuoZDResult.h"

#import "KJTuiHuoMX.h"

NS_ASSUME_NONNULL_BEGIN

@interface KJTuiHuoTool : NSObject

/// 获取退货流程节点
/// @param success 成功回调
/// @param failure 失败回调
+ (void)getNodeList:(void(^)(NSArray *ths))success failure:(void(^)(NSError *error))failure;

/// 获取退货主单列表
/// @param param 请求参数
/// @param success 成功回调
/// @param failure 失败回调
+ (void)getTuiHuoList:(KJTuiHuoZDParam *)param success:(void(^)(KJTuiHuoZDResult *result))success failure:(void(^)(NSError *error))failure;

/// 获取退货详情
/// @param dict 请求参数
/// @param success 成功回调
/// @param failure 失败回调
+ (void)getTuiHuoDetail:(NSDictionary *)dict success:(void(^)(NSArray *details))success failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
