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
@property (nonatomic, copy) NSString *zddh;
// 组单日期
@property (nonatomic, copy) NSString *zdrq;
// 客户名称
@property (nonatomic, copy) NSString *khmc;
// 运单类型
@property (nonatomic, copy) NSString *ydlx;
// 总体积
@property (nonatomic, copy) NSString *ztj;
// 详细地址
@property (nonatomic, copy) NSString *add;
// 总件数
@property (nonatomic, copy) NSString *zjs;
// 快递单号
@property (nonatomic, copy) NSString *kddh;

@end

NS_ASSUME_NONNULL_END
