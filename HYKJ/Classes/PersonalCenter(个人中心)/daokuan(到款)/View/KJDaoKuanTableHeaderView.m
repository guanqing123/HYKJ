//
//  KJDaoKuanTableHeaderView.m
//  HYKJ
//
//  Created by information on 2020/8/14.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJDaoKuanTableHeaderView.h"

@implementation KJDaoKuanTableHeaderView

+ (instancetype)headerView {
    return [[[NSBundle mainBundle] loadNibNamed:@"KJDaoKuanTableHeaderView" owner:nil options:nil] lastObject];
}

@end
