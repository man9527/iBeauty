//
//  SecondViewController.m
//  iBeauty
//
//  Created by 宏揚 朱 on 12/4/7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"
#import "SelectedPhotoViewController.h"
#import "Constants.h"
#import "TTCoverFlowImageView.h"
#import "ServiceClient.h"
#import "extThree20JSON/extThree20JSON.h"
#import "SVProgressHUD.h"
#import "DomainObject.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

@synthesize coverflow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"tabitem_expert_txt", nil);
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    tryAgainLabel.text = NSLocalizedString(@"tryagain", nil);
    [tryAgainLabel sizeToFit];
    [tryAgainLabel setCenter:self.view.center];
    
    [self beginLoad:self];
}

- (IBAction)beginLoad:(id)sender {
    tryAgainLabel.hidden = YES;
    tryAgainButton.hidden = YES;
    [SVProgressHUD showWithStatus:NSLocalizedString(@"loading", nil)];
    [[ServiceClient sharedInstance] getExpertsShare:self];
}

-(void) setupCoverFlow:(NSArray*)shares {
	// Setup the covers
//	covers = [NSArray arrayWithObjects:
//              @"http://img01.taobaocdn.com/imgextra/i1/381131249/T2JV5zXgpaXXXXXXXX_!!381131249.jpg",@"http://img01.taobaocdn.com/imgextra/i1/381131249/T29VSzXkhaXXXXXXXX_!!381131249.jpg",
//              @"http://img04.taobaocdn.com/imgextra/i4/381131249/T2ap5zXhlaXXXXXXXX_!!381131249.jpg",@"http://img01.taobaocdn.com/imgextra/i1/381131249/T2bF5zXhhaXXXXXXXX_!!381131249.jpg",
//              @"http://img03.taobaocdn.com/imgextra/i3/381131249/T28aezXbxaXXXXXXXX_!!381131249.jpg",@"http://img02.taobaocdn.com/imgextra/i2/381131249/T2wpSzXlhaXXXXXXXX_!!381131249.jpg",
//              @"http://img01.taobaocdn.com/imgextra/i1/381131249/T29VSzXkhaXXXXXXXX_!!381131249.jpg",@"http://img01.taobaocdn.com/imgextra/i1/381131249/T29VSzXkhaXXXXXXXX_!!381131249.jpg",
//              @"http://img01.taobaocdn.com/imgextra/i1/381131249/T2JV5zXgpaXXXXXXXX_!!381131249.jpg",nil];
    
    covers = shares;

	// Add the coverflow view
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect statusBar = [[UIApplication sharedApplication] statusBarFrame];
    
    float height = screenRect.size.height - (statusBar.size.height + self.navigationController.navigationBar.bounds.size.height + self.tabBarController.tabBar.bounds.size.height);
    //float y = statusBar.size.height + self.navigationController.navigationBar.bounds.size.height;
    
	coverflow = [[TKCoverflowView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, height)];
    coverflow.backgroundColor = BACKGROUND_COLOR;
	coverflow.coverflowDelegate = self;
	coverflow.dataSource = self;
    coverflow.coverSpacing = 50; 
    
	[self.view addSubview:coverflow];
	[coverflow setNumberOfCovers:[covers count]];
}

#pragma Coverflow delegate methods
- (void) coverflowView:(TKCoverflowView*)coverflowView coverAtIndexWasBroughtToFront:(int)index{
   
}        

- (TKCoverflowCoverView*) coverflowView:(TKCoverflowView*)coverflowView coverAtIndex:(int)index{
	
	TKCoverflowCoverView *cover = [coverflowView dequeueReusableCoverView];
    
	if(cover == nil){
		// Change the covers size here
		cover = [[TKCoverflowCoverView alloc] initWithFrame:CGRectMake(0, 0, 224, 224)]; // 224
        cover.backgroundColor = [UIColor clearColor];
		cover.baseline = 30;
        
        TTCoverFlowImageView* imgView = [[TTCoverFlowImageView alloc] initWithFrame:CGRectMake(0, 0, cover.frame.size.width, cover.frame.size.width)];
        imgView.defaultImage = [UIImage imageNamed:@"photoDefault.png"];
        
        imgView.coverflowView = cover;
        //imgView. = imgView.urlPath;
        [cover setImageView:(UIImageView*)imgView];
	}   

    TTCoverFlowImageView* imgView = (TTCoverFlowImageView*)[cover getImageView];
    imgView.urlPath = [[covers objectAtIndex:index] objectForKey:@"avatar"];
    
    if (imgView.isLoaded) {
        [cover resetImage];
    }
    
	return cover;
	
}
- (void) coverflowView:(TKCoverflowView*)coverflowView coverAtIndexWasDoubleTapped:(int)index{
	
	TKCoverflowCoverView *cover = [coverflowView coverAtIndex:index];
	if(cover == nil) return;

    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"btn_back_txt", nil)  style: UIBarButtonItemStyleBordered target: nil action: nil];
    
    [[self navigationItem] setBackBarButtonItem: newBackButton];
    
    NSDictionary* ss = [covers objectAtIndex:index];
    NSString* shareId = [ss objectForKey:@"id"];
    
    TTURLAction* action = [TTURLAction actionWithURLPath:[NSString stringWithFormat:@"tt://selectedPhoto/%@", shareId]];
    
    action.animated = YES;
    [[TTNavigator navigator] openURLAction:action];
}


- (void)initTopBarTitle {
    // create an array for the buttons
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:2];
    
    UIBarButtonItem *loginBtn = [[UIBarButtonItem alloc]
                                 initWithTitle: NSLocalizedString(@"btn_login_txt", nil) 
                                 style:UIBarButtonItemStyleBordered
                                 target:self
                                 action:@selector(loginAction:)];

    [buttons addObject:loginBtn];
    
    // create a standard delete button with the trash icon
    UIBarButtonItem *registerBtn = [[UIBarButtonItem alloc]
                                    initWithTitle: NSLocalizedString(@"btn_register_txt", nil)
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(registerAction:)];
    
    [buttons addObject:registerBtn];
        
    UIBarButtonItem *fixed1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    UIBarButtonItem *fixed2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:registerBtn, loginBtn, fixed1, fixed2, nil];
    
    NSString *logo = [[NSBundle mainBundle] pathForResource:@"logo" ofType:@"png"];
    
    UIImage *logoImage = [UIImage imageWithContentsOfFile:logo];

    UIImageView *logoView = [[UIImageView alloc] initWithImage:logoImage];
    
    CGRect frame = logoView.frame;
    
        
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    [titleView addSubview:logoView];
    
    self.navigationItem.titleView = titleView;
    
    float screenWidth = self.navigationController.navigationBar.bounds.size.width;
    float titleViewWidth = self.navigationItem.titleView.frame.size.width;
    
    frame.origin.x = - (screenWidth - titleViewWidth)/2 + 10;
    logoView.frame = frame;

}

- (void) requestDidFinishLoad:(TTURLRequest *) request {
    [SVProgressHUD dismiss];
    TTURLJSONResponse *response = request.response;
    NSArray *array = [response.rootObject objectForKey:@"beauty_stars"];
    [self setupCoverFlow:array];
}

- (void) request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
    [SVProgressHUD dismissWithError:NSLocalizedString(@"loading_error", nil)];
    tryAgainLabel.hidden = NO;
    tryAgainButton.hidden = NO;
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
