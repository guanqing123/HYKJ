//
//  KJZuDanDetailTableViewCell.m
//  HYKJ
//
//  Created by information on 2020/8/25.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJZuDanDetailTableViewCell.h"
#import "KJLongTextScrollView.h"

@interface KJZuDanDetailTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *cpdmLabel;

@property (weak, nonatomic) IBOutlet UILabel *cpmcLabel;
@property (nonatomic, weak) KJLongTextScrollView  *cpmcVc;

@property (weak, nonatomic) IBOutlet UILabel *cpxhLabel;
@property (nonatomic, weak) KJLongTextScrollView  *cpxhVc;

@property (weak, nonatomic) IBOutlet UILabel *slLabel;
@property (weak, nonatomic) IBOutlet UILabel *jsLabel;
@property (weak, nonatomic) IBOutlet UILabel *salfcyLabel;
@property (weak, nonatomic) IBOutlet UILabel *stofcyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dwLabel;

@end

@implementation KJZuDanDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    KJLongTextScrollView *cpmcVc = [[KJLongTextScrollView alloc] init];
    cpmcVc.frame = CGRectMake(100, 0, 250, 30);
    _cpmcVc = cpmcVc;
    [self.contentView addSubview:cpmcVc];
    
    KJLongTextScrollView *cpxhVc = [[KJLongTextScrollView alloc] init];
    cpxhVc.frame = CGRectMake(350, 0, 150, 30);
    _cpxhVc = cpxhVc;
    [self.contentView addSubview:cpxhVc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setZudanDetail:(KJZuDanDetail *)zudanDetail {
    _zudanDetail = zudanDetail;
    
    self.cpdmLabel.text = zudanDetail.CPDM;
    
    [self.cpmcVc setLongText:zudanDetail.CPMC];
    [self.cpxhVc setLongText:zudanDetail.CPXH];
    
    self.slLabel.text = zudanDetail.QTY;
    self.jsLabel.text = zudanDetail.ZSDJS;
    self.salfcyLabel.text = zudanDetail.FCYNAM;
    self.stofcyLabel.text = zudanDetail.STONAM;
    self.dwLabel.text = zudanDetail.STU;
}

@end
