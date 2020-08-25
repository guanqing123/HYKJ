//
//  KJZuDanSearchView.m
//  HYKJ
//
//  Created by information on 2020/8/24.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJZuDanSearchView.h"

#import "KJHYTool.h"

#import "KJDatePickerView.h"
#import "KJDataPickerView.h"
#import "KJCoverView.h"

@interface KJZuDanSearchView() <UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate,KJDatePickerViewDelegate,KJDataPickerViewDelegate>

// date view
@property (nonatomic, strong)  KJDatePickerView *datePickerView;
// data view
@property (nonatomic, strong)  KJDataPickerView *dataPickerView;

@property (nonatomic, strong)  KJCoverView *coverView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, weak) UITextField  *zdTextField;

// 回单
@property (nonatomic, strong)  NSArray *huidanArray;
@property (nonatomic, strong)  NSDictionary *huidanDict;

// 运单类型
@property (nonatomic, strong)  NSArray *yundanArray;
@property (nonatomic, strong)  NSDictionary *yundanDict;

// 配送类型
@property (nonatomic, strong)  NSArray *peisongArray;
@property (nonatomic, strong)  NSDictionary *peisongDict;

- (IBAction)reset;
- (IBAction)search;

@end

@implementation KJZuDanSearchView

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
    
    // 组单号
    _zddh = @"";
    
    //回单状态
    _huidanArray = [NSArray arrayWithObjects:@"全部", @"回单否", @"回单是", nil];
    NSArray *huidanArray = [NSArray arrayWithObjects:@"", @"1", @"2", nil];
    _huidanDict = [NSDictionary dictionaryWithObjects:huidanArray forKeys:_huidanArray];
    _hd = @"";
    _huidan = @"全部";
    
    // 运单类型
    _yundanArray = [NSArray arrayWithObjects:@"全部", @"整车", @"零担", nil];
    NSArray *yundanArray = [NSArray arrayWithObjects:@"", @"1", @"2", nil];
    _yundanDict = [NSDictionary dictionaryWithObjects:yundanArray forKeys:_yundanArray];
    _yd = @"";
    _yundan = @"全部";
    
    // 配送类型
    _peisongArray = [NSArray arrayWithObjects:@"全部", @"送货上门", @"自提", nil];
    NSArray *peisongArray = [NSArray arrayWithObjects:@"", @"1", @"2", nil];
    _peisongDict = [NSDictionary dictionaryWithObjects:peisongArray forKeys:_peisongArray];
    _ps = @"";
    _peisong = @"全部";
    [self.tableView reloadData];
}

+ (instancetype)searchView {
    return [[[NSBundle mainBundle] loadNibNamed:@"KJZuDanSearchView" owner:nil options:nil] lastObject];
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     __weak typeof(cell) weakCell = cell;
    if (indexPath.row == 0) {
        UILabel *dzLabel = [[UILabel alloc] init];
        dzLabel.text = @"组单日期:";
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
        UILabel *zdLabel = [[UILabel alloc] init];
        zdLabel.text = @"组单单号:";
        zdLabel.font = [UIFont systemFontOfSize:13.0f];
        zdLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:zdLabel];
        [zdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakCell.contentView).offset(5);
            make.centerY.equalTo(weakCell.contentView);
            make.width.mas_equalTo(weakCell.contentView.mas_width).dividedBy(5).offset(5);
            make.height.mas_equalTo(20);
        }];
        
        UITextField *zdTextField = [[UITextField alloc] init];
        zdTextField.backgroundColor = RGB(238, 238, 238);
        zdTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        zdTextField.delegate = self;
        [zdTextField.layer setBorderColor:[RGB(200, 200, 200) CGColor]];
        [zdTextField.layer setBorderWidth:1.0f];
        [zdTextField.layer setCornerRadius:5.0f];
        zdTextField.returnKeyType = UIReturnKeyDone;
        zdTextField.text = _zddh;
        _zdTextField = zdTextField;
        [cell.contentView addSubview:zdTextField];
        [zdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(zdLabel.mas_right).offset(15);
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
        UILabel *hdLabel = [[UILabel alloc] init];
        hdLabel.text = @"回单状态:";
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
        [hdBtn setTitle:_huidan forState:UIControlStateNormal];
        [hdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [hdBtn addTarget:self action:@selector(hdBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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
    } else if (indexPath.row == 3) {
        UILabel *ydLabel = [[UILabel alloc] init];
        ydLabel.text = @"运单类型:";
        ydLabel.font = [UIFont systemFontOfSize:13.0f];
        ydLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:ydLabel];
        [ydLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakCell.contentView).offset(5);
            make.centerY.equalTo(weakCell.contentView);
            make.width.mas_equalTo(weakCell.contentView.mas_width).dividedBy(5).offset(5);
            make.height.mas_equalTo(20);
        }];
        
        UIButton *ydBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        ydBtn.tag = 1;
        ydBtn.backgroundColor = RGB(238, 238, 238);
        ydBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [ydBtn setTitle:_yundan forState:UIControlStateNormal];
        [ydBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [ydBtn addTarget:self action:@selector(ydBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        ydBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [ydBtn.layer setBorderColor:[RGB(200, 200, 200) CGColor]];
        [ydBtn.layer setBorderWidth:1.0f];
        [ydBtn.layer setCornerRadius:5.0f];
        [cell.contentView addSubview:ydBtn];
        [ydBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ydLabel.mas_right).offset(15);
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
        UILabel *psLabel = [[UILabel alloc] init];
        psLabel.text = @"配送类型:";
        psLabel.font = [UIFont systemFontOfSize:13.0f];
        psLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:psLabel];
        [psLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakCell.contentView).offset(5);
            make.centerY.equalTo(weakCell.contentView);
            make.width.mas_equalTo(weakCell.contentView.mas_width).dividedBy(5).offset(5);
            make.height.mas_equalTo(20);
        }];
               
        UIButton *psBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        psBtn.tag = 2;
        psBtn.backgroundColor = RGB(238, 238, 238);
        psBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [psBtn setTitle:_peisong forState:UIControlStateNormal];
        [psBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [psBtn addTarget:self action:@selector(psBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        psBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [psBtn.layer setBorderColor:[RGB(200, 200, 200) CGColor]];
        [psBtn.layer setBorderWidth:1.0f];
        [psBtn.layer setCornerRadius:5.0f];
        [cell.contentView addSubview:psBtn];
        [psBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(psLabel.mas_right).offset(15);
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
    [self.zdTextField resignFirstResponder];
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
- (void)textFieldDidEndEditing:(UITextField *)textField {
    _zddh = textField.text;
}

#pragma mark - dataBtnClick
- (void)didFinishDataPicker:(KJDataPickerView *)dataPickerView buttonType:(DataPickerViewButtonType)buttonType {
    switch (buttonType) {
        case DataPickerViewButtonTypeCancel:
            [self.coverView destory];
            break;
        case DataPickerViewButtonTypeSure:
            if (dataPickerView.tag == 0) {
                _huidan = dataPickerView.selecteData;
                _hd = [_huidanDict objectForKey:_huidan];
            }
            if (dataPickerView.tag == 1) {
                _yundan = dataPickerView.selecteData;
                _yd = [_yundanDict objectForKey:_yundan];
            }
            if (dataPickerView.tag == 2) {
                _peisong = dataPickerView.selecteData;
                _ps = [_peisongDict objectForKey:_peisong];
            }
            [self.tableView reloadData];
            [self.coverView destory];
            break;
        default:
            break;
    }
}

- (void)hdBtnClick:(UIButton *)button {
    [self dataBtnClick:(int)button.tag value:self.huidan data:self.huidanArray];
}

- (void)ydBtnClick:(UIButton *)button {
    [self dataBtnClick:(int)button.tag value:self.yundan data:self.yundanArray];
}

- (void)psBtnClick:(UIButton *)button {
    [self dataBtnClick:(int)button.tag value:self.peisong data:self.peisongArray];
}

- (void)dataBtnClick:(int)tag value:(NSString *)value data:(NSArray *)data{
    [self.zdTextField resignFirstResponder];
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
    if ([self.delegate respondsToSelector:@selector(zudanSearchViewDidSearch:)]) {
        [self.delegate zudanSearchViewDidSearch:self];
    }
}

- (IBAction)reset {
    [self setupData];
}
@end
