//
//  ServiceClient.h
//  iBeauty
//
//  Created by 宏揚 朱 on 12/4/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>

@interface ServiceClient : NSObject {

}

+ (ServiceClient*)sharedInstance;

- (void)getExpertsShare:(id)delegate;
- (void)getSingleShare:(NSInteger)shareId delete:(id)delegate;
@end
