//
//  KJDuiZhang.h
//  HYKJ
//
//  Created by information on 2020/8/20.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJDuiZhang : NSObject

// 产业
@property (nonatomic, copy) NSString *fcy;

// 开票客户
@property (nonatomic, copy) NSString *kpkh;

// 开票名称
@property (nonatomic, copy) NSString *kpmc;

// 期初余额
@property (nonatomic, copy) NSString *balamt;

// 期间要货金额
@property (nonatomic, copy) NSString *sinamt;

// 期间退货金额
@property (nonatomic, copy) NSString *retamt;

// 期间到款金额
@property (nonatomic, copy) NSString *recamt;

// 期间财务调整
@property (nonatomic, copy) NSString *devamt;

// 余额
@property (nonatomic, copy) NSString *amt;

// 累计未开金税
@property (nonatomic, copy) NSString *ntaxamt;

// 期间已开金税
@property (nonatomic, copy) NSString *taxamt;

// 授信金额
@property (nonatomic, copy) NSString *zwostauz;

// 财务未审核
@property (nonatomic, copy) NSString *cwsh;

@end

NS_ASSUME_NONNULL_END
