//
//  KJDaokuanParam.h
//  HYKJ
//
//  Created by information on 2020/8/18.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJDaokuanParam : NSObject

@property (nonatomic, copy) NSString *startDat;

@property (nonatomic, copy) NSString *endDat;

@property (nonatomic, copy) NSString *dkdd;

@property (nonatomic, copy) NSString *hzdd;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger limit;

@end

NS_ASSUME_NONNULL_END
