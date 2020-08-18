//
//  KJDaokuanResult.m
//  HYKJ
//
//  Created by information on 2020/8/18.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJDaokuanResult.h"
#import "KJDaokuan.h"
#import "MJExtension.h"

@implementation KJDaokuanResult

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"data": [KJDaokuan class]};
}

@end
