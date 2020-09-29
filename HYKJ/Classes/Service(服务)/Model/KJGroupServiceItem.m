//
//  KJGroupServiceItem.m
//  HYKJ
//
//  Created by information on 2020/9/28.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJGroupServiceItem.h"
#import "MJExtension.h"

@implementation KJGroupServiceItem

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"servicelist": [KJServiceItem class]};
}

@end
