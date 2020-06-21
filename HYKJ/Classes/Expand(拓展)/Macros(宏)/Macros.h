//
//  Macros.h
//  HYKJ
//
//  Created by information on 2020/6/17.
//  Copyright © 2020 hongyan. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

/** 屏幕高度 */
#define ScreenH [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define ScreenW [UIScreen mainScreen].bounds.size.width
/** 状态栏高度 */
#define KJStatusBarH [[UIApplication sharedApplication] statusBarFrame].size.height
/** 导航栏高度 */
#define KJNaviH 44.0
/** 顶部Nav高度+指示器 */
#define KJTopNavH (KJStatusBarH + KJNaviH)
/** 底部tab高度 */
#define KJBottomTabH (KJStatusBarH > 20 ? 83 : 49)
/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self;

/******************    TabBar          *************/
#define MallClassKey   @"rootVCClassString"
#define MallTitleKey   @"title"
#define MallImgKey     @"imageName"
#define MallSelImgKey  @"selectedImageName"
/*****************  屏幕适配  ******************/
#define iphone6p (ScreenH == 763)
#define iphone6 (ScreenH == 667)
#define iphone5 (ScreenH == 568)
#define iphone4 (ScreenH == 480)

#define KJHeadImagePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"headImage.png"]

//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//全局背景色
#define KJBGColor RGB(245,245,245)
#define KJColor RGB(46,208,183)

#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"

#define PFR20Font [UIFont fontWithName:PFR size:20];
#define PFR18Font [UIFont fontWithName:PFR size:18];
#define PFR16Font [UIFont fontWithName:PFR size:16];
#define PFR15Font [UIFont fontWithName:PFR size:15];
#define PFR14Font [UIFont fontWithName:PFR size:14];
#define PFR13Font [UIFont fontWithName:PFR size:13];
#define PFR12Font [UIFont fontWithName:PFR size:12];
#define PFR11Font [UIFont fontWithName:PFR size:11];
#define PFR10Font [UIFont fontWithName:PFR size:10];

//数组
#define GoodsRecommendArray  @[@"http://gfs8.gomein.net.cn/T1TkDvBK_j1RCvBVdK.jpg",@"http://gfs1.gomein.net.cn/T1loYvBCZj1RCvBVdK.jpg",@"http://gfs1.gomein.net.cn/T1w5bvB7K_1RCvBVdK.jpg",@"http://gfs1.gomein.net.cn/T1w5bvB7K_1RCvBVdK.jpg",@"http://gfs6.gomein.net.cn/T1L.VvBCxv1RCvBVdK.jpg",@"http://gfs9.gomein.net.cn/T1joLvBKhT1RCvBVdK.jpg",@"http://gfs5.gomein.net.cn/T1AoVvB7_v1RCvBVdK.jpg"];

#define GoodsHandheldImagesArray  @[@"http://gfs1.gomein.net.cn/T1koKvBT_g1RCvBVdK.jpg",@"http://gfs3.gomein.net.cn/T1n5JvB_Eb1RCvBVdK.jpg",@"http://gfs10.gomein.net.cn/T1jThTB_Ls1RCvBVdK.jpeg",@"http://gfs7.gomein.net.cn/T1T.YvBbbg1RCvBVdK.jpg",@"http://gfs6.gomein.net.cn/T1toCvBKKT1RCvBVdK.jpg",@"http://gfs5.gomein.net.cn/T1JZLvB4Jj1RCvBVdK.jpg",@"http://gfs5.gomein.net.cn/T1JZLvB4Jj1RCvBVdK.jpg",@"http://gfs3.gomein.net.cn/T1ckKvBTW_1RCvBVdK.jpg",@"http://gfs.gomein.net.cn/T1hNCvBjKT1RCvBVdK.jpg"]

//自定义Log
#ifdef DEBUG  // 调试阶段
#define GQLog(...) NSLog(__VA_ARGS__)
#else   //发布阶段
#define GQLog(...)
#endif

//鸿雁销客
#define XKURL @"http://218.75.78.166:9101/app/api"
//常见问题
#define HYXK00006 @"HYXK00006"
//鸿雁安家
#define SPURL @"http://www.sge.cn/erp/app/api"
//首页滚动条
#define slider @"HYXK00019"
//获取手机验证码
#define APP00000 @"APP00000"
//用户注册
#define APP00001 @"APP00001"
//密码修改
#define APP00003 @"APP00003"
//手机号码+手机验证码或密码；用户ID+token
#define APP00005 @"APP00005"
//每日签到
#define APP00007 @"APP00007"
//用户积分信息
#define APP00008 @"APP00008"

#endif /* Macros_h */
