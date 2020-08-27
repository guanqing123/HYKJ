//
//  KJDingDanSearchView.h
//  HYKJ
//
//  Created by information on 2020/8/27.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KJDingDanSearchView;

@protocol KJDingDanSearchViewDelegate <NSObject>
@optional

/// 点击搜索
/// @param searchView 条件view
- (void)dingdanSearchViewDidSearch:(KJDingDanSearchView * _Nonnull)searchView;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KJDingDanSearchView : UIView

// 订单日期
@property (nonatomic, copy) NSString *startDat;
@property (nonatomic, copy) NSString *endDat;

// 统计归属
@property (nonatomic, copy) NSString *tjgs;
@property (nonatomic, copy) NSString *tjgssm;

// 订单状态
@property (nonatomic, copy) NSString *ordsta;
@property (nonatomic, copy) NSString *ordstasm;

// 分配状态
@property (nonatomic, copy) NSString *allsta;
@property (nonatomic, copy) NSString *allstasm;

//装运状态
@property (nonatomic, copy) NSString *dlvsta;
@property (nonatomic, copy) NSString *dlvstasm;

//发票状态
@property (nonatomic, copy) NSString *invsta;
@property (nonatomic, copy) NSString *invstasm;

//信用状态
@property (nonatomic, copy) NSString *cdtsta;
@property (nonatomic, copy) NSString *cdtstasm;

//订单号
@property (nonatomic, copy) NSString *sohnum;

+ (instancetype)searchView;

@property (nonatomic, weak) id<KJDingDanSearchViewDelegate>  delegate;

@end

NS_ASSUME_NONNULL_END
