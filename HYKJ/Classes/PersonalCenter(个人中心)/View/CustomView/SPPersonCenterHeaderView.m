//
//  SPPersonCenterHeaderView.m
//  HYSmartPlus
//
//  Created by information on 2018/5/14.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPPersonCenterHeaderView.h"

@interface SPPersonCenterHeaderView()
@property (weak, nonatomic) IBOutlet UIButton *headImageBtn;
@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;

- (IBAction)headImageClick;

@end

@implementation SPPersonCenterHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [SPSpeedy dc_setUpBezierPathCircularLayerWith:self.headImageBtn size:CGSizeMake(self.headImageBtn.dc_width * 0.5, self.headImageBtn.dc_height * 0.5)];
}

+ (instancetype)headerView {
    return [[[NSBundle mainBundle] loadNibNamed:@"SPPersonCenterHeaderView" owner:nil options:nil] lastObject];
}

- (void)setData {
    UIImage *image = [UIImage imageWithContentsOfFile:KJHeadImagePath];
    if (image) {
        [self.headImageBtn setImage:image forState:UIControlStateNormal];
    }else{
        [self.headImageBtn setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
    }
    self.telephoneLabel.text = @"xxxxx";
}

- (IBAction)headImageClick {
    !_headImageBlock ? : _headImageBlock();
}
@end
