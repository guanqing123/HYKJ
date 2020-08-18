//
//  KJHttpTool.m
//  HYKJ
//
//  Created by information on 2020/6/16.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJHttpTool.h"
#import "AFNetworking.h"
#import "KJHYTool.h"

@implementation KJHttpTool

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    // 0.token
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tokenStr = [defaults objectForKey:token];
    if (tokenStr == nil) {
        tokenStr = @"";
    }
    NSDictionary *headers = @{@"Authorization" : tokenStr};
    
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.发送请求
    [mgr POST:url parameters:params headers:headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        //通讯协议状态码
        NSInteger statusCode = response.statusCode;
        
        if (statusCode == 401) {
            [KJHYTool showAlertVc];
        }
        
        failure(error);
    }];
}

+ (void)postJsonWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    // 0.token
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tokenStr = [defaults objectForKey:token];
    if (tokenStr == nil) {
        tokenStr = @"";
    }
    NSDictionary *headers = @{@"Authorization" : tokenStr};
    
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.设置请求格式
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    [mgr.requestSerializer requestWithMethod:@"POST" URLString:url parameters:params error:nil];
    [mgr POST:url parameters:params headers:headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        //通讯协议状态码
        NSInteger statusCode = response.statusCode;
        
        if (statusCode == 401) {
            [KJHYTool showAlertVc];
        }
        
        failure(error);
    }];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    // 1.初始化 请求
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        int i = 0;
        for (UIImage *image in formDataArray) {
            i++;
            NSData *data = UIImageJPEGRepresentation(image, 0.1);
            NSString *fileName = [NSString stringWithFormat:@"fileName_%d.jpg",i];
            [formData appendPartWithFileData:data name:@"files" fileName:fileName mimeType:@"image/jpeg"];
        }
    } error:nil];
    
    // 2.创建 请求 管理对象
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failure(error);
        }else{
            success(responseObject);
        }
    }];
    // 3.释放资源(我猜的)
    [uploadTask resume];
}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.发送请求
    [mgr GET:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
