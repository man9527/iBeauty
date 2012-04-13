#import "SelectedPhotoViewController.h"
#import "MockPhotoSource.h"
#import "TTStyledCaptionPhotoView.h"

#import <Three20Style/UIColorAdditions.h>
#import <Three20UI/UIViewAdditions.h>
#import <Three20UINavigator/UIViewController+TTNavigator.h>

#import "BaseViewController.h"

@interface TextTestStyleSheet2 : TTDefaultStyleSheet
@end

@implementation TextTestStyleSheet2

- (TTStyle*)blueText {
    return [TTTextStyle styleWithColor:[UIColor blueColor] next:nil];
}

- (TTStyle*)normalText {
    return [TTTextStyle styleWithFont: TTSTYLEVAR(photoCaptionFont)
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

@synthesize likeBtn = _likeBtn, commentBtn = _commentBtn;

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
        self.captionStyle = [self myPhotoCaption];
    }
    
    return self;
}


- (TTPhotoView*)createPhotoView {
    return (TTPhotoView*)[[TTStyledCaptionPhotoView alloc] init];
}

- (void)viewDidLoad {
    [[TTNavigator navigator].URLMap from:@"tt://post"
                        toViewController:self selector:@selector(post:)];
    
    [TTStyleSheet setGlobalStyleSheet:[[TextTestStyleSheet2 alloc] init]];
    
    NSString* kText = @"\
    <span class=\"normalText\"><a href='http://ddd'>This is a test of styled labels</a>.  <span class=\"tag\">Styled</span> labels support \
    <b>bold text</b>, <i>italic text</i>, <span class=\"blueText\">colored text</span>, \
    <span class=\"largeText\">font sizes</span></span>";
    
    self.photoSource = [[MockPhotoSource alloc]
                         initWithType:MockPhotoSourceNormal
                         title:nil
                         photos:[NSArray arrayWithObjects:
                                 // Request fails immediately due to DNS error
                                 
                                 [[MockPhoto alloc]
                                   initWithURL:@"http://localhost:8080/demo/photo01.png"
                                   smallURL:@"http://localhost:8080/demo/photo01.png"
                                   size:CGSizeMake(320, 480)
                                   caption:kText], nil]
                         photos2:nil ];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadView {
    [super loadView];
    
    UIToolbar *tool = (UIToolbar*)[super rotatingFooterView];
    
    // create a standard delete button with the trash icon
    _likeBtn = [self createLikeBtn:YES];
    
    tool.items = [NSArray arrayWithObjects:
                  _likeBtn, nil];    
    
}

- (UIBarButtonItem*) createLikeBtn:(BOOL)isOn {
    
    NSString* text = isOn?NSLocalizedString(@"btn_like_txt", nil):NSLocalizedString(@"btn_unlike_txt", nil);
    UIImage *chatImage = [UIImage imageNamed:@"like_off.png"];
    UIImageView *iview = [[UIImageView alloc] initWithImage:chatImage];
    UILabel *l = [[UILabel alloc] init];
    l.text = text;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    [view addSubview:iview];
    [view addSubview:l];
    
//    UIButton *chatButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [chatButton setBackgroundImage:chatImage forState:UIControlStateNormal];
//    [chatButton setTitle:text forState:UIControlStateNormal];
//    chatButton.frame = (CGRect) {
//        .size.width = 100,
//        .size.height = 30,
//    };

    
//    TTButton *newsButton = [TTButton buttonWithStyle:@"redToolbarButton:"]; 
//    [newsButton setTitle:NSLocalizedString(@"Новости",nil) forState:UIControlStateNormal]; 
//    
//    [newsButton addTarget:self action:@selector(newsButtonClick:) forControlEvents:UIControlEventTouchUpInside]; 
//    newsButton.frame = CGRectMake(70, 80, 150, 50); 
//    
//    UIImageView *butImg2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"like_off.png"]]; 
//    [newsButton addSubview:butImg2]; 
//    [newsButton sizeToFit];
//    
//    TTButton* storyButton = [TTButton buttonWithStyle:@"toolbarRoundButton:" title:@"Open Full Story"];
//    storyButton.font = [UIFont boldSystemFontOfSize:18];
//    storyButton.frame = CGRectMake(100, 100, 200, 50);
//    
//    [storyButton addTarget:self action:@selector(presentFullStory) forControlEvents:UIControlEventTouchUpInside];
//    [storyButton sizeToFit];
    
    UIBarButtonItem *b = [[UIBarButtonItem alloc] initWithCustomView:l];
     b.target=@"tt://post";
     b.action=@selector(openURLFromButton:);  
    
    b.title = text;
    [l sizeToFit];
    
    return b;
}

- (UIViewController*)post:(NSDictionary*)query {
    TTPostController* controller = [[TTPostController alloc] initWithNavigatorURL:nil query:
                                     [NSDictionary dictionaryWithObjectsAndKeys:@"Default Text", @"text", nil]];
                                    
    controller.originView = [query objectForKey:@"__target__"];
    return controller;
}
@end
