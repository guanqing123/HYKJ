//
//  KJZuDanTableHeaderView.m
//  HYKJ
//
//  Created by information on 2020/8/24.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJZuDanTableHeaderView.h"

@implementation KJZuDanTableHeaderView

+ (instancetype)headerView {
    return [[[NSBundle mainBundle] loadNibNamed:@"KJZuDanTableHeaderView" owner:nil options:nil] lastObject];
}
@end
