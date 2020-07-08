//
//  DCCenterItemCell.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/12.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
// Models
#import "DCStateItem.h"
@class DCCenterItemCell;

@protocol DCCenterItemCellDelegate <NSObject>
@optional
/**
 点击订单服务Item
 */
- (void)centerItemCell:(DCCenterItemCell *)itemCell didClickCollectionViewItem:(DCStateItem *)stateItem;

@end

@interface DCCenterItemCell : UITableViewCell

@property (nonatomic, weak) id<DCCenterItemCellDelegate>  delegate;

@end
