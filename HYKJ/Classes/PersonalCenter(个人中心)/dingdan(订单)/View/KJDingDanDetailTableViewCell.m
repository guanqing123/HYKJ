//
//  KJDingDanDetailTableViewCell.m
//  HYKJ
//
//  Created by information on 2020/8/28.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJDingDanDetailTableViewCell.h"

@interface KJDingDanDetailTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *itmrefLabel;
@property (weak, nonatomic) IBOutlet UILabel *cpxhLabel;
@property (weak, nonatomic) IBOutlet UILabel *cpmcLabel;
@property (weak, nonatomic) IBOutlet UILabel *xsdjLabel;
@property (weak, nonatomic) IBOutlet UILabel *kl1Label;
@property (weak, nonatomic) IBOutlet UILabel *kl2Label;
@property (weak, nonatomic) IBOutlet UILabel *kl3Label;
@property (weak, nonatomic) IBOutlet UILabel *netpriLabel;
@property (weak, nonatomic) IBOutlet UILabel *qtyLabel;
@property (weak, nonatomic) IBOutlet UILabel *linamtLabel;
@property (weak, nonatomic) IBOutlet UILabel *lackLabel;
@property (weak, nonatomic) IBOutlet UILabel *allqtyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dlvqtyLabel;
@property (weak, nonatomic) IBOutlet UILabel *invqtyLabel;

@end

@implementation KJDingDanDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDingdanDetail:(KJDingDanDetail *)dingdanDetail {
    _dingdanDetail = dingdanDetail;
    
    self.itmrefLabel.text = dingdanDetail.ITMREF_0;
    self.cpxhLabel.text = dingdanDetail.ITMDES_0;
    self.cpmcLabel.text = dingdanDetail.ITMDES1_0;
    self.xsdjLabel.text = [NSString stringWithFormat:@"%.2f", dingdanDetail.GROPRI_0];
    self.kl1Label.text = [NSString stringWithFormat:@"%ld", dingdanDetail.DISCRGVAL1_0];
    self.kl2Label.text = [NSString stringWithFormat:@"%ld", dingdanDetail.DISCRGVAL2_0];
    self.kl3Label.text = [NSString stringWithFormat:@"%ld", dingdanDetail.DISCRGVAL3_0];
    self.netpriLabel.text = [NSString stringWithFormat:@"%.2f", dingdanDetail.NETPRIATI_0];
    self.qtyLabel.text = [NSString stringWithFormat:@"%.2f", dingdanDetail.QTY_0];
    self.linamtLabel.text = [NSString stringWithFormat:@"%.2f", dingdanDetail.LINAMT_0];
    self.lackLabel.text = [NSString stringWithFormat:@"%.2f", dingdanDetail.LACKQTY_0];
    self.allqtyLabel.text = [NSString stringWithFormat:@"%.2f", dingdanDetail.ALLQTY_0];
    self.dlvqtyLabel.text = [NSString stringWithFormat:@"%.2f", dingdanDetail.DLVQTY_0];
    self.invqtyLabel.text = [NSString stringWithFormat:@"%.2f", dingdanDetail.INVQTY_0];
}

@end
