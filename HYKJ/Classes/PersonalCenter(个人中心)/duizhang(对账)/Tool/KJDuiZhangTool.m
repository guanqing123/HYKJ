//
//  KJDuiZhangTool.m
//  HYKJ
//
//  Created by information on 2020/8/20.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJDuiZhangTool.h"
#import "MJExtension.h"
#import "KJHttpTool.h"

@implementation KJDuiZhangTool

+ (void)getDuiZhangList:(KJDuiZhangParam *)duizhangParam success:(void (^)(KJDuiZhangResult * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *requestURL = [KJURL stringByAppendingString:@"/baseData/duizhang"];
    
    NSDictionary *parameter = [duizhangParam mj_keyValues];
    
    [KJHttpTool postWithURL:requestURL params:parameter success:^(id  _Nonnull json) {
        KJDuiZhangResult *result = [KJDuiZhangResult mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
