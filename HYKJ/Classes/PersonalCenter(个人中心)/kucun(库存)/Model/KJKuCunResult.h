//
//  KJKuCunResult.h
//  HYKJ
//
//  Created by information on 2020/8/18.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJKuCunResult : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong)  NSArray *data;

@property (nonatomic, copy) NSString *total;

@end

NS_ASSUME_NONNULL_END
