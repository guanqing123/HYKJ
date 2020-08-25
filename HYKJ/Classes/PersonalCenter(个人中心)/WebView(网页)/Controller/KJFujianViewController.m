//
//  KJFujianViewController.m
//  HYKJ
//
//  Created by information on 2020/8/25.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJFujianViewController.h"

@interface KJFujianViewController () <WKUIDelegate, WKNavigationDelegate>
@property (nonatomic, strong)  WKWebView *webView;
@property (nonatomic, strong)  NSURLRequest *request;

/** UI */
@property (nonatomic, strong) UIProgressView *myProgressView;

@property (nonatomic, strong)  WKWebViewConfiguration *configure;
@end

@implementation KJFujianViewController

- (instancetype)initWithRequest:(NSURLRequest *)request Configuration:(WKWebViewConfiguration *)configuration {
    if (self = [super init]) {
        _request = request;
        _configure = configuration;
        self.title = @"协议书";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem  *left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = left;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:_configure];
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [_webView loadRequest:_request];
    [self.view addSubview:_webView];

    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:self.myProgressView];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([navigationAction.request.URL.absoluteString containsString:@"/common/download-client-agreement"]) {
        NSData *data = [NSData dataWithContentsOfURL:navigationAction.request.URL];
        [self.webView loadData:data MIMEType:@"application/pdf" characterEncodingName:@"GBK" baseURL:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)cancel {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
