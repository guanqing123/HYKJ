//
//  KJCoverView.m
//  HYKJ
//
//  Created by information on 2020/8/16.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJCoverView.h"

@interface KJCoverView() <UIGestureRecognizerDelegate>

@end

@implementation KJCoverView

- (instancetype)initCoverView {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCover)];
        [self addGestureRecognizer:tap];
        tap.delegate = self;
    }
    return self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:gestureRecognizer.view];
    if (CGRectContainsPoint(self.subviews[0].frame, point)) {
        return NO;
    }
    return YES;
}

- (void)tapCover {
    WEAKSELF
    [UIView animateWithDuration:0.25 animations:^{
        [weakSelf removeFromSuperview];
    }];
}

- (void)destory {
    WEAKSELF
    [UIView animateWithDuration:0.25 animations:^{
        [weakSelf removeFromSuperview];
    }];
}

@end
