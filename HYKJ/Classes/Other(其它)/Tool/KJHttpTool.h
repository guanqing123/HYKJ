//
//  KJHttpTool.h
//  HYKJ
//
//  Created by information on 2020/6/16.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJHttpTool : NSObject

/**
 发送一个POST请求

 @param url 请求路径
 @param params 请求参数
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

/**
 发送一个POST请求(上传文件数据)

 @param url 请求路径
 @param params 请求参数
 @param formDataArray 文件参数
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

/**
 发送一个GET请求

 @param url 请求路径
 @param params 请求参数
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;


@end

NS_ASSUME_NONNULL_END
