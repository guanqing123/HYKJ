//
//  KJZuDanTool.m
//  HYKJ
//
//  Created by information on 2020/8/24.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJZuDanTool.h"
#import "MJExtension.h"
#import "KJHttpTool.h"

@implementation KJZuDanTool

+ (void)getZuDanList:(KJZuDanParam *)zudanParam success:(void (^)(KJZuDanResult * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *requestURL = [KJURL stringByAppendingString:@"/baseData/zudan"];
    
    NSDictionary *param = [zudanParam mj_keyValues];
    [KJHttpTool postWithURL:requestURL params:param success:^(id  _Nonnull json) {
        KJZuDanResult *result = [KJZuDanResult mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)getZuDanDetail:(NSDictionary *)dict success:(nonnull void (^)(NSArray * _Nonnull))success failure:(nonnull void (^)(NSError * _Nonnull))failure {
    
    NSString *requestURL = [KJURL stringByAppendingString:@"/baseData/zddetail"];
    
    [KJHttpTool postWithURL:requestURL params:dict success:^(id  _Nonnull json) {
        NSArray *details = [KJZuDanDetail mj_objectArrayWithKeyValuesArray:[json objectForKey:@"data"]];
        success(details);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    
}

@end
