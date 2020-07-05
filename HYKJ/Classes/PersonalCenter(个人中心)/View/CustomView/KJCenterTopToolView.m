//
//  KJCenterTopToolView.m
//  HYSmartPlus
//
//  Created by information on 2018/3/9.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "KJCenterTopToolView.h"

@interface KJCenterTopToolView()

/* 左边Item */
@property (strong , nonatomic)UIButton *leftItemButton;
/* 右边Item */
@property (strong , nonatomic)UIButton *rightItemButton;

@end

@implementation KJCenterTopToolView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor clearColor];
    
    _leftItemButton = ({
        UIButton * button = [UIButton new];
        button.tag = 0;
        [button setImage:[UIImage imageNamed:@"group_home_scan"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    _rightItemButton = ({
        UIButton * button = [UIButton new];
        button.tag = 1;
        [button setImage:[UIImage imageNamed:@"mine_whitesetting"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self addSubview:_rightItemButton];
    [self addSubview:_leftItemButton];
}

- (void)buttonClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(centerTopToolView:buttonType:)]) {
        [self.delegate centerTopToolView:self buttonType:(int)button.tag];
    }
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_leftItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.left.equalTo(self.mas_left).offset(0);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
    
    [_rightItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftItemButton.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-0);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
    
}

@end
