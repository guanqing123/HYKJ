//
//  KJDaoKuanSearchView.m
//  HYKJ
//
//  Created by information on 2020/8/14.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJDaoKuanSearchView.h"

@interface KJDaoKuanSearchView()
@property (weak, nonatomic) IBOutlet UITextField *startDatFied;
@property (weak, nonatomic) IBOutlet UITextField *endDatField;
@end

@implementation KJDaoKuanSearchView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString *trdate = [formatter stringFromDate:[NSDate date]];
    NSString *mix = [NSString stringWithFormat:@"%@-01",trdate];
    self.startDatFied.text = mix;
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *max = [formatter stringFromDate:[NSDate date]];
    self.endDatField.text = max;
}

+ (instancetype)searchView {
    return [[[NSBundle mainBundle] loadNibNamed:@"KJDaoKuanSearchView" owner:nil options:nil] lastObject];
}

@end
