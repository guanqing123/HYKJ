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

@property (weak, nonatomic) IBOutlet UILabel *khdmLabel;
@property (weak, nonatomic) IBOutlet UILabel *khmcLabel;
@property (weak, nonatomic) IBOutlet UILabel *dkdhLabel;
@property (weak, nonatomic) IBOutlet UILabel *dkddLabel;
@property (weak, nonatomic) IBOutlet UILabel *hzddLabel;
@property (weak, nonatomic) IBOutlet UILabel *zjrqLabel;
@property (weak, nonatomic) IBOutlet UILabel *jeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ztLabel;
@property (weak, nonatomic) IBOutlet UILabel *syhbLabel;
@property (weak, nonatomic) IBOutlet UILabel *syhbbmLabel;


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

- (void)setDaokuan:(KJDaokuan *)daokuan {
    _daokuan = daokuan;
    
    self.khdmLabel.text = daokuan.khdm;
    
    self.longTextView.longText = daokuan.khmc;
    
    self.dkdhLabel.text = daokuan.dkdh;
    
    self.dkddLabel.text = daokuan.dkdd;
    
    self.hzddLabel.text = daokuan.hzdd;
    
    self.zjrqLabel.text = daokuan.jzrq;
    
    self.jeLabel.text = daokuan.je;
    
    self.ztLabel.text = daokuan.zt;
    
    self.syhbLabel.text = daokuan.ywy;
    
    self.syhbbmLabel.text = daokuan.bm;
}

@end
