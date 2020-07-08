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
    [defaults setObject:loginResult.data[token] forKey:token];
    [defaults setObject:loginResult.data[userCode] forKey:userCode];
    [defaults setObject:loginResult.data[fullName] forKey:fullName];
    [defaults synchronize];
}

+ (void)replaceToken:(NSString *)newToken {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:newToken forKey:token];
    [defaults synchronize];
}

+ (NSString *)getToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:token];
}

+ (NSString *)getUserCode {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:userCode];
}

+ (NSString *)getFullName {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:fullName];
}

@end
