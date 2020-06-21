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

+ (KJLoginResult *)loginResult
{
    if (@available(iOS 12.0, *)) {
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:KJLoginResultFile];
        KJLoginResult *loginResult = [NSKeyedUnarchiver unarchivedObjectOfClass:KJLoginResult.class fromData:data error:NULL];
        NSLog(@"filePath = %@",KJLoginResultFile);
        return loginResult;
    } else {
        KJLoginResult *loginResult = [NSKeyedUnarchiver unarchiveObjectWithFile:KJLoginResultFile];
        NSLog(@"filePath = %@",KJLoginResultFile);
        return loginResult;
    }
}

@end
