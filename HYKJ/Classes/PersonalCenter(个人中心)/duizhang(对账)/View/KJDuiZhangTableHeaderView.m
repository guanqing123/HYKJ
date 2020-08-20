//
//  KJDuiZhangTableHeaderView.m
//  HYKJ
//
//  Created by information on 2020/8/20.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJDuiZhangTableHeaderView.h"

@implementation KJDuiZhangTableHeaderView

+ (instancetype)headerView {
    return [[[NSBundle mainBundle] loadNibNamed:@"KJDuiZhangTableHeaderView" owner:nil options:nil] lastObject];
}

@end
