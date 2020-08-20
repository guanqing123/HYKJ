//
//  KJDaoKuanSearchView.h
//  HYKJ
//
//  Created by information on 2020/8/14.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KJDaoKuanSearchView;

@protocol KJDaoKuanSearchViewDelegate <NSObject>
@optional

/// 点击查询
/// @param daokuanSearchView 当前条件view
- (void)daokuanSearchView:(KJDaoKuanSearchView * _Nonnull)daokuanSearchView;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KJDaoKuanSearchView : UIView

// 开始日期
@property (nonatomic, copy) NSString *startDat;
// 结束日期
@property (nonatomic, copy) NSString *endDat;
// 到款
@property (nonatomic, copy) NSString *daokuan;
@property (nonatomic, copy) NSString *dk;
// 划至
@property (nonatomic, copy) NSString *huazhi;
@property (nonatomic, copy) NSString *hz;

+ (instancetype)searchView;

@property (nonatomic, weak) id<KJDaoKuanSearchViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
