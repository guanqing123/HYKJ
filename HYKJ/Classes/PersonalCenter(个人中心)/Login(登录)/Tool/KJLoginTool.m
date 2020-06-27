//
//  KJLoginTool.m
//  HYKJ
//
//  Created by information on 2020/6/27.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJLoginTool.h"
#import "KJHttpTool.h"
#import "MJExtension.h"

@implementation KJLoginTool

+ (void)loginWithAccountAndPassword:(KJLoginParam *)loginParam success:(void (^)(KJLoginResult * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *requestURL = [KJURL stringByAppendingString:@"/login"];
    
    NSDictionary *param = [loginParam mj_keyValues];
    
    [KJHttpTool postJsonWithURL:requestURL params:param success:^(id  _Nonnull json) {
        KJLoginResult *result = [KJLoginResult mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    
}

@end
