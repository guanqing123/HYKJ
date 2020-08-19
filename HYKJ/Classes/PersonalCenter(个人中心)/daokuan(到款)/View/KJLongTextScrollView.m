//
//  KJLongTextScrollView.m
//  HYKJ
//
//  Created by information on 2020/8/13.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJLongTextScrollView.h"

@interface KJLongTextScrollView()

@property (nonatomic, weak) UILabel  *textLabel;

@end

@implementation KJLongTextScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        label.font = PFR12Font;
        [label.layer setBorderColor:[[UIColor blackColor] CGColor]];
        [label.layer setBorderWidth:0.5f];
        label.textAlignment = NSTextAlignmentCenter;
        self.textLabel = label;
        [self addSubview:label];
    }
    return self;
}

- (void)setLongText:(NSString *)longText {
    _longText = longText;
    
    CGFloat width = [self sizeWithString:longText font:[UIFont systemFontOfSize:12.0f] maxSize:CGSizeMake(MAXFLOAT, self.dc_height)];
    if (width > self.dc_width) {
        self.textLabel.frame = CGRectMake(0, 0, width, 30.0f);
        self.contentSize = CGSizeMake(width, 0);
    } else {
        self.textLabel.frame = self.bounds;
        self.contentSize = CGSizeMake(self.dc_width, 0);
    }
    
    self.textLabel.text = longText;
}


- (CGFloat)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)size {
    NSDictionary *sttrs = @{NSFontAttributeName: font};
    return [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:sttrs context:nil].size.width;
}

@end
