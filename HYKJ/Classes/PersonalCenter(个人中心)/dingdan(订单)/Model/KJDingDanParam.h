//
//  KJDingDanParam.h
//  HYKJ
//
//  Created by information on 2020/8/27.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJDingDanParam : NSObject

// 订单日期
@property (nonatomic, copy) NSString *startDat;
@property (nonatomic, copy) NSString *endDat;

// 统计归属
@property (nonatomic, copy) NSString *tjgs;

// 订单状态
@property (nonatomic, copy) NSString *ordsta;

// 分配状态
@property (nonatomic, copy) NSString *allsta;

//装运状态
@property (nonatomic, copy) NSString *dlvsta;

//发票状态
@property (nonatomic, copy) NSString *invsta;

//订单号
@property (nonatomic, copy) NSString *sohnum;

@end

NS_ASSUME_NONNULL_END
