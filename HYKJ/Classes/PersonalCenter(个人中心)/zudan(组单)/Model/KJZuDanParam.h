//
//  KJZuDanParam.h
//  HYKJ
//
//  Created by information on 2020/8/24.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJZuDanParam : NSObject

@property (nonatomic, copy) NSString *startDat;

@property (nonatomic, copy) NSString *endDat;

@property (nonatomic, copy) NSString *zddh;

@property (nonatomic, copy) NSString *hd;

@property (nonatomic, copy) NSString *yd;

@property (nonatomic, copy) NSString *ps;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger limit;

@end

NS_ASSUME_NONNULL_END
