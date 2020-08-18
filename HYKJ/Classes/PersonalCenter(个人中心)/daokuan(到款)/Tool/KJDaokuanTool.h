//
//  KJDaokuanTool.h
//  HYKJ
//
//  Created by information on 2020/8/18.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KJDaokuanParam.h"
#import "KJDaokuanResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface KJDaokuanTool : NSObject

+ (void)getDaokuanList:(KJDaokuanParam *)daokuanParam success:(void(^)(KJDaokuanResult *result))success failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
