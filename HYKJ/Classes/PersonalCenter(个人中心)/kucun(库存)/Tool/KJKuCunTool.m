//
//  KJKuCunTool.m
//  HYKJ
//
//  Created by information on 2020/8/18.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJKuCunTool.h"
#import "MJExtension.h"
#import "KJHttpTool.h"

@implementation KJKuCunTool

+ (void)getStofcysuccess:(void (^)(NSArray * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *requestURL = [KJURL stringByAppendingString:@"/baseData/cks"];
    
    [KJHttpTool postWithURL:requestURL params:nil success:^(id  _Nonnull json) {
        NSArray *cys = [KJCyResult mj_objectArrayWithKeyValuesArray:[json objectForKey:@"data"]];
        success(cys);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)getKuCunList:(KJKuCunParam *)kucunParam success:(void (^)(KJKuCunResult * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *requestURL = [KJURL stringByAppendingString:@"/baseData/kucun"];
    
    NSDictionary *parameter = [kucunParam mj_keyValues];
    
    [KJHttpTool postWithURL:requestURL params:parameter success:^(id  _Nonnull json) {
        KJKuCunResult *result = [KJKuCunResult mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    
}

@end
