//
//  KJIndexViewController.m
//  HYKJ
//
//  Created by information on 2020/6/27.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJIndexViewController.h"

// webview/js bridge
#import <WebKit/WebKit.h>
#import "WebViewJavascriptBridge.h"

// tool
#import "KJAccountTool.h"
#import "KJHYTool.h"

@interface KJIndexViewController () <WKUIDelegate, WKNavigationDelegate>
// webView
@property (nonatomic, weak) WKWebView  *webView;
/** UI */
@property (nonatomic, strong) UIProgressView *myProgressView;
// js bridge
@property (nonatomic, strong)  WebViewJavascriptBridge *bridge;
@end

@implementation KJIndexViewController

#pragma mark - lifeCicle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1.background & Nav
    [self setupView];
    
    // 2.webView
    [self setWebView];
}

#pragma mark - init
- (void)setupView {
    // 1.背景色
    self.view.backgroundColor = [UIColor whiteColor];
    // 3.右
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refresh"] style:UIBarButtonItemStyleDone target:self action:@selector(refresh)];
}

- (void)refresh {
    [self.webView reload];
}

#pragma mark - webView
- (void)setWebView {
    WKWebView *webView = [[WKWebView alloc] init];
    webView.frame = CGRectMake(0, KJTopNavH, ScreenW, ScreenH - KJTopNavH - KJBottomTabH);
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    _webView = webView;
                            //http://dev.sge.cn/hykj/ghome/ghome.html
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://dev.sge.cn/hykj/ghome/ghome.html"]]];
    [self.view addSubview:webView];
    [self.view addSubview:self.myProgressView];
    
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    [_bridge setWebViewDelegate:self];
    
    if (@available(iOS 11.0, *)){
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // 1.获取token
    [_bridge registerHandler:@"getToken" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *token = [KJAccountTool getToken];
        if (!token) {
            [KJHYTool showAlertVc];
        }else{
            responseCallback(token);
        }
    }];
    
    // 2.token 过期
    [_bridge registerHandler:@"goLogin" handler:^(id data, WVJBResponseCallback responseCallback) {
        [KJHYTool showAlertVc];
    }];
    
    // 3.refresh cart
    [_bridge registerHandler:@"refreshCart" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"refreshCart" forKey:refreshCart];
    }];
}

#pragma mark - alertView
- (void)createAlert {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提醒" message:@"token无效,请重新登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [KJHYTool clearTokenGoToLoginVc];
    }];
    [alertVc addAction:sureAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}

#pragma mark - getter and setter
- (UIProgressView *)myProgressView
{
//    https://www.jianshu.com/p/a727b945e9a8
    if (_myProgressView == nil) {
        _myProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, KJTopNavH, ScreenW, 0)];
        _myProgressView.tintColor = KJColor;
        _myProgressView.trackTintColor = [UIColor whiteColor];
    }
    return _myProgressView;
}

#pragma mark - event response
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.myProgressView.alpha = 1.0f;
        [self.myProgressView setProgress:newprogress animated:YES];
        if (newprogress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.myProgressView.alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                                 [self.myProgressView setProgress:0 animated:NO];
                             }];
        }
    } else if (object == self.webView && [keyPath isEqualToString:@"title"]){
        self.title = self.webView.title;
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark 移除观察者
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

#pragma mark - delegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if ([webView canGoBack]) {
        if (!self.navigationItem.leftBarButtonItem) {
            [self setupNavItem];
        }
        self.tabBarController.tabBar.hidden = YES;
        self.webView.frame = CGRectMake(0, KJTopNavH, ScreenW, ScreenH - KJTopNavH);
    }else{
        if (self.navigationItem.leftBarButtonItem) {
            self.navigationItem.leftBarButtonItem = nil;
        }
        self.tabBarController.tabBar.hidden = NO;
        self.webView.frame = CGRectMake(0, KJTopNavH, ScreenW, ScreenH - KJTopNavH - KJBottomTabH);
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    if ([webView canGoBack]) {
        if (!self.navigationItem.leftBarButtonItem) {
            [self setupNavItem];
        }
        self.tabBarController.tabBar.hidden = YES;
    }else{
        if (self.navigationItem.leftBarButtonItem) {
            self.navigationItem.leftBarButtonItem = nil;
        }
        self.tabBarController.tabBar.hidden = NO;
    }
}

- (void)setupNavItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"30"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
}

- (void)back {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
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
