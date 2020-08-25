//
//  KJZuDanTableViewCell.h
//  HYKJ
//
//  Created by information on 2020/8/24.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJZuDan.h"
@class KJZuDanTableViewCell;

@protocol KJZuDanTableViewCellDelegate <NSObject>
@optional

/// 组单明细
/// @param tableViewCell tableView cell
- (void)zudanTableViewCellShowDetail:(KJZuDanTableViewCell * _Nonnull)tableViewCell;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KJZuDanTableViewCell : UITableViewCell

@property (nonatomic, strong)  KJZuDan *zudan;

@property (nonatomic, weak) id<KJZuDanTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
