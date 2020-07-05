//
//  SPAboutMeViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/5/14.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPAboutMeViewController.h"
#import "SPUpDownButton.h"

@interface SPAboutMeViewController ()
@property (weak, nonatomic) IBOutlet SPUpDownButton *headImage;

@end

@implementation SPAboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"关于我们";
    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [dict objectForKey:@"CFBundleShortVersionString"];
    [self.headImage setTitle:[NSString stringWithFormat:@"版本号 %@",version] forState:UIControlStateNormal];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect tempRect = self.headImage.frame;
    tempRect.origin.y += KJTopNavH;
    self.headImage.frame = tempRect;
}

@end
