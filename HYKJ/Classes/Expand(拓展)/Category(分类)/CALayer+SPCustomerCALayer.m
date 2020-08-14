//
//  CALayer+SPCustomerCALayer.m
//  HYSmartPlus
//
//  Created by information on 2018/3/15.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "CALayer+SPCustomerCALayer.h"

@implementation CALayer (SPCustomerCALayer)

- (void)setBorderUIColor:(UIColor *)borderUIColor {
    self.borderColor = borderUIColor.CGColor;
}

- (UIColor *)borderUIColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
