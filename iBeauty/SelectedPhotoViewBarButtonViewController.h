//
//  SelectedPhotoViewBarButtonViewController.h
//  iBeauty
//
//  Created by 宏揚 朱 on 12/4/15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedPhotoViewBarButtonViewController : UIViewController
{
    IBOutlet UIBarButtonItem* likeBarButton;
    IBOutlet UIBarButtonItem* commentBarButton;
    IBOutlet UIBarButtonItem* numberBarButton;
    
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

@property (strong, nonatomic) UIBarButtonItem* likeBarButton;
@property (strong, nonatomic) UIBarButtonItem* commentBarButton;
@property (strong, nonatomic) UIBarButtonItem* numberBarButton;

@property (strong, nonatomic) UIView* likeBtnView;
@property (strong, nonatomic) UIView* commentBtnView;
@property (strong, nonatomic) UIView* numberBtnView;

@property (strong, nonatomic) UIButton* likeBtn;
@property (strong, nonatomic) UIButton* commentBtn;
@property (strong, nonatomic) UIButton* numberBtn;

@property (strong, nonatomic) UILabel* likeLabel;
@property (strong, nonatomic) UILabel* commentLabel;
@property (strong, nonatomic) UILabel* likeNumberLabel;
@property (strong, nonatomic) UILabel* commentNumberLabel;

//- (UIBarButtonItem*) getLikeBtn:(BOOL)isOn; 
//- (UIBarButtonItem*) getCommentBtn; 
//- (UIBarButtonItem*) getNumberBtn:(NSInteger)numberOfLike with:(NSInteger)numberOfComment; 
//- (IBAction) doLike;
//- (IBAction) doComment;
//- (IBAction) doShowComment;
@end
