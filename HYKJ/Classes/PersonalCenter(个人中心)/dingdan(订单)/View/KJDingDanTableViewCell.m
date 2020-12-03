//
//  KJDingDanTableViewCell.m
//  HYKJ
//
//  Created by information on 2020/8/28.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJDingDanTableViewCell.h"
#import "KJLongTextScrollView.h"

@interface KJDingDanTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *sohnumLabel;
@property (weak, nonatomic) IBOutlet UILabel *orddatLabel;
@property (weak, nonatomic) IBOutlet UILabel *ordamtLabel;
@property (weak, nonatomic) IBOutlet UILabel *dlvamtLabel;
@property (weak, nonatomic) IBOutlet UILabel *mdlLabel;

@property (weak, nonatomic) IBOutlet UILabel *bptnumLabel;
@property (nonatomic, weak) KJLongTextScrollView  *bptnumVc;

@property (weak, nonatomic) IBOutlet UILabel *ywyLabel;
@property (weak, nonatomic) IBOutlet UILabel *salfcyLabel;
@property (weak, nonatomic) IBOutlet UILabel *stofcyLabel;
@property (weak, nonatomic) IBOutlet UILabel *ordstaLabel;
@property (weak, nonatomic) IBOutlet UILabel *allstaLabel;
@property (weak, nonatomic) IBOutlet UILabel *dlvstaLabel;
@property (weak, nonatomic) IBOutlet UILabel *invstaLabel;
@property (weak, nonatomic) IBOutlet UILabel *bpcnumLabel;

@property (weak, nonatomic) IBOutlet UILabel *bpcnamLabel;
@property (nonatomic, weak) KJLongTextScrollView  *bpcnamVc;

@property (weak, nonatomic) IBOutlet UILabel *zxsohnumLabel;

@end

@implementation KJDingDanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    KJLongTextScrollView *bptnumVc = [[KJLongTextScrollView alloc] init];
    bptnumVc.frame = CGRectMake(480, 0, 200, 30);
    _bptnumVc = bptnumVc;
    [self.contentView addSubview:bptnumVc];
    
    KJLongTextScrollView *bpcnamVc = [[KJLongTextScrollView alloc] init];
    bpcnamVc.frame = CGRectMake(1560, 0, 120, 30);
    _bpcnamVc = bpcnamVc;
    [self.contentView addSubview:bpcnamVc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDingdan:(KJDingDan *)dingdan {
    _dingdan = dingdan;
    
    NSMutableAttributedString *sohnum = [[NSMutableAttributedString alloc] initWithString:dingdan.sohnum];
    NSRange zspRange = NSMakeRange(0, [dingdan.sohnum length]);
    [sohnum addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:zspRange];
    self.sohnumLabel.attributedText = sohnum;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItem)];
    self.sohnumLabel.userInteractionEnabled = YES;
    [self.sohnumLabel addGestureRecognizer:tapGesture];
    
    
    self.orddatLabel.text = dingdan.orddat;
    self.ordamtLabel.text = [NSString stringWithFormat:@"%.2f", dingdan.ordamt];
    self.dlvamtLabel.text = [NSString stringWithFormat:@"%.2f", dingdan.dlvamt];
    self.mdlLabel.text = dingdan.mdl;
    
    //self.bptnumLabel.text = dingdan.bptnam;
    [self.bptnumVc setLongText:dingdan.bptnam];
    
    self.ywyLabel.text = dingdan.ywy;
    self.salfcyLabel.text = dingdan.salnam;
    self.stofcyLabel.text = dingdan.fcynam;
    self.ordstaLabel.text = dingdan.ordsta;
    self.allstaLabel.text = dingdan.allsta;
    self.dlvstaLabel.text = dingdan.dlvsta;
    self.invstaLabel.text = dingdan.invsta;
    self.bpcnumLabel.text = dingdan.bpcord;
    
    
    //self.bpcnamLabel.text = dingdan.bpcnam;
    [self.bpcnamVc setLongText:dingdan.bpcnam];
    self.zxsohnumLabel.text = dingdan.zxsohnum;
}

- (void)tapItem {
    if ([self.delegate respondsToSelector:@selector(dingdanTableViewCellShowDetail:)]) {
        [self.delegate dingdanTableViewCellShowDetail:self];
    }
}

@end
