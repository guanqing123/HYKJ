//
//  DCCenterServiceCell.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/13.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DCCenterServiceCell;
@class DCGridItem;

@protocol DCCenterServiceCellDelegate <NSObject>
@optional
/**
 点击服务Item
 */
- (void)centerServiceCell:(DCCenterServiceCell *)serviceCell didClickCollectionViewItem:(DCGridItem *)gridItem;

@end

@interface DCCenterServiceCell : UITableViewCell

/* 数据 */
@property (strong , nonatomic)NSMutableArray<DCGridItem *> *serviceItemArray;

@property (nonatomic, weak) id<DCCenterServiceCellDelegate>  delegate;

@end
