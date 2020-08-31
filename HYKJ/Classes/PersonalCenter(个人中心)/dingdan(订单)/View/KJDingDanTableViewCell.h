//
//  KJDingDanTableViewCell.h
//  HYKJ
//
//  Created by information on 2020/8/28.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJDingDan.h"
@class KJDingDanTableViewCell;

@protocol KJDingDanTableViewCellDelegate <NSObject>
@optional

/// 组单明细
/// @param tableViewCell tableView cell
- (void)dingdanTableViewCellShowDetail:(KJDingDanTableViewCell * _Nonnull)tableViewCell;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KJDingDanTableViewCell : UITableViewCell

@property (nonatomic, strong)  KJDingDan *dingdan;

@property (nonatomic, weak) id<KJDingDanTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
