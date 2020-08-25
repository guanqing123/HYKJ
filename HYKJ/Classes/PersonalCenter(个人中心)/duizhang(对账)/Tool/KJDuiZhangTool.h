//
//  KJDuiZhangTool.h
//  HYKJ
//
//  Created by information on 2020/8/20.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KJDuiZhangParam.h"
#import "KJDuiZhangResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface KJDuiZhangTool : NSObject

/// 获取对账列表
/// @param duizhangParam 参数
/// @param success 成功回调
/// @param failure 失败回调
+ (void)getDuiZhangList:(KJDuiZhangParam *)duizhangParam success:(void(^)(KJDuiZhangResult *result))success failure:(void(^)(NSError * error))failure;

@end

NS_ASSUME_NONNULL_END
