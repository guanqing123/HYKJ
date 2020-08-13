//
//  KJDaoKuanTableViewCell.m
//  HYKJ
//
//  Created by information on 2020/8/13.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJDaoKuanTableViewCell.h"
#import "KJLongTextScrollView.h"

@interface KJDaoKuanTableViewCell()

@property (nonatomic, strong) KJLongTextScrollView  *longTextView;

@end

@implementation KJDaoKuanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _longTextView = [[KJLongTextScrollView alloc] initWithFrame:CGRectMake(80, 0, 120, 30.0f)];
    [self.contentView addSubview:_longTextView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
