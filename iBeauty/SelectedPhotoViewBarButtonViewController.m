//
//  SelectedPhotoViewBarButtonViewController.m
//  iBeauty
//
//  Created by 宏揚 朱 on 12/4/15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <Three20UI/Three20UI.h>
#import <Three20UINavigator/Three20UINavigator.h>
#import "SelectedPhotoViewBarButtonViewController.h"

@interface SelectedPhotoViewBarButtonViewController ()

@end

@implementation SelectedPhotoViewBarButtonViewController

@synthesize likeBtnView, commentBtnView, numberBtnView, likeBtn, commentBtn, numberBtn, likeLabel, commentLabel, likeNumberLabel, commentNumberLabel, likeBarButton, commentBarButton, numberBarButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [likeBarButton setCustomView:likeBtnView];
    [commentBarButton setCustomView:commentBtnView];
    [numberBarButton setCustomView:numberBtnView];
}

//- (UIBarButtonItem*) getLikeBtn:(BOOL)isOn {
//    NSString* text = isOn?NSLocalizedString(@"btn_like_txt", nil):NSLocalizedString(@"btn_unlike_txt", nil);
//    likeLabel.text = text;
//
//    return likeBtn;
//}
//
//- (UIBarButtonItem*) getCommentBtn {
//    NSString* text = NSLocalizedString(@"btn_comment_txt", nil);
//    commentLabel.text = text;
//
//    return commentBtn;
//}  
//
//- (UIBarButtonItem*) getNumberBtn:(NSInteger)numberOfLike with:(NSInteger)numberOfComment {
//    likeNumberLabel.text = numberOfLike==0?@"":[NSString stringWithFormat:@"%d", numberOfLike];
//    commentNumberLabel.text = numberOfComment==0?@"":[NSString stringWithFormat:@"%d", numberOfComment];
//    return numberBtn;
//}
//
//- (IBAction)doLike {
//
//}
//
//- (IBAction)doComment {
//
//}
//
//- (IBAction)doShowComment {
//
//}
//
- (void)viewDidUnload
{
    [super viewDidUnload];
    likeBtn = nil;
    commentBtn = nil;
    numberBtn = nil;
    
    likeBtnView = nil;
    commentBtnView = nil;    
    numberBtnView = nil;
    
    likeLabel = nil;
    commentLabel = nil;
    likeNumberLabel = nil;
    commentNumberLabel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
