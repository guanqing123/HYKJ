//
//  KJDaoKuanViewController.m
//  HYKJ
//
//  Created by information on 2020/8/13.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJDaoKuanViewController.h"
#import "MJRefresh.h"

#import "KJDaoKuanTableViewCell.h"

@interface KJDaoKuanViewController () <UITableViewDelegate,UITableViewDataSource>

// tableView
@property (nonatomic, weak) UITableView  *tableView;

// 到款
@property (nonatomic, strong)  NSMutableArray *dataArray;

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

// 2.tableView
- (void)setTableView {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, KJTopNavH, ScreenW, ScreenH - KJTopNavH);
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    
    [tableView registerNib:[UINib nibWithNibName:@"KJDaoKuanTableViewCell" bundle:nil] forCellReuseIdentifier:@"KJDaoKuanTableViewCellID"];
    [self.view addSubview:tableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.tableView.contentSize = CGSizeMake(1280.0f, 0.0f);
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - talbeView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
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

@end
