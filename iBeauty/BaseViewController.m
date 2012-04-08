//
//  BaseViewController.m
//  iBeauty
//
//  Created by William Chu on 12/4/8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = BASE_COLOR;
    
    [self initTopBarTitle];
    
    
    self.tabBarItem.title = [self barItemTitle];
}

- (void)initTopBarTitle {
    // leave for children
}

- (NSString*)barItemTitle {
    return @"Default";
}

@end
