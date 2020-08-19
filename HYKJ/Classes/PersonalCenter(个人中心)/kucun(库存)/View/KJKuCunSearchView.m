//
//  KJKuCunSearchView.m
//  HYKJ
//
//  Created by information on 2020/8/18.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJKuCunSearchView.h"
#import "KJKuCunTool.h"

#import "KJHYTool.h"
// dataView
#import "KJDataPickerView.h"
#import "KJCoverView.h"

@interface KJKuCunSearchView()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, KJDataPickerViewDelegate>

// view
@property (weak, nonatomic) IBOutlet UITextField *cpxhTextField;
@property (weak, nonatomic) IBOutlet UITextField *cpdmTextField;
@property (weak, nonatomic) IBOutlet UITextField *cpmcTextField;

@property (nonatomic, strong) UITextField  *commonTextField;

@property (weak, nonatomic) IBOutlet UIButton *tjgsBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// action
- (IBAction)valueChanged:(UITextField *)textField;
- (IBAction)tjgsBtnClick:(UIButton *)tjgsBtn;
- (IBAction)search;
- (IBAction)reset;

// data view
@property (nonatomic, strong)  KJDataPickerView *dataPickerView;
@property (nonatomic, strong)  KJCoverView *coverView;

// 产业代码
@property (nonatomic, strong)  NSMutableArray *dms;
// 产业名称
@property (nonatomic, strong)  NSMutableArray *mcs;
// 产业dict
@property (nonatomic, strong)  NSDictionary *dmc;

@end

@implementation KJKuCunSearchView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupData];
}

- (void)setupData {
    self.cpxh = @"";
    self.cpxhTextField.text = @"";
    
    self.cpdm = @"";
    self.cpdmTextField.text = @"";
    
    self.cpmc = @"";
    self.cpmcTextField.text = @"";
    
    self.tjgs = @"";
    self.tjgssm = @"全部";
    [self.tjgsBtn setTitle:@"全部" forState:UIControlStateNormal];
    [self.tableView reloadData];
}

- (KJCoverView *)coverView {
    if (_coverView == nil) {
        _coverView = [[KJCoverView alloc] initCoverView];
    }
    return _coverView;
}

- (NSMutableArray *)dms {
    if (!_dms) {
        _dms = [NSMutableArray array];
    }
    return _dms;
}

- (NSMutableArray *)mcs {
    if (!_mcs) {
        _mcs = [NSMutableArray array];
    }
    return _mcs;
}

- (void)initData {
    [KJKuCunTool getStofcysuccess:^(NSArray * _Nonnull cks) {
        for (KJCyResult *result in cks) {
            [self.dms addObject:result.CYDM];
            [self.mcs addObject:result.CYMC];
        }
        self.dmc = [NSDictionary dictionaryWithObjects:self.dms forKeys:self.mcs];
    } failure:^(NSError * _Nonnull error) {}];
}

+ (instancetype)searchView {
    return [[[NSBundle mainBundle] loadNibNamed:@"KJKuCunSearchView" owner:nil options:nil] lastObject];
}

#pragma mark - dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"KJKuCunSearchView" owner:nil options:nil][indexPath.row];
    return cell;
}

- (IBAction)reset {
    [self setupData];
}

- (IBAction)search {
    [self.commonTextField resignFirstResponder];
    
    if ([self.delegate respondsToSelector:@selector(kucunSearchView:)]) {
        [self.delegate kucunSearchView:self];
    }
}

#pragma mark - tjgs
- (void)didFinishDataPicker:(KJDataPickerView *)dataPickerView buttonType:(DataPickerViewButtonType)buttonType {
    switch (buttonType) {
        case DataPickerViewButtonTypeCancel:
            [self.coverView destory];
            break;
        case DataPickerViewButtonTypeSure:
            _tjgssm = dataPickerView.selecteData;
            _tjgs = [_dmc objectForKey:_tjgssm];
            [self.tjgsBtn setTitle:_tjgssm forState:UIControlStateNormal];
            [self.coverView destory];
            break;
        default:
            break;
    }
}

- (IBAction)tjgsBtnClick:(UIButton *)tjgsBtn {
    [self.commonTextField resignFirstResponder];
    
    self.tjgsBtn = tjgsBtn;
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
- (IBAction)valueChanged:(UITextField *)textField {
    self.commonTextField = textField;
    switch (textField.tag) {
        case 0:
            self.cpxh = textField.text;
            break;
        case 1:
            self.cpdm = textField.text;
            break;
        case 2:
            self.cpmc = textField.text;
            break;
        default:
            break;
    }
}

@end
