//
//  DCGridItem.h
//  CDDMall
//
//  Created by apple on 2017/6/6.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TaskProgress = 0,  // 任务进度
    TejiaService = 1,  // 特价
    CuxiaoService = 2, // 促销
    FanliService = 3  // 返利
} ServiceType;

@interface DCGridItem : NSObject

/** 图片  */
@property (nonatomic, copy ,readonly) NSString *iconImage;
/** 文字  */
@property (nonatomic, copy ,readonly) NSString *gridTitle;
/** tag  */
@property (nonatomic, copy ,readonly) NSString *gridTag;
/** tag颜色  */
@property (nonatomic, copy ,readonly) NSString *gridColor;
/** 服务类型 */
@property (nonatomic, assign) ServiceType serviceType;

@end
