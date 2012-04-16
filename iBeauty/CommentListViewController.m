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

@interface CommentListViewController ()

@end

@implementation CommentListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"Table Items";
        self.variableHeightRows = YES;
        // self.tableView.backgroundColor = BACKGROUND_COLOR;
        self.navigationBarTintColor = BASE_COLOR;
        
        // comment this to see how the table looks with the standard style
        self.tableViewStyle = UITableViewStyleGrouped;
        
        // Uncomment this to see how the table cells look against a custom background color
        //self.tableView.backgroundColor = [UIColor yellowColor];
        
        NSString* localImage = @"bundle://tableIcon.png";
        NSString* remoteImage = @"http://profile.ak.fbcdn.net/v223/35/117/q223792_6978.jpg";
        UIImage* defaultPerson = [UIImage imageNamed:@"photo01.jpg"];
        
        // This demonstrates how to create a table with standard table "fields".  Many of these
        // fields with URLs that will be visited when the row is selected
        TTTableSection *section = [[TTTableSection alloc] init];
        TTTableStyledTextItem *styleitem = [TTTableStyledTextItem itemWithText:[TTStyledText textFromXHTML:kLoremIpsum]];
        
        self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
                           
                            
                           section,
                           [TTTableLink itemWithText:@"TTTableLink" URL:@"tt://tableItemTest"],
                           [TTTableButton itemWithText:@"TTTableButton"],
                           [TTTableCaptionItem itemWithText:@"TTTableCaptionItem" caption:@"caption"
                                                        URL:@"tt://tableItemTest"],
                           [TTTableSubtitleItem itemWithText:@"TTTableSubtitleItem" subtitle:kLoremIpsum
                                                         URL:@"tt://tableItemTest"],
                           [TTTableMessageItem itemWithTitle:@"<a href='http://www.google.com'>BB</a>" caption:nil
                                                        text:kLoremIpsum timestamp:[NSDate date] URL:nil],
                           [TTTableMoreButton itemWithText:@"TTTableMoreButton"],
                           styleitem,                                                
                           nil];
        
        UIImageView *v = [[UIImageView alloc] initWithImage:defaultPerson];
        CGRect frame = v.frame;
        frame.size.height = frame.size.height + 100;
        v.frame = frame;
        [self setTableBannerView:v];
    }
    return self;
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
