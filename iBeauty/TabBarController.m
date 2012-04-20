//
//  TabBarController.m
//  iBeauty
//
//  Created by 宏揚 朱 on 12/4/17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TabBarController.h"

@implementation TabBarController

- (id)initWithSelectedIndex:(NSInteger)index {
    if (self = [super init]) {
        self.selectedIndex = index;
    }
    
    return self;
}

- (void)viewDidLoad {
    [self setTabURLs: [NSArray arrayWithObjects:@"tt://firstTab", @"tt://secondTab", @"tt://thirdTab", nil]];
}
@end
