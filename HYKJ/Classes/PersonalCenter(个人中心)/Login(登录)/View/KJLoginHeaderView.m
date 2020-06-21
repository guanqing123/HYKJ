//
//  KJLoginHeaderView.m
//  HYKJ
//
//  Created by information on 2020/6/21.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJLoginHeaderView.h"

@interface KJLoginHeaderView()
@property (nonatomic, weak) UIImageView  *titleView;
@end

@implementation KJLoginHeaderView

+ (instancetype)headerView {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *titleView = [[UIImageView alloc] init];
        titleView.image = [UIImage imageNamed:@"sign_in_logo"];
        _titleView = titleView;
        [self addSubview:titleView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

@end
