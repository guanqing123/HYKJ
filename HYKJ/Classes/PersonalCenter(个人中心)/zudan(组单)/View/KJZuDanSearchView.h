//
//  KJZuDanSearchView.h
//  HYKJ
//
//  Created by information on 2020/8/24.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KJZuDanSearchView;

@protocol KJZuDanSearchViewDelegate <NSObject>
@optional

/// 点击搜索
/// @param searchView 条件view
- (void)zudanSearchViewDidSearch:(KJZuDanSearchView * _Nonnull)searchView;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KJZuDanSearchView : UIView

@property (nonatomic, copy) NSString *startDat;
@property (nonatomic, copy) NSString *endDat;

@property (nonatomic, copy) NSString *zddh;

@property (nonatomic, copy) NSString *hd;
@property (nonatomic, copy) NSString *huidan;

@property (nonatomic, copy) NSString *yd;
@property (nonatomic, copy) NSString *yundan;

@property (nonatomic, copy) NSString *ps;
@property (nonatomic, copy) NSString *peisong;

+ (instancetype)searchView;

@property (nonatomic, weak) id<KJZuDanSearchViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
