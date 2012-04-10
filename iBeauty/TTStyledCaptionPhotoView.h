//
//  TTStyledCaptionPhotoView.h
//  iBeauty
//
//  Created by William Chu on 12/2/20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
#import <Three20UI/TTImageView.h>
#import <Three20UI/TTPhotoVersion.h>
#import <Three20UI/TTImageViewDelegate.h>
#import <Three20UI/TTStyledTextLabel.h>
#import <Three20Style/TTStyledText.h>

@protocol TTPhoto;
@class TTLabel;

@interface TTStyledCaptionPhotoView : TTImageView <TTImageViewDelegate> {
    id <TTPhoto>              _photo;
    UIActivityIndicatorView*  _statusSpinner;
    
    TTLabel* _statusLabel;
    TTLabel* _captionLabel;
    TTStyledTextLabel* _label1;
    TTStyle* _captionStyle;
    
    TTPhotoVersion _photoVersion;
    
    BOOL _hidesExtras;
    BOOL _hidesCaption;
}

@property (nonatomic, retain) id<TTPhoto> photo;
@property (nonatomic, retain) TTStyle*    captionStyle;
@property (nonatomic)         BOOL        hidesExtras;
@property (nonatomic)         BOOL        hidesCaption;

- (BOOL)loadPreview:(BOOL)fromNetwork;
- (void)loadImage;

- (void)showProgress:(CGFloat)progress;
- (void)showStatus:(NSString*)text;

@end

