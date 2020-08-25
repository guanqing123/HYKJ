//
//  KJTuiHuoViewController.m
//  HYKJ
//
//  Created by information on 2020/8/21.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJTuiHuoViewController.h"
#import "KJTuiHuoDetailViewController.h"

// tool
#import "KJTuiHuoTool.h"

// model
#import "KJTuiHuoZDParam.h"

// table
#import "MJRefresh.h"
#import "KJTuiHuoTableViewCell.h"
#import "KJTuiHuoTableHeaderView.h"

// view
#import "KJTuiHuoSearchView.h"

@interface KJTuiHuoViewController ()<UITableViewDataSource,UITableViewDelegate,KJTuiHuoSearchViewDelegate,KJTuiHuoTableViewCellDelegate>

@property (nonatomic, strong) KJTuiHuoSearchView  *searchView;

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
@property (nonatomic, copy) NSString *nodeId;
@property (nonatomic, copy) NSString *tjgs;

@end

@implementation KJTuiHuoViewController

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
        _searchView = [KJTuiHuoSearchView searchView];
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
- (void)tuihuoSearchView:(KJTuiHuoSearchView *)tuihuoSearchView {
    [self shanxuan];
    self.startDat = tuihuoSearchView.startDat;
    self.endDat = tuihuoSearchView.endDat;
    self.tjgs = tuihuoSearchView.tjgs;
    self.nodeId = tuihuoSearchView.nodeId;
    [self.tableView.mj_header beginRefreshing];
}

// 2.tableView
- (void)setTableView {
    // 1. baseView
    UIScrollView *baseView = [[UIScrollView alloc] init];
    baseView.contentSize = CGSizeMake(1390.0f, 0.0f);
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
        make.width.mas_equalTo(@(1390));

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
    
    [tableView registerNib:[UINib nibWithNibName:@"KJTuiHuoTableViewCell" bundle:nil] forCellReuseIdentifier:@"KJTuiHuoTableViewCellID"];
}

- (void)headerRefreshing {
    _pageNum = 1;
    _pageSize = 20;
    KJTuiHuoZDParam *tuihuoZDParam = [[KJTuiHuoZDParam alloc] init];
    tuihuoZDParam.startDat = self.startDat;
    tuihuoZDParam.endDat = self.endDat;
    tuihuoZDParam.tjgs = self.tjgs;
    tuihuoZDParam.nodeId = self.nodeId;
    tuihuoZDParam.page = self.pageNum;
    tuihuoZDParam.limit = self.pageSize;
    WEAKSELF
    [KJTuiHuoTool getTuiHuoList:tuihuoZDParam success:^(KJTuiHuoZDResult * _Nonnull result) {
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
    KJTuiHuoZDParam *tuihuoZDParam = [[KJTuiHuoZDParam alloc] init];
    tuihuoZDParam.startDat = self.startDat;
    tuihuoZDParam.endDat = self.endDat;
    tuihuoZDParam.tjgs = self.tjgs;
    tuihuoZDParam.nodeId = self.nodeId;
    tuihuoZDParam.page = self.pageNum;
    tuihuoZDParam.limit = self.pageSize;
    WEAKSELF
    [KJTuiHuoTool getTuiHuoList:tuihuoZDParam success:^(KJTuiHuoZDResult * _Nonnull result) {
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
    KJTuiHuoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KJTuiHuoTableViewCellID" forIndexPath:indexPath];
    cell.delegate = self;
    
    KJTuiHuoZD *tuihuoZD = self.dataArray[indexPath.row];
    cell.tuihuoZD = tuihuoZD;
    
    return cell;
}

#pragma mark - KJTuiHuoTableViewCellDelegate
- (void)tuihuoTableViewCellShowDetail:(KJTuiHuoTableViewCell *)tableViewCell {
    KJTuiHuoDetailViewController *detailVc = [[KJTuiHuoDetailViewController alloc] initWithMainId:tableViewCell.tuihuoZD.mainId];
    detailVc.view.backgroundColor = [UIColor whiteColor];
    detailVc.title = @"退货详情";
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
    KJTuiHuoTableHeaderView *headerView = [KJTuiHuoTableHeaderView headerView];
    headerView.frame = CGRectMake(0.0f, 0.0f, 1390.0f, 44.0f);
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
