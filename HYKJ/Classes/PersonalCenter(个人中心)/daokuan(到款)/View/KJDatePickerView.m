//
//  KJDatePickerView.m
//  HYKJ
//
//  Created by information on 2020/8/16.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJDatePickerView.h"

@interface KJDatePickerView()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)itemClick:(UIButton *)sender;

@end

@implementation KJDatePickerView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
}

+ (instancetype)dateView {
    return [[[NSBundle mainBundle] loadNibNamed:@"KJDatePickerView" owner:nil options:nil] lastObject];
}

- (void)setDate:(NSString *)date {
    // 日期格式化类
    NSDateFormatter *format = [[NSDateFormatter alloc] init];

    // 设置日期格式 为了转换成功
    format.dateFormat = @"yyyy-MM-dd";

    NSDate *initdate = [format dateFromString:date];
    [self.datePicker setDate:initdate];
}

#pragma mark - 日期变化事件
- (void)datePickerValueChanged:(UIDatePicker *)datePicker {
    NSDate *selected = [datePicker date];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    self.selecteDate = [dateFormater stringFromDate:selected];
}

#pragma mark - 取消/确认 选中日期
- (IBAction)itemClick:(UIButton *)button {
    NSDate  *selected = [self.datePicker date];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    self.selecteDate = [dateFormater stringFromDate:selected];
    
    if ([self.delegate respondsToSelector:@selector(didFinishDatePicker:buttonType:)]) {
        [self.delegate didFinishDatePicker:self buttonType:(int)button.tag];
    }
}
@end
