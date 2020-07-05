//
//  SPSettingViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/5/11.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPSettingViewController.h"

#import "TZImagePickerController.h"

//#import "SPInviteFriendViewController.h"
#import "SPAboutMeViewController.h"

#import "SPSettingTopView.h"
#import "SPSettingTableViewCell.h"

#import "SPSpeedy.h"
#import "KJAccountTool.h"
#import "KJHYTool.h"

#import "KJNavigationController.h"
#import "KJLoginViewController.h"

@interface SPSettingViewController () <UITableViewDataSource,UITableViewDelegate,SPSettingTopViewDelegate,TZImagePickerControllerDelegate>

/** tableView */
@property (nonatomic, strong)  UITableView *tableView;

/** 头部View */
@property (nonatomic, strong)  SPSettingTopView *topView;

/** 数组 */
@property (nonatomic, strong)  NSArray *dataArray;

@end

static NSString *const SPSettingTableViewCellID = @"SPSettingTableViewCellID";

@implementation SPSettingViewController

#pragma mark - LazyLoad
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, KJTopNavH, ScreenW, ScreenH - KJTopNavH);
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SPSettingTableViewCell class]) bundle:nil] forCellReuseIdentifier:SPSettingTableViewCellID];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpBase];
    
    [self setUpHeaderView];
    
    [self setUpFooterView];
}

#pragma mark - initialize
- (void)setUpBase {
    self.view.backgroundColor = KJBGColor;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.title = @"设置中心";
    self.dataArray = @[@"关于我们"];
}

#pragma mark - 头部View
- (void)setUpHeaderView {
    SPSettingTopView *topView = [SPSettingTopView topView];
    topView.bounds = (CGRect){CGPointZero,CGSizeMake(ScreenW, 190)};
    topView.delegate = self;
    [topView setData];
    _topView = topView;
    self.tableView.tableHeaderView = topView;
    WEAKSELF
    topView.headerViewBlock = ^{
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
    };
}

#pragma mark -TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    if (photos.count > 0) {
        BOOL result = [UIImagePNGRepresentation([photos objectAtIndex:0]) writeToFile:KJHeadImagePath atomically:YES];
        if (result == YES) {
            [self.topView setData];
            
            !_settingVcBlock ? : _settingVcBlock();
        }
    }
}

#pragma mark - 刷新头部
- (void)refreshHeaderView {
    [self.topView setData];
    !_settingVcBlock ? : _settingVcBlock();
}

#pragma mark - SPSettingTopViewDelegate
- (void)topView:(SPSettingTopView *)topView buttonType:(SettingTopViewButtonType)buttonType {
    switch (buttonType) {
        case SettingTopViewButtonTypeWx:
            [self wx];
            break;
        case SettingTopViewButtonTypeSdg:
            [self sdg];
            break;
        default:
            break;
    }
}

- (void)wx {
//    SPDiscountViewController *discountVc = [[SPDiscountViewController alloc] init];
//    discountVc.title = @"微信公众号";
//    [self.navigationController pushViewController:discountVc animated:YES];
}

- (void)sdg {
//    SPInviteFriendViewController *inviteFriendVc = [[SPInviteFriendViewController alloc] init];
//    inviteFriendVc.title = @"邀请水电工";
//    [self.navigationController pushViewController:inviteFriendVc animated:YES];
}

#pragma mark - 退出登录
- (void)setUpFooterView {
    UIView *footerView = [UIView new];
    
    UIButton *loginOffButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginOffButton setTitle:@"退出登录" forState:0];
    loginOffButton.backgroundColor = RGB(0, 157, 133);
    loginOffButton.frame = CGRectMake(15, 35, ScreenW - 30, 45);
    [loginOffButton addTarget:self action:@selector(loginOffClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:loginOffButton];
    [SPSpeedy dc_setUpBezierPathCircularLayerWith:loginOffButton size:CGSizeMake(KJMargin, KJMargin)];
    footerView.dc_height = 80;
    self.tableView.tableFooterView = footerView;
}

#pragma mark - loginOffClick
- (void)loginOffClick {
    
    //alertVc
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"温馨提醒" message:@"是否确定退出登录" preferredStyle:UIAlertControllerStyleActionSheet];
    
    //取消
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    //确定
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [KJHYTool clearTokenGoToLoginVc];
    }];
    
    [alertVc addAction:sureAction];
    [alertVc addAction:cancelAction];
    
    [self presentViewController:alertVc animated:YES completion:nil];
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPSettingTableViewCell *settingCell = [tableView dequeueReusableCellWithIdentifier:SPSettingTableViewCellID];
    
    settingCell.titleLabel.text = self.dataArray[indexPath.row];
    
    return settingCell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        SPAboutMeViewController *aboutMe = [[SPAboutMeViewController alloc] init];
        [self.navigationController pushViewController:aboutMe animated:YES];
    }
}

@end
