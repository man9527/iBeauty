//
//  TKCoverView.m
//  Created by Devin Ross on 1/3/10.
//
/*
 
 tapku.com || http://github.com/devinross/tapkulibrary
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "TKCoverflowCoverView.h"
#import "UIImage+TKCategory.h"
#import "TKGlobal.h"


@implementation TKCoverflowCoverView
@synthesize baseline,gradientLayer;


- (id) initWithFrame:(CGRect)frame {
    if(!(self=[super initWithFrame:frame])) return nil;
    
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
    self.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    reflected =  [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.width, self.frame.size.width, self.frame.size.width)];
    reflected.transform = CGAffineTransformScale(reflected.transform, 1, -1);
    [self addSubview:reflected];

    gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithWhite:0 alpha:0.5].CGColor,(id)[UIColor colorWithWhite:0 alpha:1].CGColor,nil];
    gradientLayer.startPoint = CGPointMake(0,0);
    gradientLayer.endPoint = CGPointMake(0,0.3);
    gradientLayer.frame = CGRectMake(0, self.frame.size.width, self.frame.size.width, self.frame.size.width);
    [self.layer addSublayer:gradientLayer];
    
    return self;
}


- (void) setImage:(UIImage *)img withView:(UIImageView*)imgView{
	
    imageView = imgView;
    imageView.userInteractionEnabled = FALSE;
        
	UIImage *image = img;
	
	float w = image.size.width;
	float h = image.size.height;
	//float factor = self.bounds.size.width / (h>w?h:w);
    float factor = self.bounds.size.width / w;
	h = factor * h;
	w = factor * w;
	
    float y = baseline - h > 0 ? baseline - h : 0;
	
	imageView.frame = CGRectMake(0, y, w, h);
	imageView.image = image;
		
    self.frame = imageView.frame;
    
    [imageView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [imageView.layer setBorderWidth: 6.0];
    [imageView.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    [imageView.layer setShadowRadius:2.0];
    [imageView.layer setShadowOpacity:1.0];
    
	gradientLayer.frame = CGRectMake(0, y + h, w, h);
	
	reflected.frame = CGRectMake(0, y + h, w, h);
	reflected.image = image;
}
- (UIImageView*) getImageView {
    return imageView;
}

- (void) setImageView:(UIImageView*)imgView{
	
    imageView = imgView;
    imageView.userInteractionEnabled = FALSE;
    [self addSubview:imageView];

    [self resetImage];
//    UIImage *image = imageView.image;
//    
//    float w = image.size.width;
//    float h = image.size.height;
//    float factor = self.bounds.size.width / w;
//    h = factor * h;
//    w = factor * w;
//	
//    float y = baseline - h > 0 ? baseline - h : 0;
//	
//    imageView.frame = CGRectMake(0, y, w, h);
//    //imageView.image = image;
//    
//    self.frame = imageView.frame;
////    CGRect frame = self.frame;
////    frame.origin.y = frame.origin.y - (h - frame.size.height);
////    NSLog(@"new y %f", frame.origin.y);
////    self.frame = frame;
//    
//    // border and shadow
//    [imageView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
//    [imageView.layer setBorderWidth: 6.0];
//    [imageView.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
//    [imageView.layer setShadowRadius:2.0];
//    [imageView.layer setShadowOpacity:1.0];
//    
//    gradientLayer.frame = CGRectMake(0, y + h, w, h);
//	
//    reflected.frame = CGRectMake(0, y + h, w, h);
//    reflected.image = image;
}

- (void)resetImage {
    @synchronized(self) {
    if (nil!=imageView) {
        
        UIImage *image = imageView.image;
        
        float w = image.size.width;
        float h = image.size.height;
        float factor = self.bounds.size.width / w;
        h = factor * h;
        w = factor * w;
	
//        float y = baseline - h > 0 ? baseline - h : 0;
        CGRect frame = self.frame;
        float y = 0 - (h-frame.size.height);
        
//        if (frame.origin.y + y < 0) {
//            y = y - (frame.origin.y + y);
//        }
        
        imageView.frame = CGRectMake(0, y, w, h);
        //NSLog(@"second load %@", imageView.description);
        //imageView.image = image;
    
        //self.frame = imageView.frame;
        //CGRect frame = self.frame;
        //frame.origin.y = frame.origin.y - (h - frame.size.height);
        //NSLog(@"new y %f", frame.origin.y);
        //self.frame = frame;
        
        // border and shadow
        [imageView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
        [imageView.layer setBorderWidth: 6.0];
        [imageView.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
        [imageView.layer setShadowRadius:2.0];
        [imageView.layer setShadowOpacity:1.0];
    
        gradientLayer.frame = CGRectMake(0, y + h, w, h);
	
        reflected.frame = CGRectMake(0, y + h, w, h);
        reflected.image = image;
    }
    }
}

- (UIImage*) image{
	return imageView.image;
}
- (void) setBaseline:(float)f{
	baseline = f;
	[self setNeedsDisplay];
}

@end
