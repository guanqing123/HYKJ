//
//  KJNavigationController.m
//  HYKJ
//
//  Created by information on 2020/6/17.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJNavigationController.h"

@interface KJNavigationController ()

@end

@implementation KJNavigationController

#pragma mark - load初始化一次
+ (void)load {
    // 1.设置导航栏主题
    [self setupNavBarTheme];
    
    // 2.设置导航栏按钮主题
    [self setupBarButtonItemTheme];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 设置导航栏主题
 */
+ (void)setupNavBarTheme {
    //设置导航栏的通用的状态
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    //设置标题文字颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = RGB(49, 49, 49);
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [navBar setTitleTextAttributes:attrs];
    
    //设置回退箭头的颜色
    [navBar setTintColor:RGB(49, 49, 49)];
    
    //设置导航栏为透明
    [navBar setTranslucent:YES];
    //设置背景色
    [navBar setBarTintColor:RGB(245, 245, 245)];
}

/**
 设置导航栏按钮主题
 */
+ (void)setupBarButtonItemTheme {
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = RGB(49, 49, 49);
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] =  [UIColor lightGrayColor];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}

#pragma mark - <初始化>
+ (void)setUpBase {
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.barTintColor = KJBGColor;
    [bar setShadowImage:[UIImage new]];
    [bar setTintColor:[UIColor clearColor]];
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    // 设置导航栏字体颜色
    UIColor *naiColor = [UIColor blackColor];
    attributes[NSForegroundColorAttributeName] = naiColor;
    attributes[NSFontAttributeName] = PFR18Font;
    bar.titleTextAttributes = attributes;
}

#pragma mark - 屏幕横竖屏设置
- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

@end
