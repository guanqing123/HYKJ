//
//  KJZuDan.h
//  HYKJ
//
//  Created by information on 2020/8/24.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJZuDan : NSObject

// 组单单号
@property (nonatomic, copy) NSString *zspnum;
// 组单日期
@property (nonatomic, copy) NSString *zspdat;
// 运单类型
@property (nonatomic, copy) NSString *zspdtyp;
// 总件数
@property (nonatomic, copy) NSString *zspqty;
// 总体积
@property (nonatomic, copy) NSString *zspvol;
// 承运人
@property (nonatomic, copy) NSString *bptnam;
// 客户承担
@property (nonatomic, copy) NSString *zkhcd;
// 交接单状态
@property (nonatomic, copy) NSString *zspzdpflag;
// 调度员状态
@property (nonatomic, copy) NSString *zddysta;
// 回单状态
@property (nonatomic, copy) NSString *zhdsta;
// 配送类型
@property (nonatomic, copy) NSString *zsppstyp;
// 客户
@property (nonatomic, copy) NSString *bpcnam;
// 客户地址
@property (nonatomic, copy) NSString *zaddress;
// 快递单号
@property (nonatomic, copy) NSString *zkddh;

@end

NS_ASSUME_NONNULL_END
