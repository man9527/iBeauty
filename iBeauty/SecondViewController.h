//
//  SecondViewController.h
//  iBeauty
//
//  Created by 宏揚 朱 on 12/4/7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <TapkuLibrary/TapkuLibrary.h>

@interface SecondViewController : BaseViewController  <TKCoverflowViewDelegate, TKCoverflowViewDataSource> {
    
    // The coverflow view
	TKCoverflowView *coverflow; 
    
	// Covers images
	NSMutableArray *covers; 
}

@property (retain,nonatomic) TKCoverflowView *coverflow;


@end
