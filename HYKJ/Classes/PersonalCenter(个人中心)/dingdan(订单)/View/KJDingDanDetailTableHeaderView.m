//
//  KJDingDanDetailTableHeaderView.m
//  HYKJ
//
//  Created by information on 2020/8/28.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJDingDanDetailTableHeaderView.h"

@implementation KJDingDanDetailTableHeaderView

+ (instancetype)headerView {
    return [[[NSBundle mainBundle] loadNibNamed:@"KJDingDanDetailTableHeaderView" owner:nil options:nil] lastObject];
}

@end
