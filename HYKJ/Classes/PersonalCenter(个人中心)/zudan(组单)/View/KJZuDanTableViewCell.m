//
//  KJZuDanTableViewCell.m
//  HYKJ
//
//  Created by information on 2020/8/24.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJZuDanTableViewCell.h"
#import "KJLongTextScrollView.h"

@interface KJZuDanTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *zspnumLabel;
@property (weak, nonatomic) IBOutlet UILabel *zspdatLabel;

@property (weak, nonatomic) IBOutlet UILabel *bptnamLabel;
@property (nonatomic, weak) KJLongTextScrollView  *bptnamVc;

@property (weak, nonatomic) IBOutlet UILabel *zspdtypLabel;
@property (weak, nonatomic) IBOutlet UILabel *zsppstypLabel;
@property (weak, nonatomic) IBOutlet UILabel *zspqtyLabel;
@property (weak, nonatomic) IBOutlet UILabel *zspvolLabel;
@property (weak, nonatomic) IBOutlet UILabel *zkhcdLabel;
@property (weak, nonatomic) IBOutlet UILabel *bpcnamLabel;

@property (weak, nonatomic) IBOutlet UILabel *zaddressLabel;
@property (nonatomic, weak) KJLongTextScrollView  *zaddressVc;

@property (weak, nonatomic) IBOutlet UILabel *zkddhLabel;
@end

@implementation KJZuDanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    KJLongTextScrollView *bptnamVc = [[KJLongTextScrollView alloc] init];
    bptnamVc.frame = CGRectMake(220, 0, 200, 30);
    _bptnamVc = bptnamVc;
    [self.contentView addSubview:bptnamVc];
    
    KJLongTextScrollView *zaddressVc = [[KJLongTextScrollView alloc] init];
    zaddressVc.frame = CGRectMake(1140, 0, 200, 30);
    _zaddressVc = zaddressVc;
    [self.contentView addSubview:zaddressVc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setZudan:(KJZuDan *)zudan {
    _zudan = zudan;
    
    NSMutableAttributedString *zspnum = [[NSMutableAttributedString alloc] initWithString:zudan.zspnum];
    NSRange zspRange = NSMakeRange(0, [zudan.zspnum length]);
    [zspnum addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:zspRange];
    self.zspnumLabel.attributedText = zspnum;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItem)];
    self.zspnumLabel.userInteractionEnabled = YES;
    [self.zspnumLabel addGestureRecognizer:tapGesture];
    
    
    self.zspdatLabel.text = zudan.zspdat;
    
    [self.bptnamVc setLongText:zudan.bptnam];
    
    self.zspdtypLabel.text = zudan.zspdtyp;
    self.zsppstypLabel.text = zudan.zsppstyp;
    self.zspqtyLabel.text = zudan.zspqty;
    self.zspvolLabel.text = zudan.zspvol;
    self.zkhcdLabel.text = zudan.zkhcd;
    self.bpcnamLabel.text = zudan.bpcnam;
    
    [self.zaddressVc setLongText:zudan.zaddress];
    
    self.zkddhLabel.text = zudan.zkddh;
}

- (void)tapItem {
    if ([self.delegate respondsToSelector:@selector(zudanTableViewCellShowDetail:)]) {
        [self.delegate zudanTableViewCellShowDetail:self];
    }
}

@end
