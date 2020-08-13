//
//  KJMeViewController.m
//  HYKJ
//
//  Created by information on 2020/6/27.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJMeViewController.h"

// views 顶部和头部View
#import "KJCenterTopToolView.h"

// scan
#import "KJScanViewController.h"
#import "KJStyleDIY.h"

// 设置vc
#import "SPSettingViewController.h"
// bg vc
#import "SPPersonCenterHeaderView.h"

//四组Cell
#import "DCCenterItemCell.h"
#import "DCCenterServiceCell.h"
#import "TDCenterServiceCell.h"

//我的数据
#import "DCGridItem.h"
#import <MJExtension.h>
#import "KJBrowseViewController.h"

//商务
#import "TDGridItem.h"

//到款
#import "KJDaoKuanViewController.h"

@interface KJMeViewController ()<UITableViewDelegate,UITableViewDataSource,KJCenterTopToolViewDelegate,DCCenterItemCellDelegate,DCCenterServiceCellDelegate,TDCenterServiceCellDelegate>

@property (nonatomic, strong)  SPPersonCenterHeaderView *headerView;
/** 头部背景图片 */
@property (nonatomic, strong)  UIImageView *headerBgImageView;

/* tableView */
@property (nonatomic, strong)  UITableView *tableView;
/* 顶部Nav */
@property (nonatomic, strong)  KJCenterTopToolView *topToolView;
/* 扫码 */
@property (nonatomic, strong)  KJScanViewController *scanVc;

/* 我的数据 */
@property (strong , nonatomic)NSMutableArray<DCGridItem *> *serviceItem;
/* 商务 */
@property (nonatomic, strong)  NSMutableArray<TDGridItem *> *tdServiceItem;

@end

static NSString *const DCCenterItemCellID = @"DCCenterItemCell";
static NSString *const DCCenterServiceCellID = @"DCCenterServiceCell";
static NSString *const TDCenterServiceCellID = @"TDCenterServiceCell";

@implementation KJMeViewController

#pragma mark - LazyLoad
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - KJBottomTabH);
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[DCCenterItemCell class] forCellReuseIdentifier:DCCenterItemCellID];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DCCenterServiceCell class]) bundle:nil] forCellReuseIdentifier:DCCenterServiceCellID];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TDCenterServiceCell class]) bundle:nil] forCellReuseIdentifier:TDCenterServiceCellID];
    }
    return _tableView;
}

#pragma mark - LifeCycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpBase];
    
    [self setUpData];
    
    [self setUpNavTopView];
    
    [self setUpHeaderCenterView];
}

#pragma mark - setUpHeaderCenterView
- (void)setUpHeaderCenterView {
    SPPersonCenterHeaderView *headerView = [SPPersonCenterHeaderView headerView];
    WEAKSELF
    headerView.headImageBlock = ^{
        [weakSelf openSettingVc];
    };
    headerView.frame = (CGRect){CGPointZero,CGSizeMake(ScreenW, 200)};
    _headerView = headerView;
    [headerView setData];
    self.tableView.tableHeaderView = headerView;
    self.headerBgImageView.frame = headerView.bounds;
    [self.headerView insertSubview:self.headerBgImageView atIndex:0]; //将背景图片放到最底层*/
}

- (UIImageView *)headerBgImageView {
    if (!_headerBgImageView) {
        _headerBgImageView = [[UIImageView alloc] init];
        NSInteger armNum = [SPSpeedy dc_getRandomNumber:1 to:9];
        [_headerBgImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"mine_main_bg_%zd",armNum]]];
        [_headerBgImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_headerBgImageView setClipsToBounds:YES];
    }
    return _headerBgImageView;
}

#pragma mark - 导航栏处理
- (void)setUpNavTopView {
    _topToolView = [[KJCenterTopToolView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
    _topToolView.delegate = self;
    [self.view addSubview:_topToolView];
}

- (void)centerTopToolView:(KJCenterTopToolView *)topToolView buttonType:(TopToolBarButtonType)buttonType {
    switch (buttonType) {
        case TopToolBarButtonTypeScan:
            [self openScanVcWithStyle:[KJStyleDIY ZhiFuBaoStyle]];
            break;
        case TopToolBarButtonTypeSetting:
            [self openSettingVc];
            break;
        default:
            break;
    }
}

- (void)openSettingVc {
    SPSettingViewController *settingVc = [[SPSettingViewController alloc] init];
    WEAKSELF
    settingVc.settingVcBlock = ^{
        [weakSelf.headerView setData];
    };
    settingVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVc animated:YES];
}

- (void)openScanVcWithStyle:(LBXScanViewStyle *)style {
    self.scanVc.style = style;
    self.scanVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:self.scanVc animated:YES];
}

- (KJScanViewController *)scanVc {
    if (!_scanVc) {
        _scanVc = [[KJScanViewController alloc] init];
        _scanVc.isOpenInterestRect = YES;
        _scanVc.libraryType = SLT_Native;
        _scanVc.scanCodeType = SCT_QRCode;
    }
    return _scanVc;
}

#pragma mark - setUpData
- (void)setUpData {
    _serviceItem = [DCGridItem mj_objectArrayWithFilename:@"service.plist"];//MyServiceFlow.plist
    _tdServiceItem = [TDGridItem mj_objectArrayWithFilename:@"business.plist"];
}

#pragma mark - initialize
- (void)setUpBase {
    self.view.backgroundColor = KJBGColor;
    self.tableView.backgroundColor = self.view.backgroundColor;
    if (@available(ios 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cusCell = [UITableViewCell new];
    
    if (indexPath.section == 0) {
        DCCenterItemCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCenterItemCellID forIndexPath:indexPath];
        cell.delegate = self;
        cusCell = cell;
    } else if (indexPath.section == 1) {
        DCCenterServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCenterServiceCellID forIndexPath:indexPath];
        cell.serviceItemArray = [NSMutableArray arrayWithArray:_serviceItem];
        cell.delegate = self;
        cusCell = cell;
    } else if (indexPath.section == 2) {
        TDCenterServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:TDCenterServiceCellID forIndexPath:indexPath];
        cell.serviceItemArray = [NSMutableArray arrayWithArray:_tdServiceItem];
        cell.delegate = self;
        cusCell = cell;
    }
    
    return cusCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90;
    } else if (indexPath.section == 1) {
        return 130;
    } else if (indexPath.section == 2) {
        return 185;
    }
    return 0;
}

#pragma mark - TDCenterServiceCellDelegate
- (void)tdcenterServiceCell:(TDCenterServiceCell *)serviceCell didClickCollectionViewItem:(TDGridItem *)gridItem {
    switch (gridItem.serviceType) {
        case TDDaokuanService:  // 到款
            [self loadVc:@"KJDaoKuanViewController" title:@"到款查询"];
            break;
        default:
            break;
    }
}

- (void)loadVc:(NSString *)destVc title:(NSString *)title {
    UIViewController *vc = [[NSClassFromString(destVc) alloc] init];
    vc.title = title;
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - DCCenterServiceCellDelegate
- (void)centerServiceCell:(DCCenterServiceCell *)serviceCell didClickCollectionViewItem:(DCGridItem *)gridItem {
    switch (gridItem.serviceType) {
        case TaskProgress:  // 任务进度
            [self browseHTML:[H5URL stringByAppendingString:Progress]];
            break;
        case TejiaService:  // 特价
            [self browseHTML:[H5URL stringByAppendingString:Tejia]];
            break;
        case CuxiaoService: // 促销
            [self browseHTML:[H5URL stringByAppendingString:Cuxiao]];
            break;
        case FanliService:  // 返利
            [self browseHTML:[H5URL stringByAppendingString:Fanli]];
            break;
        default:
            break;
    }
}

#pragma mark - DCCenterItemCellDelegate
- (void)centerItemCell:(DCCenterItemCell *)itemCell didClickCollectionViewItem:(DCStateItem *)stateItem {
    switch (stateItem.orderType) {
        case OrderWaitSubmit:
            [self browseHTML:[H5URL stringByAppendingString:WaitSubmit]];
            break;
        case OrderWaitDelivery:
            [self browseHTML:[H5URL stringByAppendingString:WaitDelivery]];
            break;
        case OrderSdeliveryd:
            [self browseHTML:[H5URL stringByAppendingString:Sdeliveryd]];
            break;
        case OrderWaitSinvoince:
            [self browseHTML:[H5URL stringByAppendingString:WaitSinvoince]];
            break;
        case OrderAll:
            [self browseHTML:[H5URL stringByAppendingString:Order]];
            break;
        default:
            break;
    }
}

- (void)browseHTML:(NSString *)desUrl {
    KJBrowseViewController *browseVc = [[KJBrowseViewController alloc] initWithDesUrl:desUrl];
    browseVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:browseVc animated:YES];
}

#pragma mark -  滚动tableview 完毕之后
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _topToolView.hidden = (scrollView.contentOffset.y < 0) ? YES : NO;
    
    _topToolView.backgroundColor = (scrollView.contentOffset.y > 64) ? RGB(0, 0, 0) : [UIColor clearColor];
    
    //图片高度
    CGFloat imageHeight = self.headerView.dc_height;
    //图片宽度
    CGFloat imageWidth = ScreenW;
    //图片上下偏移量
    CGFloat imageOffsetY = scrollView.contentOffset.y;
    //上移
    if (imageOffsetY < 0) {
        CGFloat totalOffset = imageHeight + ABS(imageOffsetY);
        CGFloat f = totalOffset / imageHeight;
        self.headerBgImageView.frame = CGRectMake(-(imageWidth * f - imageWidth) * 0.5, imageOffsetY, imageWidth * f, totalOffset);
    }
}

#pragma mark - 屏幕横竖屏设置
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
