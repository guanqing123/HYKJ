//
//  KJTuiHuoTableViewCell.m
//  HYKJ
//
//  Created by information on 2020/8/21.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJTuiHuoTableViewCell.h"
#import "KJLongTextScrollView.h"

@interface KJTuiHuoTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *lshLabel;
@property (weak, nonatomic) IBOutlet UILabel *sqrqLabel;
@property (weak, nonatomic) IBOutlet UILabel *khmcLabe;
@property (weak, nonatomic) IBOutlet UILabel *nodeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ywyLabel;
@property (weak, nonatomic) IBOutlet UILabel *bmLabel;
@property (weak, nonatomic) IBOutlet UILabel *tjgsLabel;
@property (weak, nonatomic) IBOutlet UILabel *thlyLabel;

@property (nonatomic, strong)  KJLongTextScrollView *khmcVc;
@property (nonatomic, strong)  KJLongTextScrollView *thlyVc;

@end

@implementation KJTuiHuoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _khmcVc = [[KJLongTextScrollView alloc] initWithFrame:CGRectMake(180, 0, 150, 30)];
    [self.contentView addSubview:_khmcVc];
    
    _thlyVc = [[KJLongTextScrollView alloc] initWithFrame:CGRectMake(910, 0, 480, 30)];
    [self.contentView addSubview:_thlyVc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTuihuoZD:(KJTuiHuoZD *)tuihuoZD {
    _tuihuoZD = tuihuoZD;
    
    NSMutableAttributedString *lsh = [[NSMutableAttributedString alloc] initWithString:tuihuoZD.lsh];
    NSRange lshRange = NSMakeRange(0, [tuihuoZD.lsh length]);
    [lsh addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:lshRange];
    self.lshLabel.attributedText = lsh;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItem)];
    self.lshLabel.userInteractionEnabled = YES;
    [self.lshLabel addGestureRecognizer:tapGesture];
    
    self.sqrqLabel.text = tuihuoZD.sqrq;
    
    [self.khmcVc setLongText:tuihuoZD.khmc];
    
    self.nodeNameLabel.text = tuihuoZD.nodeName;
    self.ywyLabel.text = tuihuoZD.ywy;
    self.bmLabel.text = tuihuoZD.bm;
    self.tjgsLabel.text = tuihuoZD.bm;
    
    [self.thlyVc setLongText:tuihuoZD.thly];
}

- (void)tapItem {
    if ([self.delegate respondsToSelector:@selector(tuihuoTableViewCellShowDetail:)]) {
        [self.delegate tuihuoTableViewCellShowDetail:self];
    }
}

@end
