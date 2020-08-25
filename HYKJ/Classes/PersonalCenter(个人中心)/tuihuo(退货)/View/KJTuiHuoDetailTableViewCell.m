//
//  KJTuiHuoDetailTableViewCell.m
//  HYKJ
//
//  Created by information on 2020/8/24.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJTuiHuoDetailTableViewCell.h"
#import "KJLongTextScrollView.h"

@interface KJTuiHuoDetailTableViewCell()
@property (nonatomic, weak) KJLongTextScrollView  *cpxhVc;
@property (weak, nonatomic) IBOutlet UILabel *cpdmLabel;
@property (weak, nonatomic) IBOutlet UILabel *xsdjLabel;
@property (weak, nonatomic) IBOutlet UILabel *sqslLabel;
@property (weak, nonatomic) IBOutlet UILabel *pzslLabel;

@end

@implementation KJTuiHuoDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    KJLongTextScrollView *cpxhVc = [[KJLongTextScrollView alloc] init];
    cpxhVc.frame = CGRectMake(0, 0, 120, 30);
    _cpxhVc = cpxhVc;
    [self.contentView addSubview:cpxhVc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTuihuoMX:(KJTuiHuoMX *)tuihuoMX {
    _tuihuoMX = tuihuoMX;
    
    [self.cpxhVc setLongText:tuihuoMX.cpxh];
    
    self.cpdmLabel.text = tuihuoMX.cpdm;
    
    self.xsdjLabel.text = [NSString stringWithFormat:@"%.2f", tuihuoMX.xsdj];
    
    self.sqslLabel.text = tuihuoMX.sqsl;
    
    self.pzslLabel.text = tuihuoMX.pzsl;
}

@end
