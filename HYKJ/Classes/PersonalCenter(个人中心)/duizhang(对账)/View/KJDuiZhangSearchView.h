//
//  KJDuiZhangSearchView.h
//  HYKJ
//
//  Created by information on 2020/8/20.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KJDuiZhangSearchView;

@protocol KJDuiZhangSearchViewDelegate <NSObject>
@optional

/// 点击查询
/// @param duizhangSearchView 当前条件view
- (void)duizhangSearchView:(KJDuiZhangSearchView * _Nonnull)duizhangSearchView;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KJDuiZhangSearchView : UIView

@property (nonatomic, copy) NSString *startDat;
@property (nonatomic, copy) NSString *endDat;

@property (nonatomic, copy) NSString *tjgs;
@property (nonatomic, copy) NSString *tjgssm;

@property (nonatomic, copy) NSString *khdm;

+ (instancetype)searchView;

@property (nonatomic, weak) id<KJDuiZhangSearchViewDelegate>  delegate;

- (void)setupData;

@end

NS_ASSUME_NONNULL_END
