//
//  KJKuCunViewController.m
//  HYKJ
//
//  Created by information on 2020/8/18.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJKuCunViewController.h"

// tool
#import "KJKuCunTool.h"

// model
#import "KJKuCunParam.h"

// table
#import "MJRefresh.h"
#import "KJKuCunTableViewCell.h"
#import "KJKuCunTableHeaderView.h"

// view
#import "KJKuCunSearchView.h"

@interface KJKuCunViewController ()<UITableViewDataSource,UITableViewDelegate,KJKuCunSearchViewDelegate>

@property (nonatomic, strong) KJKuCunSearchView  *searchView;

// tableView
@property (nonatomic, weak) UIScrollView  *baseView;
@property (nonatomic, weak) UITableView  *tableView;
@property (nonatomic, weak) UILabel  *totalLabel;

// data
@property (nonatomic, strong)  NSMutableArray *dataArray;

// 分页
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, assign) NSInteger pageSize;

// condition
@property (nonatomic, copy) NSString *cpxh;
@property (nonatomic, copy) NSString *cpdm;
@property (nonatomic, copy) NSString *cpmc;
@property (nonatomic, copy) NSString *tjgs;

@end

@implementation KJKuCunViewController

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
        _searchView = [KJKuCunSearchView searchView];
        [_searchView initData];
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
- (void)kucunSearchView:(KJKuCunSearchView *)kucunSearchView {
    [self shanxuan];
    self.cpxh = kucunSearchView.cpxh;
    self.cpdm = kucunSearchView.cpdm;
    self.cpmc = kucunSearchView.cpmc;
    self.tjgs = kucunSearchView.tjgs;
    [self.tableView.mj_header beginRefreshing];
}

// 2.tableView
- (void)setTableView {
    // 1. baseView
    UIScrollView *baseView = [[UIScrollView alloc] init];
    baseView.contentSize = CGSizeMake(840.0f, 0.0f);
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
        [make bottom].equalTo(bottom).offset(-32);
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
        make.width.mas_equalTo(@(840));

        MASViewAttribute *top = [self mas_topLayoutGuideBottom];
        MASViewAttribute *bottom = [self mas_bottomLayoutGuideTop];

        #ifdef __IPHONE_11_0    // 如果有这个宏，说明Xcode版本是9开始
            if (@available(iOS 11.0, *)) {
                top = [[self view] mas_safeAreaLayoutGuideTop];
                bottom = [[self view] mas_safeAreaLayoutGuideBottom];
            }
        #endif

        [make top].equalTo(top);
        [make bottom].equalTo(bottom).offset(-32);
    }];
    
    [tableView registerNib:[UINib nibWithNibName:@"KJKuCunTableViewCell" bundle:nil] forCellReuseIdentifier:@"KJKuCunTableViewCellID"];
    
    // 3. bottomView
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = RGB(0, 157, 133);
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        [[make leading] trailing].equalTo([self view]);

        MASViewAttribute *bottom = [self mas_bottomLayoutGuideTop];

        #ifdef __IPHONE_11_0    // 如果有这个宏，说明Xcode版本是9开始
            if (@available(iOS 11.0, *)) {
                bottom = [[self view] mas_safeAreaLayoutGuideBottom];
            }
        #endif
        [make height].mas_equalTo(@(32));
        [make bottom].equalTo(bottom);
    }];
    
    UILabel *totalLabel = [[UILabel alloc] init];
    totalLabel.frame = CGRectMake(10.0f, 6.0f, 200.0f, 20.0f);
    totalLabel.font = [UIFont systemFontOfSize:14];
    totalLabel.textColor = [UIColor whiteColor];
    totalLabel.text = [NSString stringWithFormat:@"库存总数: 0"];
    _totalLabel = totalLabel;
    [bottomView addSubview:totalLabel];
}

- (void)headerRefreshing {
    _pageNum = 1;
    _pageSize = 20;
    KJKuCunParam *kucunParam = [[KJKuCunParam alloc] init];
    kucunParam.cpxh = self.cpxh;
    kucunParam.cpdm = self.cpdm;
    kucunParam.cpmc = self.cpmc;
    kucunParam.tjgs = self.tjgs;
    kucunParam.page = self.pageNum;
    kucunParam.limit = self.pageSize;
    WEAKSELF
    [KJKuCunTool getKuCunList:kucunParam success:^(KJKuCunResult * _Nonnull result) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:result.data];
        if ([result.total length] < 1) {
            result.total = @"0";
        }
        [self.totalLabel setText:[NSString stringWithFormat:@"库存总数: %@", result.total]];
        
        NSInteger pages = ( result.count + weakSelf.pageSize - 1 ) / weakSelf.pageSize;
        if (pages > 1) {
            self.pageNum ++;
            [self setupFooterRefreshing];
        } else {
            self.tableView.mj_footer = nil;
        }
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

- (void)setupFooterRefreshing {
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
}

- (void)footerRefreshing {
    KJKuCunParam *kucunParam = [[KJKuCunParam alloc] init];
    kucunParam.cpxh = self.cpxh;
    kucunParam.cpdm = self.cpdm;
    kucunParam.cpmc = self.cpmc;
    kucunParam.tjgs = self.tjgs;
    kucunParam.page = self.pageNum;
    kucunParam.limit = self.pageSize;
    WEAKSELF
    [KJKuCunTool getKuCunList:kucunParam success:^(KJKuCunResult * _Nonnull result) {
        [self.dataArray addObjectsFromArray:result.data];
        [self.tableView reloadData];
        self->_pageNum ++;
        NSInteger totalPage = ( result.count + weakSelf.pageSize - 1) / weakSelf.pageSize;
        if (self->_pageNum > totalPage) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];
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
    KJKuCunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KJKuCunTableViewCellID" forIndexPath:indexPath];
    
    KJKuCun *kucun = self.dataArray[indexPath.row];
    cell.kucun = kucun;
    
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
    KJKuCunTableHeaderView *headerView = [KJKuCunTableHeaderView headerView];
    headerView.frame = CGRectMake(0.0f, 0.0f, 840.0f, 44.0f);
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
