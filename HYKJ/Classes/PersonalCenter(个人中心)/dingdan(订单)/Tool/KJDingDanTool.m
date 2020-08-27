//
//  KJDingDanTool.m
//  HYKJ
//
//  Created by information on 2020/8/27.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJDingDanTool.h"
#import "MJExtension.h"
#import "KJHttpTool.h"

@implementation KJDingDanTool

+ (void)getDingDanList:(KJDingDanParam *)dingdanParam success:(void (^)(KJDingDanResult * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *requestURL = [KJURL stringByAppendingString:@"/baseData/dingdan"];
    
    NSDictionary *parameter = [dingdanParam mj_keyValues];
    [KJHttpTool postWithURL:requestURL params:parameter success:^(id  _Nonnull json) {
        KJDingDanResult *result = [KJDingDanResult mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
