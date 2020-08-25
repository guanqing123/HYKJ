//
//  KJZuDanTool.h
//  HYKJ
//
//  Created by information on 2020/8/24.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KJZuDanParam.h"
#import "KJZuDanResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface KJZuDanTool : NSObject

/// 组单列表
/// @param zudanParam 请求参数
/// @param success 成功回调
/// @param failure 失败回调
+ (void)getZuDanList:(KJZuDanParam *)zudanParam success:(void(^)(KJZuDanResult *result))success failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
