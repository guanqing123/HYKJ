//
//  KJTuiHuoTool.m
//  HYKJ
//
//  Created by information on 2020/8/21.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJTuiHuoTool.h"
#import "MJExtension.h"
#import "KJHttpTool.h"

@implementation KJTuiHuoTool

+ (void)getNodeList:(void (^)(NSArray * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure{
    
    NSString *requestURL = [KJURL stringByAppendingString:@"/baseData/ths"];
    
    [KJHttpTool postWithURL:requestURL params:nil success:^(id  _Nonnull json) {
        NSArray *result = [KJNode mj_objectArrayWithKeyValuesArray:[json objectForKey:@"data"]];
        success(result);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)getTuiHuoList:(KJTuiHuoZDParam *)param success:(void (^)(KJTuiHuoZDResult * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *requestURL = [KJURL stringByAppendingString:@"/baseData/tuihuo"];
    
    NSDictionary *parameter = [param mj_keyValues];
    [KJHttpTool postWithURL:requestURL params:parameter success:^(id  _Nonnull json) {
        KJTuiHuoZDResult *result = [KJTuiHuoZDResult mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)getTuiHuoDetail:(NSDictionary *)dict success:(void (^)(NSArray * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *requestURL = [KJURL stringByAppendingString:@"/baseData/thdetail"];
    
    [KJHttpTool postWithURL:requestURL params:dict success:^(id  _Nonnull json) {
        NSArray *details = [KJTuiHuoMX mj_objectArrayWithKeyValuesArray:[json objectForKey:@"data"]];
        success(details);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    
}

@end
