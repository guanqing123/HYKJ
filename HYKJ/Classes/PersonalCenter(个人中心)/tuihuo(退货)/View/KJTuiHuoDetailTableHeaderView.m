//
//  KJTuiHuoDetailTableHeaderView.m
//  HYKJ
//
//  Created by information on 2020/8/24.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJTuiHuoDetailTableHeaderView.h"

@implementation KJTuiHuoDetailTableHeaderView

+ (instancetype)headerView {
    return [[[NSBundle mainBundle] loadNibNamed:@"KJTuiHuoDetailTableHeaderView" owner:nil options:nil] lastObject];
}

@end
