//
//  KJKuCunSearchView.h
//  HYKJ
//
//  Created by information on 2020/8/18.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KJKuCunSearchView;

@protocol KJKuCunSearchViewDelegate <NSObject>
@optional

/// 点击查询
/// @param kucunSearchView 当前条件view
- (void)kucunSearchView:(KJKuCunSearchView * _Nonnull)kucunSearchView;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KJKuCunSearchView : UIView

@property (nonatomic, copy) NSString *cpdm;
@property (nonatomic, copy) NSString *cpxh;
@property (nonatomic, copy) NSString *cpmc;
@property (nonatomic, copy) NSString *tjgs;
@property (nonatomic, copy) NSString *tjgssm;

+ (instancetype)searchView;

@property (nonatomic, weak) id<KJKuCunSearchViewDelegate> delegate;

- (void)initData;

@end

NS_ASSUME_NONNULL_END
