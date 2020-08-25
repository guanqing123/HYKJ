//
//  KJTuiHuoZD.h
//  HYKJ
//
//  Created by information on 2020/8/21.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJTuiHuoZD : NSObject

// id
@property (nonatomic, copy) NSString *mainId;

// 流水号
@property (nonatomic, copy) NSString *lsh;

// 申请日期
@property (nonatomic, copy) NSString *sqrq;

// 客户名称
@property (nonatomic, copy) NSString *khmc;

// 审批节点
@property (nonatomic, copy) NSString *nodeName;

// 业务员
@property (nonatomic, copy) NSString *ywy;

// 部门
@property (nonatomic, copy) NSString *bm;

// 统计归属
@property (nonatomic, copy) NSString *tjgs;

// 退货理由
@property (nonatomic, copy) NSString *thly;

@end

NS_ASSUME_NONNULL_END
