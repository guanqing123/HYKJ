//
//  KJKuCunTool.h
//  HYKJ
//
//  Created by information on 2020/8/18.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KJKuCunParam.h"
#import "KJKuCunResult.h"

#import "KJCyResult.h"
#import "KJKuCunResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface KJKuCunTool : NSObject

/// 获取仓库列表
/// @param success 成功回调
/// @param failure 失败回调
+ (void)getStofcysuccess:(void(^)(NSArray *cks))success failure:(void(^)(NSError *error))failure;

/// 库存查询
/// @param kucunParam 请求参数
/// @param success 成功回调
/// @param failure 失败回调
+ (void)getKuCunList:(KJKuCunParam *)kucunParam success:(void(^)(KJKuCunResult *result))success failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
