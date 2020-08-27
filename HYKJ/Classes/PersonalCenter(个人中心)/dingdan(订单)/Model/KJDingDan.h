//
//  KJDingDan.h
//  HYKJ
//
//  Created by information on 2020/8/27.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJDingDan : NSObject

// 订单号
@property (nonatomic, copy) NSString *sohnum;

// 产业订单
@property (nonatomic, copy) NSString *zxsohnum;

// 订单日期
@property (nonatomic, copy) NSString *orddat;

// 客户
@property (nonatomic, copy) NSString *bpcord;

// 客户名称
@property (nonatomic, copy) NSString *bpcnam;

// 订单金额
@property (nonatomic, assign) double ordamt;

// 发货金额
@property (nonatomic, assign) double dlvamt;

// 销售地点
@property (nonatomic, copy) NSString *salfcy;

// 地点
@property (nonatomic, copy) NSString *salnam;

// 装运地点
@property (nonatomic, copy) NSString *stofcy;

// 地点
@property (nonatomic, copy) NSString *fcynam;

// 业务员
@property (nonatomic, copy) NSString *ywy;

// 发货模式
@property (nonatomic, copy) NSString *mdl;

// 承运人
@property (nonatomic, copy) NSString *bptnam;

// 订单状态
@property (nonatomic, copy) NSString *ordsta;

// 分配状态
@property (nonatomic, copy) NSString *allsta;

// 装运状态
@property (nonatomic, copy) NSString *dlvsta;

// 发票状态
@property (nonatomic, copy) NSString *invsta;


@end

NS_ASSUME_NONNULL_END
