//
//  KJDingDanViewController.m
//  HYKJ
//
//  Created by information on 2020/8/26.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJDingDanViewController.h"
#import "KJDingDanDetailViewController.h"

// tool
#import "KJDingDanTool.h"

// model
#import "KJDingDanParam.h"

// table
#import "MJRefresh.h"
#import "KJDingDanTableViewCell.h"
#import "KJDingDanTableHeaderView.h"

// view
#import "KJDingDanSearchView.h"

@interface KJDingDanViewController () <UITableViewDataSource,UITableViewDelegate,KJDingDanSearchViewDelegate,KJDingDanTableViewCellDelegate>

@property (nonatomic, strong) KJDingDanSearchView  *searchView;

// tableView
@property (nonatomic, weak) UIScrollView  *baseView;
@property (nonatomic, weak) UITableView  *tableView;
@property (nonatomic, weak) UILabel  *totalLabel;

// 分页
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, assign) NSInteger pageSize;

// data
@property (nonatomic, strong)  NSMutableArray *dataArray;

// condition
@property (nonatomic, copy) NSString *startDat;
@property (nonatomic, copy) NSString *endDat;
@property (nonatomic, copy) NSString *tjgs;
@property (nonatomic, copy) NSString *ordsta;
@property (nonatomic, copy) NSString *allsta;
@property (nonatomic, copy) NSString *dlvsta;
@property (nonatomic, copy) NSString *invsta;
@property (nonatomic, copy) NSString *cdtsat;
@property (nonatomic, copy) NSString *sohnum;

@end

@implementation KJDingDanViewController

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
        _searchView = [KJDingDanSearchView searchView];
        _searchView.delegate = self;
        _searchView.alpha = 0;
        [self.view addSubview:_searchView];
        [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.top.equalTo(self.baseView);
            make.right.equalTo(self.view);
            make.height.mas_equalTo(@(264));
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

// KJZuDanSearchViewDelegate
- (void)dingdanSearchViewDidSearch:(KJDingDanSearchView *)searchView {
    [self shanxuan];
    self.startDat = searchView.startDat;
    self.endDat = searchView.endDat;
    self.tjgs = searchView.tjgs;
    self.ordsta = searchView.ordsta;
    self.allsta = searchView.allsta;
    self.dlvsta = searchView.dlvsta;
    self.invsta = searchView.invsta;
    self.sohnum = searchView.sohnum;
    [self.tableView.mj_header beginRefreshing];
}

// 2.tableView
- (void)setTableView {
    // 1. baseView
    UIScrollView *baseView = [[UIScrollView alloc] init];
    baseView.contentSize = CGSizeMake(1840.0f, 0.0f);
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
        make.width.mas_equalTo(@(1840));

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
    
    [tableView registerNib:[UINib nibWithNibName:@"KJDingDanTableViewCell" bundle:nil] forCellReuseIdentifier:@"KJDingDanTableViewCellID"];
}

- (void)headerRefreshing {
    _pageNum = 1;
    _pageSize = 20;
    KJDingDanParam *dingdanParam = [[KJDingDanParam alloc] init];
    dingdanParam.startDat = self.startDat;
    dingdanParam.endDat = self.endDat;
    dingdanParam.tjgs = self.tjgs;
    dingdanParam.ordsta = self.ordsta;
    dingdanParam.allsta = self.allsta;
    dingdanParam.dlvsta = self.dlvsta;
    dingdanParam.invsta = self.invsta;
    dingdanParam.sohnum = self.sohnum;
    WEAKSELF
    [KJDingDanTool getDingDanList:dingdanParam success:^(KJDingDanResult * _Nonnull result) {
        if ([result.data count] < 1) {
            [SVProgressHUD showInfoWithStatus:@"该查询条件下没有数据!"];
        }
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:result.data];
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
    KJDingDanParam *dingdanParam = [[KJDingDanParam alloc] init];
    dingdanParam.startDat = self.startDat;
    dingdanParam.endDat = self.endDat;
    dingdanParam.tjgs = self.tjgs;
    dingdanParam.ordsta = self.ordsta;
    dingdanParam.allsta = self.allsta;
    dingdanParam.dlvsta = self.dlvsta;
    dingdanParam.invsta = self.invsta;
    WEAKSELF
    [KJDingDanTool getDingDanList:dingdanParam success:^(KJDingDanResult * _Nonnull result) {
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
    KJDingDanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KJDingDanTableViewCellID" forIndexPath:indexPath];
    cell.delegate = self;
    
    KJDingDan *dingdan = self.dataArray[indexPath.row];
    cell.dingdan = dingdan;
    
    return cell;
}

#pragma mark - KJDingDanTableViewCellDelegate
- (void)dingdanTableViewCellShowDetail:(KJDingDanTableViewCell *)tableViewCell {
    KJDingDanDetailViewController *detailVc = [[KJDingDanDetailViewController alloc] initWithSohnum:tableViewCell.dingdan.sohnum];
    detailVc.view.backgroundColor = [UIColor whiteColor];
    detailVc.title = @"订单详情";
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    KJDingDanTableHeaderView *headerView = [KJDingDanTableHeaderView headerView];
    headerView.frame = CGRectMake(0.0f, 0.0f, 1840.0f, 44.0f);
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
