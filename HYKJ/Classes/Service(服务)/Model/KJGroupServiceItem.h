//
//  KJGroupServiceItem.h
//  HYKJ
//
//  Created by information on 2020/9/28.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KJServiceItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface KJGroupServiceItem : NSObject

@property (nonatomic, copy) NSString *header;
@property (nonatomic, assign) CGFloat r;
@property (nonatomic, assign) CGFloat g;
@property (nonatomic, assign) CGFloat b;
@property (nonatomic, strong)  NSArray *servicelist;

@end

NS_ASSUME_NONNULL_END
