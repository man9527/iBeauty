//
//  CommentController.m
//  iBeauty
//
//  Created by 宏揚 朱 on 12/4/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CommentController.h"
#import "Constants.h"

@implementation CommentController

- (void)loadView { 
    [super loadView]; 
        
    _innerView.backgroundColor = BACKGROUND_COLOR;
    
    _navigationBar.tintColor = BASE_COLOR;
    
    _textView.layer.borderWidth = 2;
    _textView.layer.cornerRadius = 12;
    _textView.layer.borderColor = [[UIColor grayColor] CGColor];
} 

@end
