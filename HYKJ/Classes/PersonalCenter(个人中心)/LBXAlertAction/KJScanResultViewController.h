//
//  SPScanResultViewController.h
//  HYSmartPlus
//
//  Created by information on 2018/5/11.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KJScanResultViewController : UIViewController

- (instancetype)initWithUrlStr:(NSString *)urlStr;

@property (nonatomic, copy) NSString *urlStr;

@end
