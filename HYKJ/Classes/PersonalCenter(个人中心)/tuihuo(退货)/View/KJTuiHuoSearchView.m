//
//  KJTuiHuoSearchView.m
//  HYKJ
//
//  Created by information on 2020/8/21.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJTuiHuoSearchView.h"
#import "KJTuiHuoTool.h"

#import "KJHYTool.h"

#import "KJDatePickerView.h"
#import "KJDataPickerView.h"
#import "KJCoverView.h"

@interface KJTuiHuoSearchView()<UITableViewDataSource, UITableViewDelegate, KJDataPickerViewDelegate,KJDatePickerViewDelegate>

- (IBAction)reset;
- (IBAction)search;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// date view
@property (nonatomic, strong)  KJDatePickerView *datePickerView;
// data view
@property (nonatomic, strong)  KJDataPickerView *dataPickerView;

@property (nonatomic, strong)  KJCoverView *coverView;

@property (nonatomic, strong)  NSMutableArray *nodeIdArray;
@property (nonatomic, strong)  NSMutableArray *nodeNameArray;
@property (nonatomic, strong)  NSDictionary *idAndNameDict;

// 产业代码
@property (nonatomic, strong)  NSArray *dms;
// 产业名称
@property (nonatomic, strong)  NSArray *mcs;
// 产业dict
@property (nonatomic, strong)  NSDictionary *dmc;

@end

@implementation KJTuiHuoSearchView

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
    
    _nodeName = @"全部";
    _nodeId = @"";
    
    _tjgssm = @"全部";
    _tjgs = @"";
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _mcs = [userDefaults objectForKey:cymc];
    _dms = [userDefaults objectForKey:cydm];
    _dmc = [NSDictionary dictionaryWithObjects:_dms forKeys:_mcs];
    [self.tableView reloadData];
}

- (NSMutableArray *)nodeIdArray {
    if (!_nodeIdArray) {
        _nodeIdArray = [NSMutableArray array];
    }
    return _nodeIdArray;
}

- (NSMutableArray *)nodeNameArray {
    if (!_nodeNameArray) {
        _nodeNameArray = [NSMutableArray array];
    }
    return _nodeNameArray;
}

- (void)initData {
    [KJTuiHuoTool getNodeList:^(NSArray * _Nonnull ths) {
        for (KJNode *node in ths) {
            [self.nodeIdArray addObject:node.nodeId];
            [self.nodeNameArray addObject:node.nodeName];
        }
        self.idAndNameDict = [NSDictionary dictionaryWithObjects:self.nodeIdArray forKeys:self.nodeNameArray];
    } failure:^(NSError * _Nonnull error) {}];
}

+ (instancetype)searchView {
    return [[[NSBundle mainBundle] loadNibNamed:@"KJTuiHuoSearchView" owner:nil options:nil] lastObject];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     __weak typeof(cell) weakCell = cell;
    if (indexPath.row == 0) {
        UILabel *dzLabel = [[UILabel alloc] init];
        dzLabel.text = @"退货日期:";
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
        cyLabel.text = @"统计归属:";
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
        fcyBtn.tag = 0;
        fcyBtn.backgroundColor = RGB(238, 238, 238);
        fcyBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [fcyBtn setTitle:_tjgssm forState:UIControlStateNormal];
        [fcyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [fcyBtn addTarget:self action:@selector(fcyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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
        UILabel *spLabel = [[UILabel alloc] init];
        spLabel.text = @"审批节点:";
        spLabel.font = [UIFont systemFontOfSize:13.0f];
        spLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:spLabel];
        [spLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakCell.contentView).offset(5);
            make.centerY.equalTo(weakCell.contentView);
            make.width.mas_equalTo(weakCell.contentView.mas_width).dividedBy(5).offset(5);
            make.height.mas_equalTo(20);
        }];
        
        UIButton *spBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        spBtn.tag = 1;
        spBtn.backgroundColor = RGB(238, 238, 238);
        spBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [spBtn setTitle:_nodeName forState:UIControlStateNormal];
        [spBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [spBtn addTarget:self action:@selector(spBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        spBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [spBtn.layer setBorderColor:[RGB(200, 200, 200) CGColor]];
        [spBtn.layer setBorderWidth:1.0f];
        [spBtn.layer setCornerRadius:5.0f];
        [cell.contentView addSubview:spBtn];
        [spBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(spLabel.mas_right).offset(15);
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
            if (dataPickerView.tag == 0) {
                _tjgssm = dataPickerView.selecteData;
                _tjgs = [_dmc objectForKey:_tjgssm];
            }
            if (dataPickerView.tag == 1) {
                _nodeName = dataPickerView.selecteData;
                _nodeId = [_idAndNameDict objectForKey:_nodeName];
            }
            [self.tableView reloadData];
            [self.coverView destory];
            break;
        default:
            break;
    }
}

- (void)fcyBtnClick:(UIButton *)button {
    [self dataBtnClick:(int)button.tag value:self.tjgssm data:self.mcs];
}

- (void)spBtnClick:(UIButton *)button {
    [self dataBtnClick:(int)button.tag value:self.nodeName data:self.nodeNameArray];
}

- (void)dataBtnClick:(int)tag value:(NSString *)value data:(NSArray *)data{
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
    if ([self.delegate respondsToSelector:@selector(tuihuoSearchView:)]) {
        [self.delegate tuihuoSearchView:self];
    }
}

- (IBAction)reset {
    [self setupData];
}
@end
