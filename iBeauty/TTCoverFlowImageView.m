//
//  TTCoverFlowImageView.m
//  iBeauty
//
//  Created by 宏揚 朱 on 12/4/14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TTCoverFlowImageView.h"

@implementation TTCoverFlowImageView
@synthesize coverflowView = _coverflowView;

- (void)imageViewDidLoadImage:(UIImage*)image {
    [_coverflowView resetImage];
}

@end
