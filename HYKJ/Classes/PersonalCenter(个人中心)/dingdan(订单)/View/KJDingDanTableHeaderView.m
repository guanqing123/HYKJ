//
//  KJDingDanTableHeaderView.m
//  HYKJ
//
//  Created by information on 2020/8/27.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJDingDanTableHeaderView.h"

@implementation KJDingDanTableHeaderView

+ (instancetype)headerView {
    return [[[NSBundle mainBundle] loadNibNamed:@"KJDingDanTableHeaderView" owner:nil options:nil] lastObject];
}

@end
