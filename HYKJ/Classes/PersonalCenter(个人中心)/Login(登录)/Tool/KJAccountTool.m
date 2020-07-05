//
//  KJAccountTool.m
//  HYKJ
//
//  Created by information on 2020/6/17.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "KJAccountTool.h"
#import "KJLoginResult.h"

#define KJLoginResultFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"loginResult.data"]


@implementation KJAccountTool

+ (void)saveLoginResult:(KJLoginResult *)loginResult {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:loginResult.data forKey:Token];
}

+ (NSString *)loginResult
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:Token];
}

@end
