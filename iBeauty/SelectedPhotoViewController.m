#import "SelectedPhotoViewController.h"
#import "MockPhotoSource.h"
#import "TTStyledCaptionPhotoView.h"

#import <Three20Style/UIColorAdditions.h>
#import <Three20UI/UIViewAdditions.h>
#import <Three20UINavigator/UIViewController+TTNavigator.h>


#import "BaseViewController.h"
#import "SelectedPhotoViewBarButtonViewController.h"

#import "FirstViewController.h"
#import "CommentController.h"
#import "CommentListViewController.h"
#import "extThree20JSON/extThree20JSON.h"
#import "SVProgressHUD.h"
#import "ServiceClient.h"
#import "Constants.h"

@interface TextTestStyleSheet2 : TTDefaultStyleSheet
@end

@implementation TextTestStyleSheet2
- (TTStyle*)blueText {
    return [TTTextStyle styleWithColor:[UIColor blueColor] next:nil];
}

- (TTStyle*)normalText {
    return [TTTextStyle styleWithFont: [UIFont boldSystemFontOfSize:14]
                                color: TTSTYLEVAR(photoCaptionTextColor)
                      minimumFontSize: 0
                          shadowColor: TTSTYLEVAR(photoCaptionTextShadowColor)
                         shadowOffset: TTSTYLEVAR(photoCaptionTextShadowOffset)
                        textAlignment: UITextAlignmentCenter
                    verticalAlignment: UIControlContentVerticalAlignmentCenter
                        lineBreakMode: UILineBreakModeTailTruncation
                        numberOfLines: 6
                                 next: nil];
}

- (TTStyle*)tag {
    return
    [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:6] next:
     [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, -5, -4, -6) next:
      [TTShadowStyle styleWithColor:[UIColor grayColor] blur:2 offset:CGSizeMake(1,1) next:
       [TTSolidFillStyle styleWithColor:[UIColor cyanColor] next:
        [TTSolidBorderStyle styleWithColor:[UIColor grayColor] width:1 next:nil]]]]];
}
@end


@implementation SelectedPhotoViewController

- (id)initWithShareId:(NSInteger)_sharedId {
    if (self = [super init]) {
        shareId = _sharedId;
        
        [SVProgressHUD showWithStatus:NSLocalizedString(@"loading", nil)];
        [[ServiceClient sharedInstance] getSingleShare:shareId delete:self];
    }
    
    return self;
}

- (TTStyle*)myPhotoCaption {
    return
    [TTSolidFillStyle styleWithColor:[UIColor colorWithWhite:0 alpha:0.5] next:
     [TTFourBorderStyle styleWithTop:RGBACOLOR(0, 0, 0, 0.5) width:1 next:
      [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(8, 8, 8, 8) next:
       [TTTextStyle styleWithFont: TTSTYLEVAR(photoCaptionFont)
                            color: [UIColor clearColor]
                  minimumFontSize: 0
                      shadowColor: [UIColor clearColor]
                     shadowOffset: TTSTYLEVAR(photoCaptionTextShadowOffset)
                    textAlignment: UITextAlignmentCenter
                verticalAlignment: UIControlContentVerticalAlignmentCenter
                    lineBreakMode: UILineBreakModeTailTruncation
                    numberOfLines: 6
                             next: nil]]]];}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // set up caption style
        self.captionStyle = [self myPhotoCaption];
        
        btnViewController = [[SelectedPhotoViewBarButtonViewController alloc] initWithNibName:@"SelectedPhotoViewBarButtonViewController" bundle:nil];
        btnViewController.view.frame = CGRectZero;
        
        _photoStatusView.userInteractionEnabled = NO;
    }
    
    return self;
}


- (TTPhotoView*)createPhotoView {
    return (TTPhotoView*)[[TTStyledCaptionPhotoView alloc] init];
}

- (void)viewDidLoad {
    [TTStyleSheet setGlobalStyleSheet:[[TextTestStyleSheet2 alloc] init]];
}

- (void) setupPhotoView:(NSDictionary*)shareObj {
    
//    NSString* kText = @"\
//    <span class=\"normalText\">http://www.google.com This is a test of styled labels.  <span class=\"tag\">Styled</span> labels support \
//    <b>bold text</b>, <i>italic text</i>, <span class=\"blueText\">colored text</span>, \
//    <span class=\"largeText\">font sizes</span></span>";

    NSString *textTemplate = @"<span class='normalText'>%@<br><br>%@";
    
    NSString *tags = [self getTagsText:shareObj];
    
    NSString *kText = [NSString stringWithFormat:textTemplate, [shareObj objectForKey:@"text"], tags]; //    [shareObj objectForKey:@"text"];
    NSLog(@"tags: %@", tags);
    
    self.photoSource = [[MockPhotoSource alloc]
                        initWithType:MockPhotoSourceNormal
                        title:nil
                        photos:[NSArray arrayWithObjects:
                            [[MockPhoto alloc]
                                 initWithURL:[shareObj objectForKey:@"picture_url"]
                                 smallURL:[shareObj objectForKey:@"picture_url"]
                                 size:CGSizeMake(320, 480)
                                 caption:kText], nil]
                        photos2:nil ];
}

- (NSString*) getTagsText:(NSDictionary*) shareObj {
    NSMutableString *tagString = [[NSMutableString alloc] init];

    NSArray* tag = [shareObj objectForKey:@"tag"];
    
    for(NSString* s in tag) {
        [tagString appendFormat:[NSString stringWithFormat:@"<span class='tag'>%@</span>   ", s]];
    }
    
    return tagString;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIBarButtonItem *sharedBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(post)];
    
    self.navigationItem.rightBarButtonItem = sharedBtn;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadView {
    [super loadView];

    [self getBottomBarItem];
    
    UIToolbar* tool = (UIToolbar*)[super rotatingFooterView];
    
    [likeBtn addTarget:self action:@selector(doLike) forControlEvents:UIControlEventTouchDown];

    [commentBtn addTarget:self action:@selector(post) forControlEvents:UIControlEventTouchDown];

    [numberBtn addTarget:self action:@selector(doShowComment) forControlEvents:UIControlEventTouchDown];

    [self applyBottomBarText];
    
    tool.items = [NSArray arrayWithObjects:[btnViewController likeBarButton], [btnViewController commentBarButton], [btnViewController numberBarButton], nil];        
    
    _scrollView.backgroundColor = BACKGROUND_COLOR;
    
    defaultImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photoDefault.png"]];
}

- (void)doLike {
    NSLog(@"btn click");
}

- (void)doShowComment {
    CommentListViewController *commentList = [[CommentListViewController alloc]init];
    [self.navigationController pushViewController:commentList animated:YES];
}

- (void) getBottomBarItem {
    likeBtn = btnViewController.likeBtn;
    likeBtnView = btnViewController.likeBtnView;
    CGRect f = likeBtnView.frame;
    f.origin.x = 0; f.origin.y = 0;
    likeBtnView.frame = f;
    
    likeLabel = btnViewController.likeLabel;

    commentBtn = btnViewController.commentBtn;
    commentBtnView = btnViewController.commentBtnView;
    commentLabel = btnViewController.commentLabel;
    
    numberBtn = btnViewController.numberBtn;
    numberBtnView = btnViewController.numberBtnView;
    likeNumberLabel = btnViewController.likeNumberLabel;
    commentNumberLabel = btnViewController.commentNumberLabel;
}

- (void) applyBottomBarText {
    BOOL isOn = YES;
    NSString* text = isOn?NSLocalizedString(@"btn_like_txt", nil):NSLocalizedString(@"btn_unlike_txt", nil);
    likeLabel.text = text;
    
    commentLabel.text = NSLocalizedString(@"btn_comment_txt", nil);
    
    NSInteger numberOfLike = 0, numberOfComment = 0;
    likeNumberLabel.text = numberOfLike==0?@"":[NSString stringWithFormat:@"%d", numberOfLike];
    commentNumberLabel.text = numberOfComment==0?@"":[NSString stringWithFormat:@"%d", numberOfComment];

}

- (void)scrollViewWillBeginDragging:(TTScrollView *)scrollView {
    // disabled
}

- (void)post{
    CommentController *viewToGo = [[CommentController alloc] init];
	self.popupViewController = viewToGo;
	viewToGo.superController = self;
	viewToGo.delegate = self;
	viewToGo.textView.text = @"";
	viewToGo.title = NSLocalizedString(@"btn_comment_txt", nil);
	
	[viewToGo showInView:self.view animated:YES];
	// [viewToGo release];
}

- (void) requestDidFinishLoad:(TTURLRequest *) request {
    [SVProgressHUD dismiss];
    [defaultImageView removeFromSuperview];
    
    TTURLJSONResponse *response = request.response;
    NSArray *array = [response.rootObject objectForKey:@"shares"];
    
    if ([array count]>0) {
        [self setupPhotoView:[array objectAtIndex:0]];
    }
}

- (void) request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
    [SVProgressHUD dismissWithError:NSLocalizedString(@"loading_error", nil)];
    
    [self.view addSubview:defaultImageView];
    [defaultImageView setCenter:self.view.center];
    
    [self showEmpty:NO];
}

@end
