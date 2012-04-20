//
//  CommentListViewController.m
//  iBeauty
//
//  Created by 宏揚 朱 on 12/4/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CommentListViewController.h"
#import "FirstViewController.h"
#import "Constants.h"

static NSString* kLoremIpsum = @"<a href='tt://google'>Lorem</a> ipsum dolor sit amet, consectetur adipisicing elit, sed do\
eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud\
exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";
//Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla\
pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt\
mollit anim id est laborum.

@interface CommentListViewController () {
    BOOL stayup;
    UITapGestureRecognizer *singleTapRecognizer;
    UITextField* commentInput;
    UIButton* commentSubmitBtn;
    UITapGestureRecognizer *tap;
}
@end

@implementation CommentListViewController

- (void)viewDidLoad {

    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardWillShow:) 
                                                 name:UIKeyboardWillShowNotification 
                                               object:self.view.window];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardWillHide:) 
                                                 name:UIKeyboardWillHideNotification 
                                               object:self.view.window];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {

        self.variableHeightRows = YES;
        self.navigationBarTintColor = BASE_COLOR;
        
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"btn_done_txt", nil) style:UIBarButtonItemStyleDone target:self action:@selector(returnToPrevView)];       
        
        UIBarButtonItem *likeBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"btn_like_txt", nil) style:UIBarButtonItemStyleDone target:self action:@selector(returnToPrevView)]; 
         
        self.navigationItem.leftBarButtonItem = doneBtn;
        self.navigationItem.rightBarButtonItem = likeBtn;
                
        [self setTableBannerView:[self getCommentInputView] animated:NO];
    }
    return self;
}

- (void) setupCommentList {
    self.tableViewStyle = UITableViewStyleGrouped;
    
    // This demonstrates how to create a table with standard table "fields".  Many of these
    // fields with URLs that will be visited when the row is selected
    TTTableSection *section = [[TTTableSection alloc] init];
    // TTTableStyledTextItem *styleitem = [TTTableStyledTextItem itemWithText:[TTStyledText textFromXHTML:kLoremIpsum]];
    
    self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
                       
                       
                       section,
                       [TTTableMessageItem itemWithTitle:@"<a href='http://www.google.com'>BB</a>" caption:nil
                                                    text:kLoremIpsum timestamp:[NSDate date] URL:nil],
                       [TTTableMessageItem itemWithTitle:@"<a href='http://www.google.com'>BB</a>" caption:nil
                                                    text:kLoremIpsum timestamp:[NSDate date] URL:nil],
                       [TTTableMessageItem itemWithTitle:@"<a href='http://www.google.com'>BB</a>" caption:nil
                                                    text:kLoremIpsum timestamp:[NSDate date] URL:nil],
                       [TTTableMessageItem itemWithTitle:@"<a href='http://www.google.com'>BB</a>" caption:nil
                                                    text:kLoremIpsum timestamp:[NSDate date] URL:nil],
                       [TTTableMessageItem itemWithTitle:@"<a href='http://www.google.com'>BB</a>" caption:nil
                                                    text:kLoremIpsum timestamp:[NSDate date] URL:nil],
                       [TTTableMessageItem itemWithTitle:@"<a href='http://www.google.com'>BB</a>" caption:nil
                                                    text:kLoremIpsum timestamp:[NSDate date] URL:nil],
                       [TTTableMessageItem itemWithTitle:@"<a href='http://www.google.com'>BB</a>" caption:nil
                                                    text:kLoremIpsum timestamp:[NSDate date] URL:nil],      
                       [TTTableMessageItem itemWithTitle:@"<a href='http://www.google.com'>BB</a>" caption:nil
                                                    text:kLoremIpsum timestamp:[NSDate date] URL:nil],      
                       [TTTableMessageItem itemWithTitle:@"<a href='http://www.google.com'>BB</a>" caption:nil
                                                    text:kLoremIpsum timestamp:[NSDate date] URL:nil],      
                       [TTTableMessageItem itemWithTitle:@"<a href='http://www.google.com'>BB</a>" caption:nil
                                                    text:kLoremIpsum timestamp:[NSDate date] URL:nil],      
                       nil];
}


- (void) returnToPrevView {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView*) getCommentInputView {
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"CommentInputView" owner:self options:nil];
    UIView *mainView = [subviewArray objectAtIndex:0];
    
    for (UIView *subV in mainView.subviews) {
        if ([subV class] == [UITextField class]) {
            commentInput = (UITextField*)subV;
        } else {
            commentSubmitBtn = (UIButton*)subV;
        }
    }
    
    commentSubmitBtn.titleLabel.text = NSLocalizedString(@"btn_send_txt", nil);
    return mainView;
}

#define kOFFSET_FOR_KEYBOARD 216.0

- (void)keyboardWillHide:(NSNotification *)notif {
    [self setViewMoveUp:NO];    
    [self.view removeGestureRecognizer:tap];
}


- (void)keyboardWillShow:(NSNotification *)notif{
    [self setViewMoveUp:YES];
    [self.view addGestureRecognizer:tap];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    stayup = YES;
    [self setViewMoveUp:YES];
    [self.view addGestureRecognizer:tap];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    stayup = NO;
    [self setViewMoveUp:NO];
    [self.view removeGestureRecognizer:tap]; 
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMoveUp:(BOOL)moveUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    CGRect rect = self.view.frame;
    if (moveUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard 
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        
        if (rect.origin.y == 0 ) {
            rect.origin.y -= kOFFSET_FOR_KEYBOARD;
            //rect.size.height += kOFFSET_FOR_KEYBOARD;
        }
        
    }
    else
    {
        if (stayup == NO) {
            rect.origin.y += kOFFSET_FOR_KEYBOARD;
        }
    }
    self.view.frame = rect; 
    [UIView commitAnimations];
}

- (UITableView*)tableView {
    if (nil == _tableView) {
        _tableView = [[TTTableView alloc] initWithFrame:self.view.bounds style:_tableViewStyle];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        if (_tableViewStyle == UITableViewStyleGrouped) {
            _tableView.backgroundColor = [UIColor clearColor];
            self.view.backgroundColor=BACKGROUND_COLOR;
        }
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)dealloc {
}

@end
