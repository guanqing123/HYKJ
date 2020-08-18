//
//  KJDataPickerView.h
//  HYKJ
//
//  Created by information on 2020/8/17.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KJDataPickerView;

typedef enum {
    DataPickerViewButtonTypeCancel,
    DataPickerViewButtonTypeSure
} DataPickerViewButtonType;

@protocol KJDataPickerViewDelegate <NSObject>
@optional

/**
点击 取消/确认 按钮回调

@param dataPickerView 选择控件
@param buttonType 按钮类型
*/
- (void)didFinishDataPicker:(nullable KJDataPickerView *)dataPickerView buttonType:(DataPickerViewButtonType)buttonType;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KJDataPickerView : UIView

@property (nonatomic, strong)  NSArray *dataArray;

+ (instancetype)dataView;

@property (nonatomic, copy) NSString *selecteData;

@property (nonatomic, weak) id<KJDataPickerViewDelegate> delegate;

- (void)setData:(NSString *)data;

@end

NS_ASSUME_NONNULL_END
