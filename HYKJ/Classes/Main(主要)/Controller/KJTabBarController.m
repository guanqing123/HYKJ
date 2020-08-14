//
//  KJTabBarController.m
//  HYKJ
//
//  Created by information on 2020/6/17.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJTabBarController.h"
#import "KJNavigationController.h"

@interface KJTabBarController ()

@end

@implementation KJTabBarController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 0.设置底部工具栏
    [self setUpTabBar];
    
    // 1.添加子控制器
    [self addKJChildViewController];
    
    // 2.默认选中第二个
    self.selectedIndex = 0;
}

// 0.设置底部工具栏
- (void)setUpTabBar {
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB(168, 168, 168),NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB(0, 157, 133),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}

// 1.添加子控制器
- (void)addKJChildViewController {
    NSArray *childArray = @[
                            @{MallClassKey  : @"KJIndexViewController",
                              MallTitleKey  : @"商城",
                              MallImgKey    : @"tabr_1_up",
                              MallSelImgKey : @"tabr_1_down"},
                            
                            @{MallClassKey  : @"KJCategroyViewController",
                              MallTitleKey  : @"分类",
                              MallImgKey    : @"tabr_2_up",
                              MallSelImgKey : @"tabr_2_down"},
                            
                            @{MallClassKey  : @"KJCartViewController",
                              MallTitleKey  : @"购物车",
                              MallImgKey    : @"tabr_3_up",
                              MallSelImgKey : @"tabr_3_down"},
                            
                            
                            @{MallClassKey  : @"KJMeViewController",
                              MallTitleKey  : @"我的",
                              MallImgKey    : @"tabr_4_up",
                              MallSelImgKey : @"tabr_4_down"}
                            ];
    [childArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = [NSClassFromString(dict[MallClassKey]) new];
        vc.navigationItem.title = dict[MallTitleKey];
        
        KJNavigationController *nav = [[KJNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        
        item.title = dict[MallTitleKey];
        item.image = [UIImage imageNamed:dict[MallImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[MallSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self addChildViewController:nav];
    }];
}

#pragma mark -屏幕旋转设置
- (BOOL)shouldAutorotate {
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}

@end
