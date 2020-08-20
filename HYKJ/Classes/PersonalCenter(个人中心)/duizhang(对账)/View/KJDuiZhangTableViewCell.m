//
//  KJDuiZhangTableViewCell.m
//  HYKJ
//
//  Created by information on 2020/8/20.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJDuiZhangTableViewCell.h"

@interface KJDuiZhangTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *fcyLabel;
@property (weak, nonatomic) IBOutlet UILabel *kpkhLabel;
@property (weak, nonatomic) IBOutlet UILabel *kpmcLabel;
@property (weak, nonatomic) IBOutlet UILabel *balamtLabel;
@property (weak, nonatomic) IBOutlet UILabel *sinamtLabel;
@property (weak, nonatomic) IBOutlet UILabel *retamtLabel;
@property (weak, nonatomic) IBOutlet UILabel *recamtLabel;
@property (weak, nonatomic) IBOutlet UILabel *devamtLabel;
@property (weak, nonatomic) IBOutlet UILabel *amtLabel;
@property (weak, nonatomic) IBOutlet UILabel *ntaxamtLabel;
@property (weak, nonatomic) IBOutlet UILabel *taxamtLabel;
@property (weak, nonatomic) IBOutlet UILabel *zwostauzLabel;
@property (weak, nonatomic) IBOutlet UILabel *cwshLabel;


@end

@implementation KJDuiZhangTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDuizhang:(KJDuiZhang *)duizhang {
    _duizhang = duizhang;
    
    self.fcyLabel.text = duizhang.fcy;
    self.kpkhLabel.text = duizhang.kpkh;
    self.kpmcLabel.text = duizhang.kpmc;
    self.balamtLabel.text = duizhang.balamt;
    self.sinamtLabel.text = duizhang.sinamt;
    self.retamtLabel.text = duizhang.retamt;
    self.recamtLabel.text = duizhang.recamt;
    self.devamtLabel.text = duizhang.devamt;
    self.amtLabel.text = duizhang.amt;
    self.ntaxamtLabel.text = duizhang.ntaxamt;
    self.taxamtLabel.text = duizhang.taxamt;
    self.zwostauzLabel.text = duizhang.zwostauz;
    self.cwshLabel.text = duizhang.cwsh;
}

@end
