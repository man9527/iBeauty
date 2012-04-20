//
//  SecondViewController.h
//  iBeauty
//
//  Created by 宏揚 朱 on 12/4/7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <Three20/Three20.h>
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <TapkuLibrary/TapkuLibrary.h>

@interface SecondViewController : BaseViewController  <TKCoverflowViewDelegate, TKCoverflowViewDataSource, TTURLRequestDelegate> {
    
    // The coverflow view
	TKCoverflowView *coverflow; 
    
	// Covers images
	NSArray *covers; 
    IBOutlet UILabel* tryAgainLabel;
    IBOutlet UIButton* tryAgainButton;
}

@property (retain,nonatomic) TKCoverflowView *coverflow;

- (IBAction)beginLoad:(id)sender;

@end
