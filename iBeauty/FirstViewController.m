//
//  FirstViewController.m
//  iBeauty
//
//  Created by 宏揚 朱 on 12/4/7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
 
- (void)viewDidLoad
{
    [super viewDidLoad];

//    NSLog(NSLocalizedString(@"test1", nil));
//    NSLog([[NSLocale preferredLanguages] objectAtIndex:0]);
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)initTopBarTitle {
    
}

-(NSString*) barItemTitle {
    return NSLocalizedString(@"tabitem_camera_txt", nil);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
