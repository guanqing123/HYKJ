//
//  KJServiceCollectionViewCell.m
//  HYKJ
//
//  Created by information on 2020/8/26.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJServiceCollectionViewCell.h"

// Vendors
#import <UIImageView+WebCache.h>
// Categories
#import "UIView+DCRolling.h"
#import "UIColor+DCColorChange.h"

@interface KJServiceCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@end

@implementation KJServiceCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setServiceItem:(KJServiceItem *)serviceItem {
    _serviceItem = serviceItem;
    
    self.titleLabel.text = serviceItem.gridTitle;
    self.tagLabel.text = serviceItem.gridTag;
    
    _tagLabel.hidden = (serviceItem.gridTag.length == 0) ? YES : NO;
    _tagLabel.textColor = [UIColor dc_colorWithHexString:serviceItem.gridColor];
    [SPSpeedy dc_chageControlCircularWith:_tagLabel AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:_tagLabel.textColor canMasksToBounds:YES];

    if (serviceItem.iconImage.length == 0) return;
    if ([[serviceItem.iconImage substringToIndex:4] isEqualToString:@"http"]) {
        
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:serviceItem.iconImage]placeholderImage:[UIImage imageNamed:@"default_49_11"]];
    }else{
        self.imageView.image = [UIImage imageNamed:serviceItem.iconImage];
    }
}

@end
