//
//  KJZuDanTableViewCell.m
//  HYKJ
//
//  Created by information on 2020/8/24.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJZuDanTableViewCell.h"

@interface KJZuDanTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *zddhLabel;
@property (weak, nonatomic) IBOutlet UILabel *zdrqLabel;
@property (weak, nonatomic) IBOutlet UILabel *khmcLabel;
@property (weak, nonatomic) IBOutlet UILabel *ydlxLabel;
@property (weak, nonatomic) IBOutlet UILabel *ztjLabel;
@property (weak, nonatomic) IBOutlet UILabel *addLabel;
@property (weak, nonatomic) IBOutlet UILabel *zjsLabel;
@property (weak, nonatomic) IBOutlet UILabel *khdhLabel;

@end

@implementation KJZuDanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setZudan:(KJZuDan *)zudan {
    _zudan = zudan;
    
    self.zddhLabel.text = zudan.zddh;
    self.zdrqLabel.text = zudan.zdrq;
    self.khmcLabel.text = zudan.khmc;
    self.ydlxLabel.text = zudan.ydlx;
    self.ztjLabel.text = zudan.ztj;
    self.addLabel.text = zudan.add;
    self.zjsLabel.text = zudan.zjs;
    self.khdhLabel.text = zudan.kddh;
}

@end
