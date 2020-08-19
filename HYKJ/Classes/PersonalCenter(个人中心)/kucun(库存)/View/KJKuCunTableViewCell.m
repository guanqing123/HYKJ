//
//  KJKuCunTableViewCell.m
//  HYKJ
//
//  Created by information on 2020/8/19.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJKuCunTableViewCell.h"
#import "KJLongTextScrollView.h"

@interface KJKuCunTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *cpdmLabel;

@property (weak, nonatomic) IBOutlet UILabel *cpxhLabel;
@property (nonatomic, strong)  KJLongTextScrollView *cpxhView;

@property (weak, nonatomic) IBOutlet UILabel *kcsLabel;

@property (weak, nonatomic) IBOutlet UILabel *cpmcLabel;
@property (nonatomic, strong)  KJLongTextScrollView *cpmcView;

@property (weak, nonatomic) IBOutlet UILabel *ccjLabel;
@property (weak, nonatomic) IBOutlet UILabel *kcdwLabel;
@property (weak, nonatomic) IBOutlet UILabel *kwmcLabel;

@end

@implementation KJKuCunTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _cpxhView = [[KJLongTextScrollView alloc] initWithFrame:CGRectMake(100, 0, 150, 30)];
    [self.contentView addSubview:_cpxhView];
    
    _cpmcView = [[KJLongTextScrollView alloc] initWithFrame:CGRectMake(310, 0, 200, 30)];
    [self.contentView addSubview:_cpmcView];
}

- (void)setKucun:(KJKuCun *)kucun {
    _kucun = kucun;
    
    self.cpdmLabel.text = kucun.cpdm;
    
    self.cpxhView.longText = kucun.cpxh;
    
    self.kcsLabel.text = kucun.kcs;
    
    self.cpmcView.longText = kucun.cpmc;
    
    self.ccjLabel.text = kucun.ccj;
    
    self.kcdwLabel.text = kucun.kcdw;
    
    self.kwmcLabel.text = kucun.kwmc;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
