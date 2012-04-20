//
//  URLManager.h
//  iBeauty
//
//  Created by 宏揚 朱 on 12/4/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLManager : NSObject

+(NSString*) expertShareURL;
+(NSString*) singlShareURL:(NSInteger)shareId;
@end
