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
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:218.0f/255.0f green:76.0f/255.0f blue:88.0/255.0f alpha:1.0];
    
    NSLog(NSLocalizedString(@"test1", nil));
    NSLog([[NSLocale preferredLanguages] objectAtIndex:0]);
	// Do any additional setup after loading the view, typically from a nib.
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
