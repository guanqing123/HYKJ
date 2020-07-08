//
//  KJBrowseViewController.h
//  HYKJ
//
//  Created by information on 2020/7/8.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJBrowseViewController : UIViewController

/**
 根据目标地址请求资源
 */
- (instancetype)initWithDesUrl:(NSString *)desUrl;

@end

NS_ASSUME_NONNULL_END
