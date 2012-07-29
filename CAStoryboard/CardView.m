//
//  CardView.m
//  CAStoryboard
//
//  Created by Michael Mellinger on 7/24/12.
//  Copyright (c) 2012 Michael Mellinger. All rights reserved.
//

#import "CardView.h"

@implementation CardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
        NSLog(@"CardView Loaded");
        // Initialization code
    }
    return self;
}

/*
 http://stackoverflow.com/questions/4754392/uiview-with-rounded-corners-and-drop-shadow
 
 http://stackoverflow.com/questions/1509547/uiview-with-rounded-corners
 
 */
- (void)loadView {
//    UIView *myView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.backgroundColor = [UIColor whiteColor];
    
//    [self  = myView;
    
    cardContainer = [CATransformLayer layer];
    cardContainer.frame = self.frame;
//    CGRectMake(200, 250, 200, 150);
    
    
    CALayer *cardFront  = [CALayer layer];
    cardFront.frame     = cardContainer.bounds;
    cardFront.zPosition = 5;   // Higher than the zPosition of the back of the card
    cardFront.contents  = (id)[UIImage imageNamed:@"Steve"].CGImage;
    cardFront.opacity = 0.5;
    
    [cardContainer addSublayer:cardFront];
    
    /*
     http://stackoverflow.com/questions/2209734/add-text-to-calayer
     */
    
    CALayer *cardBack  = [CALayer layer];
    cardBack.frame     = cardContainer.bounds;
    cardBack.zPosition = 4;
    //    cardBack.contents  = (id)[UIImage imageNamed:@"Ben"].CGImage; // You may need to mirror this image
    cardBack.backgroundColor = [[UIColor grayColor] CGColor];
    
    [cardContainer addSublayer: cardBack];
    
    CATextLayer *cardBackText  = [CATextLayer layer];
    // http://stackoverflow.com/questions/3815443/how-to-get-text-in-a-catextlayer-to-be-clear
    
http://www.taffysoft.com/pages/20120202-01.html
    
    cardBackText.contentsScale = [[UIScreen mainScreen] scale];
    cardBackText.position = self.center;
    cardBackText.position = CGPointMake(40, 50);
    //    cardBackText.position = cardBack.contentsCenter.origin;
    
    cardBackText.string = @"Hello";
    //    cardBack.frame = CGRectMake(0.f, 10.f, cardContainer.frame.size.width, cardContainer.frame.size.height / 10.f);
    cardBackText.frame     = CGRectMake(0, 0, 100, 30.f);;
    cardBackText.zPosition = 4;
    cardBackText.backgroundColor = [[UIColor grayColor] CGColor];
    cardBack.transform = CATransform3DMakeRotation(M_PI, 1.0f, 0.0f, 0.0f); // Pre-flip card
    cardBackText.geometryFlipped = YES;
    cardBackText.alignmentMode = kCAAlignmentCenter;
    CFTypeRef *font = (CFTypeRef *)CTFontCreateWithName(CFSTR("Times"), 48, NULL);
    cardBackText.font = font;
    //    cardFront.opacity = 0.95;
    
    [cardBack addSublayer: cardBackText];
    //    cardBack.position = CGPointMake(0.f,5.f);
    
    [self.layer addSublayer:cardContainer];
    
    
    //
    //    pulseLayer_ = [CALayer layer];
    //    [myView.layer addSublayer:pulseLayer_];
    //
    //
    //    moneyLayer_ = [CALayer layer];
    //
    ////    [myView.layer addSublayer:moneyLayer_];
    //    [self.view.layer addSublayer:moneyLayer_];
    //
    //    hangmanLayer_ = [CALayer layer];
    //    [self.view.layer addSublayer:hangmanLayer_];
    //
    //    // -----------------
    //
    //    CALayer *rootLayer;
    //    rootLayer = [CALayer layer];
    //    rootLayer.bounds = CGRectMake(0, 0, 256, 256);
    //    rootLayer.position = CGPointMake(0,0);
    //    rootLayer.backgroundColor = [[UIColor redColor] CGColor];
    //
    ////    rootLayer.backgroundColor = [UIColor greenColor];
    //    [self.view.layer addSublayer:rootLayer];
    //    [rootLayer setNeedsDisplay];
    
    //
    
    
    
    
    //    [cardContainer setNeedsDisplay];
    /*
     
     http://simplyhacking.com/core-animation-layered-clock.html
     
     */
    
    // Clock
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
