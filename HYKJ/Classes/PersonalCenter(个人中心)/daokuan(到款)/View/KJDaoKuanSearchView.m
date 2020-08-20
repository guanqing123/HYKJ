//
//  KJDaoKuanSearchView.m
//  HYKJ
//
//  Created by information on 2020/8/14.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJDaoKuanSearchView.h"
// tool
#import "KJHYTool.h"
// dateView
#import "KJDatePickerView.h"
// dataView
#import "KJDataPickerView.h"
#import "KJCoverView.h"

@interface KJDaoKuanSearchView()<KJDatePickerViewDelegate, KJDataPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *startDatBtn;
@property (weak, nonatomic) IBOutlet UIButton *endDatBtn;
@property (weak, nonatomic) IBOutlet UIButton *daokuanBtn;
@property (weak, nonatomic) IBOutlet UIButton *huazhiBtn;


// action
- (IBAction)startDatClick:(UIButton *)sender;
- (IBAction)endDatClick:(UIButton *)sender;
- (IBAction)daokuanClick:(UIButton *)sender;
- (IBAction)huazhiClick:(UIButton *)sender;

- (IBAction)reset;
- (IBAction)search;

// date view
@property (nonatomic, strong)  KJDatePickerView *datePickerView;
// data view
@property (nonatomic, strong)  KJDataPickerView *dataPickerView;

@property (nonatomic, strong)  KJCoverView *coverView;

// 产业代码
@property (nonatomic, strong)  NSArray *dms;
// 产业名称
@property (nonatomic, strong)  NSArray *mcs;
// 产业dict
@property (nonatomic, strong)  NSDictionary *dmc;

@end

@implementation KJDaoKuanSearchView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // init data
    [self setupData];
}

- (void)setupData {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString *trdate = [formatter stringFromDate:[NSDate date]];
    NSString *mix = [NSString stringWithFormat:@"%@-01",trdate];
    _startDat = mix;
    [self.startDatBtn setTitle:_startDat forState:UIControlStateNormal];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *max = [formatter stringFromDate:[NSDate date]];
    _endDat = max;
    [self.endDatBtn setTitle:_endDat forState:UIControlStateNormal];
    
    _daokuan = @"全部";
    _dk = @"";
    [self.daokuanBtn setTitle:_daokuan forState:UIControlStateNormal];
    
    _huazhi  = @"全部";
    _hz = @"";
    [self.huazhiBtn setTitle:_huazhi forState:UIControlStateNormal];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _mcs = [userDefaults objectForKey:cymc];
    _dms = [userDefaults objectForKey:cydm];
    _dmc = [NSDictionary dictionaryWithObjects:_dms forKeys:_mcs];
}

+ (instancetype)searchView {
    return [[[NSBundle mainBundle] loadNibNamed:@"KJDaoKuanSearchView" owner:nil options:nil] lastObject];
}

- (KJCoverView *)coverView {
    if (_coverView == nil) {
        _coverView = [[KJCoverView alloc] initCoverView];
    }
    return _coverView;
}

// 查询
- (IBAction)search {
    if ([self.delegate respondsToSelector:@selector(daokuanSearchView:)]) {
        [self.delegate daokuanSearchView:self];
    }
}

- (IBAction)reset {
    [self setupData];
}

- (IBAction)huazhiClick:(UIButton *)huazhiBtn {
    [self dataPicker:(int)huazhiBtn.tag data:_huazhi];
}

// 到款地点
- (IBAction)daokuanClick:(UIButton *)daokuanBtn {
    [self dataPicker:(int)daokuanBtn.tag data:_daokuan];
}

- (void)dataPicker:(int)tag data:(NSString *)data {
    UIViewController *vc = [KJHYTool getCurrentVC];
    
    if (_dataPickerView == nil) {
        _dataPickerView = [KJDataPickerView dataView];
        _dataPickerView.delegate = self;
    }
    [_dataPickerView setDataArray:_mcs];
    [_dataPickerView setData:data];
    
    [self.coverView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.coverView addSubview:_dataPickerView];
    
    [_dataPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        [[make leading] trailing].equalTo(_coverView);
        [make bottom].equalTo(_coverView);
        [make height].equalTo(@(236));
    }];
    _dataPickerView.tag = tag;
    
    [vc.view addSubview:self.coverView];
    [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        [[make trailing] leading].equalTo([vc view]);

        MASViewAttribute *top = [vc mas_topLayoutGuideBottom];
        MASViewAttribute *bottom = [vc mas_bottomLayoutGuideTop];

        #ifdef __IPHONE_11_0    // 如果有这个宏，说明Xcode版本是9开始
            if (@available(iOS 11.0, *)) {
                top = [[vc view] mas_safeAreaLayoutGuideTop];
                bottom = [[vc view] mas_safeAreaLayoutGuideBottom];
            }
        #endif
        
        [make top].equalTo(top);
        [make bottom].equalTo(bottom);
    }];
}

- (void)didFinishDataPicker:(KJDataPickerView *)dataPickerView buttonType:(DataPickerViewButtonType)buttonType {
    switch (buttonType) {
        case DataPickerViewButtonTypeCancel:
            [self.coverView destory];
            break;
        case DataPickerViewButtonTypeSure:
            if (dataPickerView.tag == 0) {
                _daokuan = dataPickerView.selecteData;
                _dk = [_dmc objectForKey:_daokuan];
                [self.daokuanBtn setTitle:dataPickerView.selecteData forState:UIControlStateNormal];
                [self.coverView destory];
            }
            if (dataPickerView.tag == 1) {
                _huazhi = dataPickerView.selecteData;
                _hz = [_dmc objectForKey:_huazhi];
                [self.huazhiBtn setTitle:dataPickerView.selecteData forState:UIControlStateNormal];
                [self.coverView destory];
            }
            break;
        default:
            break;
    }
}

// 结束日期
- (IBAction)endDatClick:(UIButton *)endDatBtn {
    [self datePicker:(int)endDatBtn.tag date:_endDat];
}

// 开始日期
- (IBAction)startDatClick:(UIButton *)startDatBtn {
    [self datePicker:(int)startDatBtn.tag date:_startDat];
}

- (void)datePicker:(int)tag date:(NSString *)date{
    UIViewController *vc = [KJHYTool getCurrentVC];
    
    if (_datePickerView == nil) {
        _datePickerView = [KJDatePickerView dateView];
        _datePickerView.delegate = self;
    }
    
    [self.coverView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.coverView addSubview:_datePickerView];
    
    [_datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        [[make leading] trailing].equalTo(_coverView);
        [make bottom].equalTo(_coverView);
        [make height].equalTo(@(236));
    }];
    _datePickerView.tag = tag;
    [_datePickerView setDate:date];
    
    [vc.view addSubview:self.coverView];
    [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        [[make trailing] leading].equalTo([vc view]);

        MASViewAttribute *top = [vc mas_topLayoutGuideBottom];
        MASViewAttribute *bottom = [vc mas_bottomLayoutGuideTop];

        #ifdef __IPHONE_11_0    // 如果有这个宏，说明Xcode版本是9开始
            if (@available(iOS 11.0, *)) {
                top = [[vc view] mas_safeAreaLayoutGuideTop];
                bottom = [[vc view] mas_safeAreaLayoutGuideBottom];
            }
        #endif
        
        [make top].equalTo(top);
        [make bottom].equalTo(bottom);
    }];
}

- (void)didFinishDatePicker:(KJDatePickerView *)datePickerView buttonType:(DatePickerViewButtonType)buttonType {
    switch (buttonType) {
        case DatePickerViewButtonTypeCancel:
            [self.coverView destory];
            break;
        case DatePickerViewButtonTypeSure:
            if (datePickerView.tag == 0) {
                _startDat = datePickerView.selecteDate;
                [self.startDatBtn setTitle:datePickerView.selecteDate forState:UIControlStateNormal];
                [self.coverView destory];
            }
            if (datePickerView.tag == 1) {
                _endDat = datePickerView.selecteDate;
                [self.endDatBtn setTitle:datePickerView.selecteDate forState:UIControlStateNormal];
                [self.coverView destory];
            }
            break;
        default:
            break;
    }
}

@end
