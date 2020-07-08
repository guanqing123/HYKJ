//
//  SPSettingTopView.m
//  HYSmartPlus
//
//  Created by information on 2018/5/12.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPSettingTopView.h"
#import "SPSpeedy.h"
#import "KJAccountTool.h"

@interface SPSettingTopView()
@property (weak, nonatomic) IBOutlet UIButton *headImage;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIView *headerView;

- (IBAction)rightClick;

- (IBAction)wxClick:(UIButton *)sender;

- (IBAction)sdgClick:(UIButton *)sender;

@end

@implementation SPSettingTopView

#pragma mark - Intial
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [SPSpeedy dc_setUpBezierPathCircularLayerWith:self.headImage size:CGSizeMake(self.headImage.dc_width * 0.5, self.headImage.dc_height * 0.5)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewClick)];
    [self.headerView addGestureRecognizer:tap];
}

+ (instancetype)topView {
    return [[[NSBundle mainBundle] loadNibNamed:@"SPSettingTopView" owner:nil options:nil] lastObject];
}

- (void)headerViewClick {
    !_headerViewBlock ? : _headerViewBlock();
}

- (void)setData {
    UIImage *image = [UIImage imageWithContentsOfFile:KJHeadImagePath];
    if (image) {
        [self.headImage setImage:image forState:UIControlStateNormal];
    }else{
        [self.headImage setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
    }
    
    self.telLabel.text = [KJAccountTool getUserCode];
    self.detailLabel.text = [NSString stringWithFormat:@"我的推荐码：%@",[KJAccountTool getUserCode]];
}

- (IBAction)rightClick {
    !_headerViewBlock ? : _headerViewBlock();
}

- (IBAction)wxClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(topView:buttonType:)]) {
        [self.delegate topView:self buttonType:(int)sender.tag];
    }
}

- (IBAction)sdgClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(topView:buttonType:)]) {
        [self.delegate topView:self buttonType:(int)sender.tag];
    }
}
@end
