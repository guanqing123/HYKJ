//
//  KJDaoKuanViewController.m
//  HYKJ
//
//  Created by information on 2020/8/13.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJDaoKuanViewController.h"

#import "MJRefresh.h"

// table
#import "KJDaoKuanTableViewCell.h"
#import "KJDaoKuanTableHeaderView.h"

#import "KJDaoKuanSearchView.h"

@interface KJDaoKuanViewController () <UITableViewDelegate,UITableViewDataSource>

// tableView
@property (nonatomic, weak) UITableView  *tableView;

// 到款
@property (nonatomic, strong)  NSMutableArray *dataArray;

@property (nonatomic, weak) UIScrollView  *baseView;

@property (nonatomic, strong) KJDaoKuanSearchView  *searchView;

@property (assign, nonatomic) BOOL isAppeared;

@end

@implementation KJDaoKuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1.设置导航
    [self setupNav];
    
    // 2.tableView
    [self setTableView];
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
        _searchView = [KJDaoKuanSearchView searchView];
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
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.searchView.alpha = 1;
        }];
    } else {
        WEAKSELF
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.searchView.alpha = 0;
        }];
    }
}

// 2.tableView
- (void)setTableView {
    
    UIScrollView *baseView = [[UIScrollView alloc] init];
    baseView.contentSize = CGSizeMake(1280.0f, 0.0f);
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
    
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    [self.baseView addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@(0));
        make.width.mas_equalTo(@(1280));
        
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
    
    [tableView registerNib:[UINib nibWithNibName:@"KJDaoKuanTableViewCell" bundle:nil] forCellReuseIdentifier:@"KJDaoKuanTableViewCellID"];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - talbeView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KJDaoKuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KJDaoKuanTableViewCellID" forIndexPath:indexPath];
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
    KJDaoKuanTableHeaderView *headerView = [KJDaoKuanTableHeaderView headerView];
    headerView.frame = CGRectMake(0.0f, 0.0f, 1280.0f, 44.0f);
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
