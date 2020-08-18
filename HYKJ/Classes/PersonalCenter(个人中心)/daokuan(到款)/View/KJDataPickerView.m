//
//  KJDataPickerView.m
//  HYKJ
//
//  Created by information on 2020/8/17.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJDataPickerView.h"

@interface KJDataPickerView()

@property (weak, nonatomic) IBOutlet UIPickerView *dataPicker;

- (IBAction)itemClick:(UIButton *)sender;


@end

@implementation KJDataPickerView

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (instancetype)dataView {
    return [[[NSBundle mainBundle] loadNibNamed:@"KJDataPickerView" owner:nil options:nil] lastObject];
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    
    [self.dataPicker reloadAllComponents];
}

- (void)setData:(NSString *)data {
    NSInteger index = [_dataArray indexOfObject:data];
    
    [self.dataPicker selectRow:index inComponent:0 animated:YES];
}

#pragma mark - pickerView datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _dataArray.count;
}

#pragma mark - tableView delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_dataArray objectAtIndex:row];
}

- (IBAction)itemClick:(UIButton *)sender {
    NSInteger selectedRow = [_dataPicker selectedRowInComponent:0];
    
    _selecteData = [_dataArray objectAtIndex:selectedRow];
    
    if ([self.delegate respondsToSelector:@selector(didFinishDataPicker:buttonType:)]) {
        [self.delegate didFinishDataPicker:self buttonType:(int)sender.tag];
    }
}
@end
