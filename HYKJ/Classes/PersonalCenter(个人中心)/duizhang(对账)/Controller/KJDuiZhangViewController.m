//
//  KJDuiZhangViewController.m
//  HYKJ
//
//  Created by information on 2020/8/20.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJDuiZhangViewController.h"

// tool
#import "KJDuiZhangTool.h"

// model
#import "KJDuiZhangParam.h"

// table
#import "MJRefresh.h"
#import "KJDuiZhangTableViewCell.h"
#import "KJDuiZhangTableHeaderView.h"

// view
#import "KJDuiZhangSearchView.h"

@interface KJDuiZhangViewController ()<UITableViewDataSource,UITableViewDelegate,KJDuiZhangSearchViewDelegate>

@property (nonatomic, strong) KJDuiZhangSearchView  *searchView;

// tableView
@property (nonatomic, weak) UIScrollView  *baseView;
@property (nonatomic, weak) UITableView  *tableView;
@property (nonatomic, weak) UILabel  *totalLabel;

// data
@property (nonatomic, strong)  NSMutableArray *dataArray;

// condition
@property (nonatomic, copy) NSString *startDat;
@property (nonatomic, copy) NSString *endDat;
@property (nonatomic, copy) NSString *khdm;
@property (nonatomic, copy) NSString *tjgs;

@end

@implementation KJDuiZhangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1.设置导航
    [self setupNav];
    
    // 2.tableView
    [self setTableView];
    
    // 3. do shanxuan
    [self shanxuan];
}

// 1.设置导航
- (void)setupNav {
    // 1. back
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"30"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    // 2. shanxuan
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shanxuan"] style:UIBarButtonItemStyleDone target:self action:@selector(shanxuan)];
}

- (void)shanxuan {
    if (_searchView == nil) {
        _searchView = [KJDuiZhangSearchView searchView];
        _searchView.delegate = self;
        _searchView.alpha = 0;
        [self.view addSubview:_searchView];
        [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.top.equalTo(self.baseView);
            make.right.equalTo(self.view);
            make.height.mas_equalTo(@(220));
        }];
    }
    if (_searchView.alpha == 0) {
        WEAKSELF
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.searchView.alpha = 1;
        }];
    } else {
        WEAKSELF
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.searchView.alpha = 0;
        }];
    }
}

// KJKuCunSearchViewDelegate
- (void)duizhangSearchView:(KJDuiZhangSearchView *)duizhangSearchView {
    [self shanxuan];
    self.startDat = duizhangSearchView.startDat;
    self.endDat = duizhangSearchView.endDat;
    self.tjgs = duizhangSearchView.tjgs;
    self.khdm = duizhangSearchView.khdm;
    [self.tableView.mj_header beginRefreshing];
}

// 2.tableView
- (void)setTableView {
    // 1. baseView
    UIScrollView *baseView = [[UIScrollView alloc] init];
    baseView.contentSize = CGSizeMake(1860.0f, 0.0f);
    _baseView = baseView;
    [self.view addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        [[make trailing] leading].equalTo([self view]);

        MASViewAttribute *top = [self mas_topLayoutGuideBottom];
        MASViewAttribute *bottom = [self mas_bottomLayoutGuideTop];

        #ifdef __IPHONE_11_0    // 如果有这个宏，说明Xcode版本是9开始
            if (@available(iOS 11.0, *)) {
                top = [[self view] mas_safeAreaLayoutGuideTop];
                bottom = [[self view] mas_safeAreaLayoutGuideBottom];
            }
        #endif

        [make top].equalTo(top);
        [make bottom].equalTo(bottom);
    }];
    
    // 2. tableView
    UITableView *tableView = [[UITableView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    self.tableView = tableView;
    [self.baseView addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@(0));
        make.width.mas_equalTo(@(1860));

        MASViewAttribute *top = [self mas_topLayoutGuideBottom];
        MASViewAttribute *bottom = [self mas_bottomLayoutGuideTop];

        #ifdef __IPHONE_11_0    // 如果有这个宏，说明Xcode版本是9开始
            if (@available(iOS 11.0, *)) {
                top = [[self view] mas_safeAreaLayoutGuideTop];
                bottom = [[self view] mas_safeAreaLayoutGuideBottom];
            }
        #endif

        [make top].equalTo(top);
        [make bottom].equalTo(bottom);
    }];
    
    [tableView registerNib:[UINib nibWithNibName:@"KJDuiZhangTableViewCell" bundle:nil] forCellReuseIdentifier:@"KJDuiZhangTableViewCellID"];
}

- (void)headerRefreshing {
    KJDuiZhangParam *duizhangParam = [[KJDuiZhangParam alloc] init];
    duizhangParam.startDat = self.startDat;
    duizhangParam.endDat = self.endDat;
    duizhangParam.khdm = self.khdm;
    duizhangParam.tjgs = self.tjgs;
    [KJDuiZhangTool getDuiZhangList:duizhangParam success:^(KJDuiZhangResult * _Nonnull result) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:result.data];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - talbeView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KJDuiZhangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KJDuiZhangTableViewCellID" forIndexPath:indexPath];
    
    KJDuiZhang *duizhang = self.dataArray[indexPath.row];
    cell.duizhang = duizhang;
    
    return cell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    KJDuiZhangTableHeaderView *headerView = [KJDuiZhangTableHeaderView headerView];
    headerView.frame = CGRectMake(0.0f, 0.0f, 1860.0f, 44.0f);
    return headerView;
}

#pragma mark - rotation
- (BOOL)shouldAutorotate{
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

@end
