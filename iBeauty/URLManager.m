//
//  URLManager.m
//  iBeauty
//
//  Created by 宏揚 朱 on 12/4/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "URLManager.h"

static NSString *const EXPERT_SHARES = @"http://localhost:8080/demo/stars.json";
static NSString *const SINGLE_SHARES = @"http://localhost:8080/demo/share%d";

@implementation URLManager

+(NSString*)expertShareURL {
    return EXPERT_SHARES;
}

+(NSString*)singlShareURL:(NSInteger)shareId {
    return [NSString stringWithFormat:SINGLE_SHARES, shareId];
}

@end
