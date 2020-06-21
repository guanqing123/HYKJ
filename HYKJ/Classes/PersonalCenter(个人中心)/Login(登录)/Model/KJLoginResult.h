//
//  KJLoginResult.h
//  HYKJ
//
//  Created by information on 2020/6/17.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJLoginResult : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, copy) NSString *data;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) Boolean success;

@end

NS_ASSUME_NONNULL_END
