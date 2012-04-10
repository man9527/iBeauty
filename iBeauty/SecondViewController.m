//
//  SecondViewController.m
//  iBeauty
//
//  Created by 宏揚 朱 on 12/4/7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"
#import "SelectedPhotoViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

@synthesize coverflow;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Setup the covers
	covers = [NSArray arrayWithObjects:
			   [UIImage imageNamed:@"photo01.jpg"],[UIImage imageNamed:@"photo02.jpg"],
			   [UIImage imageNamed:@"photo01.jpg"],[UIImage imageNamed:@"photo02.jpg"],
			   [UIImage imageNamed:@"photo01.jpg"],[UIImage imageNamed:@"photo02.jpg"],
			   [UIImage imageNamed:@"photo01.jpg"],[UIImage imageNamed:@"photo02.jpg"],
			   [UIImage imageNamed:@"photo01.jpg"],nil];
     
	// Add the coverflow view
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect statusBar = [[UIApplication sharedApplication] statusBarFrame];
    
    float height = screenRect.size.height - (statusBar.size.height + self.navigationController.navigationBar.bounds.size.height + self.tabBarController.tabBar.bounds.size.height);
    //float y = statusBar.size.height + self.navigationController.navigationBar.bounds.size.height;
    
	coverflow = [[TKCoverflowView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, height)];
    coverflow.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:254.0f/255.0f blue:242.0/255.0f alpha:1.0];
	coverflow.coverflowDelegate = self;
	coverflow.dataSource = self;
    coverflow.coverSpacing = 50; 
    
	[self.view addSubview:coverflow];
	[coverflow setNumberOfCovers:50];
}
 
#pragma Coverflow delegate methods
- (void) coverflowView:(TKCoverflowView*)coverflowView coverAtIndexWasBroughtToFront:(int)index{
    //	NSLog(@"Front %d",index);
}        

- (TKCoverflowCoverView*) coverflowView:(TKCoverflowView*)coverflowView coverAtIndex:(int)index{
	
	TKCoverflowCoverView *cover = [coverflowView dequeueReusableCoverView];
    
	if(cover == nil){
		// Change the covers size here
		cover = [[TKCoverflowCoverView alloc] initWithFrame:CGRectMake(0, 0, 224, 224)]; // 224
        cover.backgroundColor = [UIColor clearColor];
		cover.baseline = 50;
	}   
    
	cover.image = [covers objectAtIndex:index % [covers count]];
	
	return cover;
	
}
- (void) coverflowView:(TKCoverflowView*)coverflowView coverAtIndexWasDoubleTapped:(int)index{
	
	TKCoverflowCoverView *cover = [coverflowView coverAtIndex:index];
	if(cover == nil) return;

	SelectedPhotoViewController* s = [[SelectedPhotoViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:s animated:YES];
    
//    [UIView beginAnimations:nil context:nil];
//	[UIView setAnimationDuration:1];
//	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:cover cache:YES];
//	[UIView commitAnimations];
//	
    //	NSLog(@"Index: %d",index);
}


- (void)initTopBarTitle {
    //UIToolbar* toolbar = [[UIToolbar alloc]
    //                      initWithFrame:CGRectMake(0, 0, 105, 45)];
    
    //[toolbar setBarStyle: self.navigationController.navigationBar.barStyle];
    
    //toolbar.tintColor=self.navigationController.navigationBar.tintColor;
    
    // create an array for the buttons
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:2];
    
    UIBarButtonItem *loginBtn = [[UIBarButtonItem alloc]
                                 initWithTitle: NSLocalizedString(@"btn_login_txt", nil) 
                                 style:UIBarButtonItemStyleBordered
                                 target:self
                                 action:@selector(loginAction:)];
    //registerBtn.style = UIBarButtonItemStyleBordered;
    [buttons addObject:loginBtn];
    
    // create a standard delete button with the trash icon
    UIBarButtonItem *registerBtn = [[UIBarButtonItem alloc]
                                    initWithTitle: NSLocalizedString(@"btn_register_txt", nil)
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(registerAction:)];
    
    // registerBtn.style = UIBarButtonItemStyleBordered;
    [buttons addObject:registerBtn];
    
    // put the buttons in the toolbar and release them
    //[toolbar setItems:buttons animated:NO];
    
    // place the toolbar into the navigation bar
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
    //                                              initWithCustomView:toolbar];
    
    UIBarButtonItem *fixed1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    UIBarButtonItem *fixed2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:registerBtn, loginBtn, fixed1, fixed2, nil];
    
    NSString *logo = [[NSBundle mainBundle] pathForResource:@"logo" ofType:@"png"];
    
    UIImage *logoImage = [UIImage imageWithContentsOfFile:logo];

    UIImageView *logoView = [[UIImageView alloc] initWithImage:logoImage];
    
    CGRect frame = logoView.frame;
    frame.origin.x = -70;
    logoView.frame = frame;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    [titleView addSubview:logoView];
    
    self.navigationItem.titleView = titleView;
}


-(NSString*) barItemTitle {
    return NSLocalizedString(@"tabitem_expert_txt", nil);
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
