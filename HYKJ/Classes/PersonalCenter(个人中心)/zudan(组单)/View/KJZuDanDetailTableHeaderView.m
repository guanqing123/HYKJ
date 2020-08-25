//
//  KJZuDanDetailTableHeaderView.m
//  HYKJ
//
//  Created by information on 2020/8/25.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJZuDanDetailTableHeaderView.h"

@implementation KJZuDanDetailTableHeaderView

+ (instancetype)headerView {
    return [[[NSBundle mainBundle] loadNibNamed:@"KJZuDanDetailTableHeaderView" owner:nil options:nil] lastObject];
}

@end
