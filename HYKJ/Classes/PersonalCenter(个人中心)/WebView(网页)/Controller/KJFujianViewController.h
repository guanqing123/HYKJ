//
//  KJFujianViewController.h
//  HYKJ
//
//  Created by information on 2020/8/25.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJFujianViewController : UIViewController

- (instancetype)initWithRequest:(NSURLRequest *)request Configuration:(WKWebViewConfiguration *)configuration;

@end

NS_ASSUME_NONNULL_END
