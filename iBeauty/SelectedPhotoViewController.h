//
//  SelectedPhotoViewController.h
//  iBeauty
//
//  Created by William Chu on 12/4/9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>
#import <Three20/Three20+Additions.h>

#import "SelectedPhotoViewBarButtonViewController.h"

@interface SelectedPhotoViewController : TTPhotoViewController  <TTPostControllerDelegate>  {
    
    SelectedPhotoViewBarButtonViewController *btnViewController;

    IBOutlet UIButton * likeBtn;
    IBOutlet UIButton * commentBtn;
    IBOutlet UIButton * numberBtn;
    
    IBOutlet UIView * likeBtnView;
    IBOutlet UIView * commentBtnView;    
    IBOutlet UIView * numberBtnView;
    
    IBOutlet UILabel* likeLabel;
    IBOutlet UILabel* commentLabel;
    IBOutlet UILabel* likeNumberLabel;
    IBOutlet UILabel* commentNumberLabel;
}

@end
