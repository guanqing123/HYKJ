//
//  KJDatePickerView.h
//  HYKJ
//
//  Created by information on 2020/8/16.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KJDatePickerView;

typedef enum {
    DatePickerViewButtonTypeCancel,
    DatePickerViewButtonTypeSure
} DatePickerViewButtonType;

@protocol KJDatePickerViewDelegate <NSObject>
@optional

/**
点击 取消/确认 按钮回调

@param datePickerView 日期控件
@param buttonType 按钮类型
*/
- (void)didFinishDatePicker:(nullable KJDatePickerView *)datePickerView buttonType:(DatePickerViewButtonType)buttonType;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KJDatePickerView : UIView

@property (nonatomic, copy) NSString *selecteDate;

@property (nonatomic, weak) id<KJDatePickerViewDelegate>  delegate;

+ (instancetype)dateView;

- (void)setDate:(NSString *)date;

@end

NS_ASSUME_NONNULL_END
