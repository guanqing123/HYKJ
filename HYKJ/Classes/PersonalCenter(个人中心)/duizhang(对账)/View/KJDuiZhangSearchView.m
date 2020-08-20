//
//  KJDuiZhangSearchView.m
//  HYKJ
//
//  Created by information on 2020/8/20.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJDuiZhangSearchView.h"

#import "KJHYTool.h"

#import "KJDatePickerView.h"
#import "KJDataPickerView.h"
#import "KJCoverView.h"

@interface KJDuiZhangSearchView()<UITableViewDataSource, UITableViewDelegate, KJDatePickerViewDelegate, UITextFieldDelegate, KJDataPickerViewDelegate>

@property (nonatomic, weak) UIButton  *startDatBtn;
@property (nonatomic, weak) UIButton  *endDatBtn;
@property (nonatomic, weak) UIButton  *fcyBtn;
@property (nonatomic, weak) UITextField  *khdmTextField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

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

- (IBAction)reset;
- (IBAction)search;

@end

@implementation KJDuiZhangSearchView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupData];
}

- (void)setupData {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString *trdate = [formatter stringFromDate:[NSDate date]];
    NSString *mix = [NSString stringWithFormat:@"%@-01",trdate];
    _startDat = mix;
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *max = [formatter stringFromDate:[NSDate date]];
    _endDat = max;
    
    _khdm = @"";
    
    _tjgssm = @"全部";
    _tjgs = @"";
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _mcs = [userDefaults objectForKey:cymc];
    _dms = [userDefaults objectForKey:cydm];
    _dmc = [NSDictionary dictionaryWithObjects:_dms forKeys:_mcs];
}

+ (instancetype)searchView {
    return [[[NSBundle mainBundle] loadNibNamed:@"KJDuiZhangSearchView" owner:nil options:nil] lastObject];
}

- (KJCoverView *)coverView {
    if (_coverView == nil) {
        _coverView = [[KJCoverView alloc] initCoverView];
    }
    return _coverView;
}


#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
     __weak typeof(cell) weakCell = cell;
    if (indexPath.row == 0) {
        UILabel *dzLabel = [[UILabel alloc] init];
        dzLabel.text = @"对账日期:";
        dzLabel.textAlignment = NSTextAlignmentRight;
        dzLabel.font = [UIFont systemFontOfSize:13.0f];
        [cell.contentView addSubview:dzLabel];
        [dzLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakCell.contentView).offset(5);
            make.centerY.equalTo(weakCell.contentView);
            make.width.mas_equalTo(weakCell.contentView.mas_width).dividedBy(5).offset(5);
            make.height.mas_equalTo(20);
        }];
        
        UIButton *startDatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        startDatBtn.backgroundColor = RGB(238, 238, 238);
        startDatBtn.tag = 0;
        startDatBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [startDatBtn setTitle:_startDat forState:UIControlStateNormal];
        [startDatBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [startDatBtn addTarget:self action:@selector(startDatBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        startDatBtn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
        [startDatBtn.layer setBorderColor:[RGB(200, 200, 200) CGColor]];
        [startDatBtn.layer setBorderWidth:1.0f];
        [startDatBtn.layer setCornerRadius:5.0f];
        [cell.contentView addSubview:startDatBtn];
        [startDatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(dzLabel.mas_right).offset(15);
            make.centerY.equalTo(weakCell.contentView);
            make.width.mas_equalTo(weakCell.contentView.mas_width).dividedBy(4);
            make.height.mas_equalTo(30);
        }];
        
        UIView *splitLine = [[UIView alloc] init];
        splitLine.backgroundColor = [UIColor blackColor];
        [cell.contentView addSubview:splitLine];
        [splitLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(startDatBtn.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(30, 1));
            make.centerY.equalTo(weakCell.contentView);
        }];
        
        UIButton *endDatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        endDatBtn.backgroundColor = RGB(238, 238, 238);
        endDatBtn.tag = 1;
        endDatBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [endDatBtn setTitle:_endDat forState:UIControlStateNormal];
        [endDatBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [endDatBtn addTarget:self action:@selector(endDatBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        endDatBtn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
        [endDatBtn.layer setBorderColor:[RGB(200, 200, 200) CGColor]];
        [endDatBtn.layer setBorderWidth:1.0f];
        [endDatBtn.layer setCornerRadius:5.0f];
        [cell.contentView addSubview:endDatBtn];
        [endDatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(splitLine.mas_right).offset(10);
            make.centerY.equalTo(weakCell.contentView);
            make.width.mas_equalTo(weakCell.contentView.mas_width).dividedBy(4);
            make.height.mas_equalTo(30);
        }];
        
        UIView *bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor = RGB(238, 238, 238);
        [cell.contentView addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            [[make leading] trailing].equalTo(weakCell.contentView);
            make.bottom.equalTo(weakCell.contentView);
            make.height.mas_equalTo(1);
        }];
    } else if (indexPath.row == 1) {
        UILabel *cyLabel = [[UILabel alloc] init];
        cyLabel.text = @"产业:";
        cyLabel.font = [UIFont systemFontOfSize:13.0f];
        cyLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:cyLabel];
        [cyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakCell.contentView).offset(5);
            make.centerY.equalTo(weakCell.contentView);
            make.width.mas_equalTo(weakCell.contentView.mas_width).dividedBy(5).offset(5);
            make.height.mas_equalTo(20);
        }];
        
        UIButton *fcyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        fcyBtn.backgroundColor = RGB(238, 238, 238);
        fcyBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [fcyBtn setTitle:_tjgssm forState:UIControlStateNormal];
        [fcyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [fcyBtn addTarget:self action:@selector(dataBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        fcyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [fcyBtn.layer setBorderColor:[RGB(200, 200, 200) CGColor]];
        [fcyBtn.layer setBorderWidth:1.0f];
        [fcyBtn.layer setCornerRadius:5.0f];
        [cell.contentView addSubview:fcyBtn];
        [fcyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cyLabel.mas_right).offset(15);
            make.centerY.equalTo(weakCell.contentView);
            make.width.mas_equalTo(weakCell.contentView.mas_width).dividedBy(2);
            make.height.mas_equalTo(30);
        }];
        
        UIView *bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor = RGB(238, 238, 238);
        [cell.contentView addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            [[make leading] trailing].equalTo(weakCell.contentView);
            make.bottom.equalTo(weakCell.contentView);
            make.height.mas_equalTo(1);
        }];
    } else if (indexPath.row == 2) {
        UILabel *khdmLabel = [[UILabel alloc] init];
        khdmLabel.text = @"客户代码:";
        khdmLabel.font = [UIFont systemFontOfSize:13.0f];
        khdmLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:khdmLabel];
        [khdmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakCell.contentView).offset(5);
            make.centerY.equalTo(weakCell.contentView);
            make.width.mas_equalTo(weakCell.contentView.mas_width).dividedBy(5).offset(5);
            make.height.mas_equalTo(20);
        }];
        
        UITextField *khdmTextField = [[UITextField alloc] init];
        khdmTextField.backgroundColor = RGB(238, 238, 238);
        khdmTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        khdmTextField.delegate = self;
        [khdmTextField.layer setBorderColor:[RGB(200, 200, 200) CGColor]];
        [khdmTextField.layer setBorderWidth:1.0f];
        [khdmTextField.layer setCornerRadius:5.0f];
        khdmTextField.returnKeyType = UIReturnKeyDone;
        khdmTextField.text = _khdm;
        _khdmTextField = khdmTextField;
        [cell.contentView addSubview:khdmTextField];
        [khdmTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(khdmLabel.mas_right).offset(15);
            make.centerY.equalTo(weakCell.contentView);
            make.width.mas_equalTo(weakCell.contentView.mas_width).dividedBy(2);
            make.height.mas_equalTo(30);
        }];
        
        UIView *bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor = RGB(238, 238, 238);
        [cell.contentView addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
           [[make leading] trailing].equalTo(weakCell.contentView);
           make.bottom.equalTo(weakCell.contentView);
           make.height.mas_equalTo(1);
        }];
    }
    return cell;
}

#pragma mark - dateBtnClick
- (void)startDatBtnClick:(UIButton *)startDatBtn {
    [self datePicker:(int)startDatBtn.tag date:_startDat];
}

- (void)endDatBtnClick:(UIButton *)endDatBtn {
    [self datePicker:(int)endDatBtn.tag date:_endDat];
}

- (void)datePicker:(int)tag date:(NSString *)date{
    [self.khdmTextField resignFirstResponder];
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
                [self.tableView reloadData];
                [self.coverView destory];
            }
            if (datePickerView.tag == 1) {
                _endDat = datePickerView.selecteDate;
                [self.tableView reloadData];
                [self.coverView destory];
            }
            break;
        default:
            break;
    }
}

#pragma mark - dataBtnClick
- (void)didFinishDataPicker:(KJDataPickerView *)dataPickerView buttonType:(DataPickerViewButtonType)buttonType {
    switch (buttonType) {
        case DataPickerViewButtonTypeCancel:
            [self.coverView destory];
            break;
        case DataPickerViewButtonTypeSure:
            _tjgssm = dataPickerView.selecteData;
            _tjgs = [_dmc objectForKey:_tjgssm];
            [self.tableView reloadData];
            [self.coverView destory];
            break;
        default:
            break;
    }
}

- (void)dataBtnClick:(UIButton *)tjgsBtn {
    [self.khdmTextField resignFirstResponder];
    UIViewController *vc = [KJHYTool getCurrentVC];
    if (_dataPickerView == nil) {
        _dataPickerView = [KJDataPickerView dataView];
        _dataPickerView.delegate = self;
    }
    [_dataPickerView setDataArray:_mcs];
    [_dataPickerView setData:_tjgssm];
    
    [self.coverView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.coverView addSubview:_dataPickerView];
    
    [_dataPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        [[make leading] trailing].equalTo(_coverView);
        [make bottom].equalTo(_coverView);
        [make height].equalTo(@(236));
    }];
    
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

#pragma mark - UITextField
- (void)textFieldDidEndEditing:(UITextField *)textField {
    _khdm = textField.text;
}

#pragma mark - action
- (IBAction)search {
    if ([self.delegate respondsToSelector:@selector(duizhangSearchView:)]) {
        [self.delegate duizhangSearchView:self];
    }
}

- (IBAction)reset {
    [self setupData];
    [self.tableView reloadData];
}
@end
