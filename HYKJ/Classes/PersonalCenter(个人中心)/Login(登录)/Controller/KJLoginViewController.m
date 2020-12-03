//
//  KJLoginViewController.m
//  HYKJ
//
//  Created by information on 2020/6/21.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJLoginViewController.h"
// views
#import "KJLoginHeaderView.h"
#import "KJLoginFooterView.h"
#import "KJPasswordLoginView.h"

// tool
#import "KJAccountTool.h"
#import "KJLoginTool.h"
#import "KJHYTool.h"

// 阿里push
#import <CloudPushSDK/CloudPushSDK.h>

@interface KJLoginViewController () <UIScrollViewDelegate,KJPasswordLoginViewDelegate>

@property (nonatomic, strong) KJLoginHeaderView  *headerView;
@property (nonatomic, strong) KJLoginFooterView  *footerView;
// 账号密码登录
@property (nonatomic, weak) KJPasswordLoginView  *passwordLoginView;

/*  middleView */
@property (nonatomic, strong)  UIView *middleView;
/* titleView */
@property (strong , nonatomic)UIView *titleView;
/* contentView */
@property (strong , nonatomic)UIScrollView *contentView;

@end

@implementation KJLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    // 1.设置头部View
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
    
    // 2.设置底部View
    [self.view addSubview:self.footerView];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
    
    // 3.设置中部View
    [self setupMiddleView];
}

#pragma mark - lazyLoad
- (KJLoginHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [KJLoginHeaderView headerView];
    }
    return _headerView;
}

- (KJLoginFooterView *)footerView {
    if (!_footerView) {
        _footerView = [KJLoginFooterView footerView];
    }
    return _footerView;
}

- (void)setupMiddleView {
    // 1.底部父view
    UIView *middleView = [[UIView alloc] init];
    _middleView = middleView;
    [self.view addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.footerView.mas_top);
        make.right.equalTo(self.view.mas_right);
    }];
    
    // 2.标题view
    UIView *titleView = [[UIView alloc] init];
    _titleView = titleView;
    [middleView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleView.mas_top).offset(30);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(35);
    }];
    
    // 3.登录title
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"账号密码登录";
    titleLabel.textColor = KJColor;
    titleLabel.font = PFR16Font;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView);
        make.left.equalTo(titleView);
        make.right.equalTo(titleView);
        make.bottom.equalTo(titleView);
    }];
    
    // 4.登录view
    self.contentView.contentSize = CGSizeMake(ScreenW, 0);
    [self setupContentView];
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.pagingEnabled = YES;
        _contentView.bounces = NO;
        _contentView.delegate = self;
    }
    return _contentView;
}

- (void)setupContentView {
    [self.middleView addSubview:self.contentView];
    WEAKSELF
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleView.mas_bottom);
        make.left.equalTo(weakSelf.middleView);
        make.bottom.equalTo(weakSelf.middleView);
        make.right.equalTo(weakSelf.middleView);
    }];
    
    /** 密码登录 */
    KJPasswordLoginView *passwordLoginView = [KJPasswordLoginView passwordView];
    passwordLoginView.delegate = self;
    _passwordLoginView = passwordLoginView;
    [self.contentView addSubview:passwordLoginView];
    
    [passwordLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top).offset(0);
        make.left.equalTo(weakSelf.contentView.mas_left).offset(0);
        make.height.mas_equalTo(weakSelf.contentView);
        make.width.mas_equalTo(ScreenW);
    }];
}

#pragma mark - KJPasswordLoginViewDelegate
- (void)passwordLoginViewDidLogin:(KJPasswordLoginView *)loginView {
    [SVProgressHUD show];
    WEAKSELF
    [KJLoginTool loginWithAccountAndPassword:loginView.loginParam success:^(KJLoginResult * _Nonnull loginResult) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        // 1.存储模型数据
        [KJAccountTool saveLoginResult:loginResult];
        
        // 2.新特性\去首页
        [KJHYTool chooseRootController];
        
        // 3.获取产业
        [weakSelf getFcy];
        
        // 4.推送绑定账号
        [CloudPushSDK bindAccount:[KJAccountTool getUserCode] withCallback:^(CloudPushCallbackResult *res) {
            if (res.success) {
                NSLog(@"账号%@绑定成功", [KJAccountTool getUserCode]);
            } else {
                NSLog(@"账号绑定 error=%@", res.error);
            }
        }];
        
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"账号或密码错误"];
    }];
}

- (void)getFcy {
    [KJLoginTool getFcysuccess:^(NSArray * _Nonnull cys) {
        NSMutableArray *dms = [NSMutableArray array];
        NSMutableArray *mcs = [NSMutableArray array];
        for (KJCyResult *result in cys) {
            [dms addObject:result.CYDM];
            [mcs addObject:result.CYMC];
        }
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:dms forKey:cydm];
        [defaults setObject:mcs forKey:cymc];
        [defaults synchronize];
    } failure:^(NSError * _Nonnull error) {}];
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
