//
//  KJTuiHuoTableViewCell.h
//  HYKJ
//
//  Created by information on 2020/8/21.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJTuiHuoZD.h"
@class KJTuiHuoTableViewCell;

@protocol KJTuiHuoTableViewCellDelegate <NSObject>
@optional

/// 产品明细
/// @param tableViewCell tableView cell
- (void)tuihuoTableViewCellShowDetail:(KJTuiHuoTableViewCell * _Nonnull)tableViewCell;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KJTuiHuoTableViewCell : UITableViewCell

@property (nonatomic, strong)  KJTuiHuoZD *tuihuoZD;

@property (nonatomic, weak) id<KJTuiHuoTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
