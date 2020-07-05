//
//  SPSettingTopView.h
//  HYSmartPlus
//
//  Created by information on 2018/5/12.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SettingTopViewButtonTypeWx,
    SettingTopViewButtonTypeSdg
}SettingTopViewButtonType;

@class SPSettingTopView;

@protocol SPSettingTopViewDelegate <NSObject>

/**
 点击 topView 的按钮

 @param topView topView
 @param buttonType 按钮类别
 */
- (void)topView:(SPSettingTopView *)topView buttonType:(SettingTopViewButtonType)buttonType;

@end

@interface SPSettingTopView : UIView

@property (nonatomic, copy) dispatch_block_t headerViewBlock;

@property (nonatomic, weak) id<SPSettingTopViewDelegate>  delegate;

+ (instancetype)topView;

- (void)setData;

@end
