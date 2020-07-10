//
//  DCStateItem.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/13.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    OrderWaitSubmit,    // 待审核
    OrderWaitDelivery,  // 待收货
    OrderSdeliveryd,    // 已发货
    OrderWaitSinvoince, // 待开票
    OrderAll            // 全部订单
} OrderType;

@interface DCStateItem : NSObject

/* 显示文字图片 */
@property (nonatomic, assign) BOOL showImage;

/* 图片或数字 */
@property (nonatomic, copy) NSString *imageContent;

/* 标题 */
@property (nonatomic, copy) NSString *stateTitle;

/* 背景色 */
@property (nonatomic, assign) BOOL bgColor;

/** 订单类型 */
@property (nonatomic, assign) OrderType orderType;

@end
