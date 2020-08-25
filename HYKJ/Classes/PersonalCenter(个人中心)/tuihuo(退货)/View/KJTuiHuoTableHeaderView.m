//
//  KJTuiHuoTableHeaderView.m
//  HYKJ
//
//  Created by information on 2020/8/21.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJTuiHuoTableHeaderView.h"

@implementation KJTuiHuoTableHeaderView

+ (instancetype)headerView {
    return [[[NSBundle mainBundle] loadNibNamed:@"KJTuiHuoTableHeaderView" owner:nil options:nil] lastObject];
}

@end
