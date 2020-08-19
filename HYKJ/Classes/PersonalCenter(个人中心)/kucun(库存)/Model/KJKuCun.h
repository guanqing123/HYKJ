//
//  KJKuCun.h
//  HYKJ
//
//  Created by information on 2020/8/18.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJKuCun : NSObject

// 产品代码
@property (nonatomic, copy) NSString *cpdm;

// 产品型号
@property (nonatomic, copy) NSString *cpxh;

// 库存数
@property (nonatomic, copy) NSString *kcs;

// 产品名称
@property (nonatomic, copy) NSString *cpmc;

// 出厂价
@property (nonatomic, copy) NSString *ccj;

// 库存单位
@property (nonatomic, copy) NSString *kcdw;

// 库位名称
@property (nonatomic, copy) NSString *kwmc;

@end

NS_ASSUME_NONNULL_END
