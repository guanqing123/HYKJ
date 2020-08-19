//
//  KJKuCunTableHeaderView.m
//  HYKJ
//
//  Created by information on 2020/8/18.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJKuCunTableHeaderView.h"

@implementation KJKuCunTableHeaderView

+ (instancetype)headerView {
    return [[[NSBundle mainBundle] loadNibNamed:@"KJKuCunTableHeaderView" owner:nil options:nil] lastObject];
}

@end
