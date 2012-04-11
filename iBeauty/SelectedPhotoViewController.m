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
@end


@implementation SelectedPhotoViewController

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
    <span class=\"normalText\"><a href='http://ddd'>This is a test of styled labels</a>.  Styled labels support \
    <b>bold text</b>, <i>italic text</i>, <span class=\"blueText\">colored text</span>, \
    <span class=\"largeText\">font sizes</span></span>";
    
    self.photoSource = [[MockPhotoSource alloc]
                         initWithType:MockPhotoSourceNormal
                         title:@""
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
    
//    for (UIView *view in tool.subviews) {
//        [view removeFromSuperview];
//    }
    
    // create a standard delete button with the trash icon
    UIBarButtonItem *registerBtn = [[UIBarButtonItem alloc]
                                    initWithTitle:@"讚"
                                    style:UIBarButtonItemStyleBordered
                                    target:@"tt://post"
                                    action:@selector(openURLFromButton:)];    
    tool.items = [NSArray arrayWithObjects:
                  registerBtn, nil];    
    
}

- (UIViewController*)post:(NSDictionary*)query {
    TTPostController* controller = [[TTPostController alloc] initWithNavigatorURL:nil query:
                                     [NSDictionary dictionaryWithObjectsAndKeys:@"Default Text", @"text", nil]];
                                    
    controller.originView = [query objectForKey:@"__target__"];
    return controller;
}
@end
