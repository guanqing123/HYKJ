//
//  SPScanResultViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/5/11.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "KJScanResultViewController.h"
#import "WebViewJavascriptBridge.h"

@interface KJScanResultViewController () <WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, weak) WKWebView  *webView;

@property (nonatomic, strong)  WebViewJavascriptBridge *bridge;

@end

@implementation KJScanResultViewController

- (instancetype)initWithUrlStr:(NSString *)urlStr {
    if (self = [super init]) {
        _urlStr = urlStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"扫码结果";
    WKWebView *webView = [[WKWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    _webView = webView;
    [self.view addSubview:webView];
    
    // JavascriptBridge
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    
    WEAKSELF
    [self.bridge registerHandler:@"openCamera" handler:^(id data, WVJBResponseCallback responseCallback) {
        [weakSelf pop];
    }];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
}

- (void)pop {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - navigationDelegate
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [SVProgressHUD dismiss];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [SVProgressHUD show];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [SVProgressHUD dismiss];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
