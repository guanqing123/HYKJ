//
//  KJDingDanSearchView.m
//  HYKJ
//
//  Created by information on 2020/8/27.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJDingDanSearchView.h"

#import "KJHYTool.h"

#import "KJDatePickerView.h"
#import "KJDataPickerView.h"
#import "KJCoverView.h"


@interface KJDingDanSearchView()<UITableViewDataSource, UITableViewDelegate, KJDatePickerViewDelegate,KJDataPickerViewDelegate>

// date view
@property (nonatomic, strong)  KJDatePickerView *datePickerView;
// data view
@property (nonatomic, strong)  KJDataPickerView *dataPickerView;

@property (nonatomic, strong)  KJCoverView *coverView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, weak) UITextField  *sohnumTextField;

// 订单状态
@property (nonatomic, strong)  NSArray *ordstaArray;
@property (nonatomic, strong)  NSDictionary *ordstaDict;

// 分配状态
@property (nonatomic, strong)  NSArray *allstaArray;
@property (nonatomic, strong)  NSDictionary *allstaDict;

// 装运状态
@property (nonatomic, strong)  NSArray *dlvstaArray;
@property (nonatomic, strong)  NSDictionary *dlvstaDict;

// 开票状态
@property (nonatomic, strong)  NSArray *invstaArray;
@property (nonatomic, strong)  NSDictionary *invstaDict;

// 产业代码
@property (nonatomic, strong)  NSArray *dms;
// 产业名称
@property (nonatomic, strong)  NSArray *mcs;
// 产业dict
@property (nonatomic, strong)  NSDictionary *dmc;

- (IBAction)reset;
- (IBAction)search;


@end


@implementation KJDingDanSearchView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupData];
}

+ (instancetype)searchView {
    return [[[NSBundle mainBundle] loadNibNamed:@"KJDingDanSearchView" owner:nil options:nil] lastObject];
}

- (KJCoverView *)coverView {
    if (_coverView == nil) {
        _coverView = [[KJCoverView alloc] initCoverView];
    }
    return _coverView;
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
    
    _tjgssm = @"全部";
    _tjgs = @"";
    
    // 统计归属
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _mcs = [userDefaults objectForKey:cymc];
    _dms = [userDefaults objectForKey:cydm];
    _dmc = [NSDictionary dictionaryWithObjects:_dms forKeys:_mcs];
    
    // 订单状态
    _ordstaArray = [NSArray arrayWithObjects:@"全部", @"未关闭", @"关闭", nil];
    NSArray *ordstaArray = [NSArray arrayWithObjects:@"", @"1", @"2", nil];
    _ordstaDict = [NSDictionary dictionaryWithObjects:ordstaArray forKeys:_ordstaArray];
    _ordsta = @"";
    _ordstasm = @"全部";
    
    // 分配状态
    _allstaArray = [NSArray arrayWithObjects:@"全部", @"未分配", @"部分分配", @"已分配", nil];
    NSArray *allstaArray = [NSArray arrayWithObjects:@"", @"1", @"2", @"3", nil];
    _allstaDict = [NSDictionary dictionaryWithObjects:allstaArray forKeys:_allstaArray];
    _allsta = @"";
    _allstasm = @"全部";
    
    // 装运状态
    _dlvstaArray = [NSArray arrayWithObjects:@"全部", @"未发货", @"部分发货", @"已发货", nil];
    NSArray *dlvstaArray = [NSArray arrayWithObjects:@"", @"1", @"2", @"3", nil];
    _dlvstaDict = [NSDictionary dictionaryWithObjects:dlvstaArray forKeys:_dlvstaArray];
    _dlvsta = @"";
    _dlvstasm = @"全部";
    
    // 开票状态
    _invstaArray = [NSArray arrayWithObjects:@"全部", @"未开票", @"部分开票", @"已开票", nil];
    NSArray *invstaArray = [NSArray arrayWithObjects:@"", @"1", @"2", @"3", nil];
    _invstaDict = [NSDictionary dictionaryWithObjects:invstaArray forKeys:_invstaArray];
    _invsta = @"";
    _invstasm = @"全部";
    
    // 订单号
    _sohnum = @"";
    [self.tableView reloadData];
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     __weak typeof(cell) weakCell = cell;
    if (indexPath.row == 0) {
        UILabel *dzLabel = [[UILabel alloc] init];
        dzLabel.text = @"订单日期:";
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
        UILabel *hdLabel = [[UILabel alloc] init];
        hdLabel.text = @"统计归属:";
        hdLabel.font = [UIFont systemFontOfSize:13.0f];
        hdLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:hdLabel];
        [hdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakCell.contentView).offset(5);
            make.centerY.equalTo(weakCell.contentView);
            make.width.mas_equalTo(weakCell.contentView.mas_width).dividedBy(5).offset(5);
            make.height.mas_equalTo(20);
        }];
        
        UIButton *hdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        hdBtn.tag = 0;
        hdBtn.backgroundColor = RGB(238, 238, 238);
        hdBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [hdBtn setTitle:_tjgssm forState:UIControlStateNormal];
        [hdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [hdBtn addTarget:self action:@selector(tjgsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        hdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [hdBtn.layer setBorderColor:[RGB(200, 200, 200) CGColor]];
        [hdBtn.layer setBorderWidth:1.0f];
        [hdBtn.layer setCornerRadius:5.0f];
        [cell.contentView addSubview:hdBtn];
        [hdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hdLabel.mas_right).offset(15);
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
        UILabel *ordstaLabel = [[UILabel alloc] init];
        ordstaLabel.text = @"订单状态:";
        ordstaLabel.font = [UIFont systemFontOfSize:13.0f];
        ordstaLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:ordstaLabel];
        [ordstaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakCell.contentView).offset(5);
            make.centerY.equalTo(weakCell.contentView);
            make.width.mas_equalTo(weakCell.contentView.mas_width).dividedBy(5).offset(5);
            make.height.mas_equalTo(20);
        }];
        
        UIButton *ordstaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        ordstaBtn.tag = 1;
        ordstaBtn.backgroundColor = RGB(238, 238, 238);
        ordstaBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [ordstaBtn setTitle:_ordstasm forState:UIControlStateNormal];
        [ordstaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [ordstaBtn addTarget:self action:@selector(ordstaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        ordstaBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [ordstaBtn.layer setBorderColor:[RGB(200, 200, 200) CGColor]];
        [ordstaBtn.layer setBorderWidth:1.0f];
        [ordstaBtn.layer setCornerRadius:5.0f];
        [cell.contentView addSubview:ordstaBtn];
        [ordstaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ordstaLabel.mas_right).offset(15);
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
    } else if (indexPath.row == 3) {
        UILabel *allstaLabel = [[UILabel alloc] init];
        allstaLabel.text = @"分配状态:";
        allstaLabel.font = [UIFont systemFontOfSize:13.0f];
        allstaLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:allstaLabel];
        [allstaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakCell.contentView).offset(5);
            make.centerY.equalTo(weakCell.contentView);
            make.width.mas_equalTo(weakCell.contentView.mas_width).dividedBy(5).offset(5);
            make.height.mas_equalTo(20);
        }];
        
        UIButton *allstaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        allstaBtn.tag = 2;
        allstaBtn.backgroundColor = RGB(238, 238, 238);
        allstaBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [allstaBtn setTitle:_allstasm forState:UIControlStateNormal];
        [allstaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [allstaBtn addTarget:self action:@selector(allstaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        allstaBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [allstaBtn.layer setBorderColor:[RGB(200, 200, 200) CGColor]];
        [allstaBtn.layer setBorderWidth:1.0f];
        [allstaBtn.layer setCornerRadius:5.0f];
        [cell.contentView addSubview:allstaBtn];
        [allstaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(allstaLabel.mas_right).offset(15);
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
    } else if (indexPath.row == 4) {
        UILabel *dlvstaLabel = [[UILabel alloc] init];
        dlvstaLabel.text = @"装运状态:";
        dlvstaLabel.font = [UIFont systemFontOfSize:13.0f];
        dlvstaLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:dlvstaLabel];
        [dlvstaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakCell.contentView).offset(5);
            make.centerY.equalTo(weakCell.contentView);
            make.width.mas_equalTo(weakCell.contentView.mas_width).dividedBy(5).offset(5);
            make.height.mas_equalTo(20);
        }];
               
        UIButton *dlvstaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        dlvstaBtn.tag = 3;
        dlvstaBtn.backgroundColor = RGB(238, 238, 238);
        dlvstaBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [dlvstaBtn setTitle:_dlvstasm forState:UIControlStateNormal];
        [dlvstaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [dlvstaBtn addTarget:self action:@selector(dlvstaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        dlvstaBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [dlvstaBtn.layer setBorderColor:[RGB(200, 200, 200) CGColor]];
        [dlvstaBtn.layer setBorderWidth:1.0f];
        [dlvstaBtn.layer setCornerRadius:5.0f];
        [cell.contentView addSubview:dlvstaBtn];
        [dlvstaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(dlvstaLabel.mas_right).offset(15);
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
    }else if (indexPath.row == 5) {
        UILabel *invstaLabel = [[UILabel alloc] init];
        invstaLabel.text = @"发票状态:";
        invstaLabel.font = [UIFont systemFontOfSize:13.0f];
        invstaLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:invstaLabel];
        [invstaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakCell.contentView).offset(5);
            make.centerY.equalTo(weakCell.contentView);
            make.width.mas_equalTo(weakCell.contentView.mas_width).dividedBy(5).offset(5);
            make.height.mas_equalTo(20);
        }];
               
        UIButton *invstaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        invstaBtn.tag = 4;
        invstaBtn.backgroundColor = RGB(238, 238, 238);
        invstaBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [invstaBtn setTitle:_invstasm forState:UIControlStateNormal];
        [invstaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [invstaBtn addTarget:self action:@selector(invstaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        invstaBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [invstaBtn.layer setBorderColor:[RGB(200, 200, 200) CGColor]];
        [invstaBtn.layer setBorderWidth:1.0f];
        [invstaBtn.layer setCornerRadius:5.0f];
        [cell.contentView addSubview:invstaBtn];
        [invstaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(invstaLabel.mas_right).offset(15);
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
    }else if (indexPath.row == 6) {
        UILabel *sohnumLabel = [[UILabel alloc] init];
        sohnumLabel.text = @"订单号:";
        sohnumLabel.font = [UIFont systemFontOfSize:13.0f];
        sohnumLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:sohnumLabel];
        [sohnumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakCell.contentView).offset(5);
            make.centerY.equalTo(weakCell.contentView);
            make.width.mas_equalTo(weakCell.contentView.mas_width).dividedBy(5).offset(5);
            make.height.mas_equalTo(20);
        }];
        
        UITextField *sohnumTextField = [[UITextField alloc] init];
        sohnumTextField.font = [UIFont systemFontOfSize:13.0f];
        sohnumTextField.backgroundColor = RGB(238, 238, 238);
        sohnumTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [sohnumTextField addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
        [sohnumTextField.layer setBorderColor:[RGB(200, 200, 200) CGColor]];
        [sohnumTextField.layer setBorderWidth:1.0f];
        [sohnumTextField.layer setCornerRadius:5.0f];
        sohnumTextField.returnKeyType = UIReturnKeyDone;
        sohnumTextField.text = _sohnum;
        _sohnumTextField = sohnumTextField;
        [cell.contentView addSubview:sohnumTextField];
        [sohnumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(sohnumLabel.mas_right).offset(15);
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
    [self.sohnumTextField resignFirstResponder];
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

#pragma mark - UITextField
- (void)valueChange:(UITextField *)textField {
    _sohnum = textField.text;
}

#pragma mark - dataBtnClick
- (void)didFinishDataPicker:(KJDataPickerView *)dataPickerView buttonType:(DataPickerViewButtonType)buttonType {
    switch (buttonType) {
        case DataPickerViewButtonTypeCancel:
            [self.coverView destory];
            break;
        case DataPickerViewButtonTypeSure:
            if (dataPickerView.tag == 0) {
                _tjgssm = dataPickerView.selecteData;
                _tjgs = [_dmc objectForKey:_tjgssm];
            }
            if (dataPickerView.tag == 1) {
                _ordstasm = dataPickerView.selecteData;
                _ordsta = [_ordstaDict objectForKey:_ordstasm];
            }
            if (dataPickerView.tag == 2) {
                _allstasm = dataPickerView.selecteData;
                _allsta = [_allstaDict objectForKey:_allstasm];
            }
            if (dataPickerView.tag == 3) {
                _dlvstasm = dataPickerView.selecteData;
                _dlvsta = [_dlvstaDict objectForKey:_dlvstasm];
            }
            [self.tableView reloadData];
            [self.coverView destory];
            break;
        default:
            break;
    }
}

- (void)tjgsBtnClick:(UIButton *)button {
    [self dataBtnClick:(int)button.tag value:self.tjgssm data:self.mcs];
}

- (void)ordstaBtnClick:(UIButton *)button {
    [self dataBtnClick:(int)button.tag value:self.ordstasm data:self.ordstaArray];
}

- (void)allstaBtnClick:(UIButton *)button {
    [self dataBtnClick:(int)button.tag value:self.allstasm data:self.allstaArray];
}

- (void)dlvstaBtnClick:(UIButton *)button {
    [self dataBtnClick:(int)button.tag value:self.dlvstasm data:self.dlvstaArray];
}

- (void)invstaBtnClick:(UIButton *)button {
    [self dataBtnClick:(int)button.tag value:self.invstasm data:self.invstaArray];
}

- (void)dataBtnClick:(int)tag value:(NSString *)value data:(NSArray *)data{
    [self.sohnumTextField resignFirstResponder];
    UIViewController *vc = [KJHYTool getCurrentVC];
    if (_dataPickerView == nil) {
        _dataPickerView = [KJDataPickerView dataView];
        _dataPickerView.delegate = self;
    }
    _dataPickerView.tag = tag;
    [_dataPickerView setDataArray:data];
    [_dataPickerView setData:value];
    
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

- (IBAction)search {
    [self.sohnumTextField resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(dingdanSearchViewDidSearch:)]) {
        [self.delegate dingdanSearchViewDidSearch:self];
    }
}

- (IBAction)reset {
     [self setupData];
}
@end
