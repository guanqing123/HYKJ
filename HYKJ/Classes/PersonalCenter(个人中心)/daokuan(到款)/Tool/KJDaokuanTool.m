//
//  KJDaokuanTool.m
//  HYKJ
//
//  Created by information on 2020/8/18.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJDaokuanTool.h"
#import "MJExtension.h"
#import "KJHttpTool.h"

@implementation KJDaokuanTool

+ (void)getDaokuanList:(KJDaokuanParam *)daokuanParam success:(nonnull void (^)(KJDaokuanResult * _Nonnull))success failure:(nonnull void (^)(NSError * _Nonnull))failure {
    
    NSString *requestURL = [KJURL stringByAppendingString:@"/baseData/daokuan"];
    
    NSDictionary *parameter = [daokuanParam mj_keyValues];
    
    [KJHttpTool postWithURL:requestURL params:parameter success:^(id  _Nonnull json) {
        KJDaokuanResult *result = [KJDaokuanResult mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    
}

@end
