//
//  KJPasswordLoginView.h
//  HYKJ
//
//  Created by information on 2020/6/21.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
// model
#import "KJLoginParam.h"
@class KJPasswordLoginView;

@protocol KJPasswordLoginViewDelegate <NSObject>
@optional

/// 点击登录按钮进行登录
/// @param loginView 当前登录节目
- (void)passwordLoginViewDidLogin:(nonnull KJPasswordLoginView *)loginView;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KJPasswordLoginView : UIView

/// 登录参数
@property (nonatomic, strong)  KJLoginParam *loginParam;

@property (nonatomic, weak) id<KJPasswordLoginViewDelegate> delegate;

+ (instancetype)passwordView;

@end

NS_ASSUME_NONNULL_END
