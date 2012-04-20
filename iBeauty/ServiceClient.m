//
//  ServiceClient.m
//  iBeauty
//
//  Created by 宏揚 朱 on 12/4/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ServiceClient.h"
#import "URLManager.h"
#import "extThree20JSON/extThree20JSON.h"

static ServiceClient* client = NULL;

@implementation ServiceClient 


+ (ServiceClient*)sharedInstance {
    @synchronized(client) {
        if (!client || client == NULL) {
            client = [[ServiceClient alloc] init];
        }
    }
    return client;
}

- (void)getExpertsShare:(id)delegate {
    TTURLRequest* request = [self getRequest:[URLManager expertShareURL] delegate:delegate];
    [request send];
}

- (void)getSingleShare:(NSInteger)shareId delete:(id)delegate {
    TTURLRequest* request = [self getRequest:[URLManager singlShareURL:shareId] delegate:delegate];
    [request send];
}
 
-(TTURLRequest*)getRequest:(NSString*)url delegate:(id)delegate {
    TTURLRequest* request = [TTURLRequest requestWithURL: url delegate: delegate];
    request.httpMethod = @"GET";
    request.cachePolicy = TTURLRequestCachePolicyNoCache;
    request.response = [[TTURLJSONResponse alloc] init];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    return request;
}

@end
