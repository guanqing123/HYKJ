//
//  KJLoginFooterView.m
//  HYKJ
//
//  Created by information on 2020/6/21.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJLoginFooterView.h"

@interface KJLoginFooterView()
@property (nonatomic, strong)  UIView *splitLine;
@property (nonatomic, strong)  UILabel *titleLabel;
@property (nonatomic, strong)  UIView *leftLine;
@property (nonatomic, strong)  UIView *rightLine;
@end

@implementation KJLoginFooterView

+ (instancetype)footerView {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 1.split line
        [self addSubview:self.splitLine];
        
        // 2.titleLabel
        [self addSubview:self.titleLabel];
        
        // 3.leftLine
        [self addSubview:self.leftLine];
        
        // 4.rightLine
        [self addSubview:self.rightLine];
    }
    return self;
}

#pragma mark - lazyLoad
- (UIView *)splitLine {
    if (!_splitLine) {
        _splitLine = [[UIView alloc] init];
        _splitLine.backgroundColor = RGB(177, 177, 177);
    }
    return _splitLine;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"鸿雁客家";
        _titleLabel.font = PFR10Font;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = RGB(177, 177, 177);
    }
    return _titleLabel;
}

- (UIView *)leftLine {
    if (!_leftLine) {
        _leftLine = [[UIView alloc] init];
        _leftLine.backgroundColor = RGB(223, 223, 223);
    }
    return _leftLine;
}

- (UIView *)rightLine {
    if (!_rightLine) {
        _rightLine = [[UIView alloc] init];
        _rightLine.backgroundColor = RGB(223, 223, 223);
    }
    return _rightLine;
}

#pragma mark - layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.splitLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-40);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(1);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    
    [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.titleLabel.mas_left).offset(-20);
        make.height.mas_equalTo(1);
    }];
    
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(20);
        make.right.mas_equalTo(self).offset(-20);
        make.height.mas_equalTo(1);
    }];
}

@end
