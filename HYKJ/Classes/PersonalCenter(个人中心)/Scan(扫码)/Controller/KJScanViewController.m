//
//  SPBindBossViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/5/11.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "KJScanViewController.h"
#import "KJScanResultViewController.h"
#import "LBXAlertAction.h"
#import <AudioToolbox/AudioToolbox.h>

#import "KJAccountTool.h"


@interface KJScanViewController ()

@end

@implementation KJScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"二维码扫描";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define SOUNDID  1109  //1012 -iphone   1152 ipad  1109 ipad
#pragma mark - 实现类继承该方法，作出对应处理
- (void)scanResultWithArray:(NSArray<LBXScanResult *>*)array {
    if (!array || array.count < 1) {
        [self popAlertMsgWithScanResult:nil];
        return;
    }
    
    LBXScanResult *scanResult = array[0];
    
    NSString *resultStr = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!resultStr) {
        [self popAlertMsgWithScanResult:nil];
        return;
    }
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    AudioServicesPlaySystemSound(SOUNDID);
    
    [self showNextVCWithScanResult:resultStr];
}

- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    if (!strResult) {
        
        strResult = @"识别失败";
    }
    
    __weak __typeof(self) weakSelf = self;
    [LBXAlertAction showAlertWithTitle:@"扫码内容" msg:strResult buttonsStatement:@[@"知道了"] chooseBlock:^(NSInteger buttonIdx) {
        
        [weakSelf reStartDevice];
    }];
}

- (void)showNextVCWithScanResult:(NSString *)resultStr{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?token=%@",resultStr,[KJAccountTool loginResult]];

    KJScanResultViewController *scanResultVc = [[KJScanResultViewController alloc] initWithUrlStr:urlStr];

    [self.navigationController pushViewController:scanResultVc animated:YES];
}

@end
