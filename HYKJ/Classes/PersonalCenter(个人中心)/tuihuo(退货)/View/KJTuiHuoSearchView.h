//
//  KJTuiHuoSearchView.h
//  HYKJ
//
//  Created by information on 2020/8/21.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KJTuiHuoSearchView;

@protocol KJTuiHuoSearchViewDelegate <NSObject>
@optional

/// 点击查询
/// @param tuihuoSearchView 当前条件view
- (void)tuihuoSearchView:(KJTuiHuoSearchView * _Nonnull)tuihuoSearchView;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KJTuiHuoSearchView : UIView

@property (nonatomic, copy) NSString *startDat;
@property (nonatomic, copy) NSString *endDat;

@property (nonatomic, copy) NSString *tjgs;
@property (nonatomic, copy) NSString *tjgssm;

@property (nonatomic, copy) NSString *nodeId;
@property (nonatomic, copy) NSString *nodeName;

+ (instancetype)searchView;

@property (nonatomic, weak) id<KJTuiHuoSearchViewDelegate>  delegate;

- (void)initData;

@end

NS_ASSUME_NONNULL_END
