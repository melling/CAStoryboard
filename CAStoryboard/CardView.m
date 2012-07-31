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
 
 http://ideiasbynavarro.blogspot.com/2011/09/ios-quick-tips-flip-animation.html
 
 http://www.iphonedevsdk.com/forum/iphone-sdk-development/6078-detect-end-startanimating-animation.html
 
 http://www.raywenderlich.com/forums/viewtopic.php?t=2145&p=13845
 
 http://www.jedimobile.com/mediawiki/index.php?title=Building_Animations
 */

- (IBAction)flipCard {
    
//    NSLog(@"UIView Tag: %d", sender.tag);
    
//    float x = sender.frame.origin.x;
//    float y = sender.frame.origin.y;
//    UIView *currentBackBtn = cardBack;
//    UIView *currentFrontBtn = cardFront;
    
//    NSLog(@"x=%f, y=%f", x, y);
  /*
    if (sender.tag==50) {
        
        NSLog(@"Text...");
        currentFrontBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        currentFrontBtn.frame = CGRectMake(x, y, 115, 70.0);
        currentFrontBtn.alpha = 0.0;
        [currentFrontBtn setTitle:@"Hola" forState:UIControlStateNormal];
        [self.view addSubview:currentFrontBtn];
        
        //        [currentFrontBtn]
        
    } else if (sender.tag==30) {
        // Button already created
        currentFrontBtn = holaButton;
    } else if (sender.tag==100) {
        NSLog(@"Doing first button");
        currentFrontBtn = (UIButton *)[self.view viewWithTag:115];
        
    } else {
        //        UIImage *redButtonImage = [UIImage imageNamed:@"yellow.png"];
        UIImage *redButtonImage = [UIImage imageNamed:@"diamond.png"];
        
        currentFrontBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        currentFrontBtn.frame = CGRectMake(x, y, 115, 70.0);
        currentFrontBtn.alpha = 0.0;
        [currentFrontBtn setBackgroundImage:redButtonImage forState:UIControlStateNormal];
        [self.view addSubview:currentFrontBtn];
        
    }
 */
    
    [UIView transitionWithView:cardBack
                      duration:1.5
                       options:UIViewAnimationOptionTransitionFlipFromRight|UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        [cardFront setAlpha:0.0];
                        [cardBack setAlpha:1.0];
                    } completion:^(BOOL finished){}];
    
    
    [UIView transitionWithView:cardFront duration:1.5
                       options:UIViewAnimationOptionTransitionFlipFromRight|UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        [cardFront setAlpha:1.0];
                        [cardBack setAlpha:0.0];
                    }
                    completion:^(BOOL finished){}];
    
    
    
#define TIMER_REFRESH 2
    [self performSelector:@selector(flipCardToBack) withObject:nil afterDelay:3];
    
    //    [NSTimer scheduledTimerWithTimeInterval:(TIMER_REFRESH) target:self selector:@selector(flipCardToBack) userInfo:nil repeats:NO];
}

- (void)flipCardToBack {
    
    [UIView transitionWithView:cardFront duration:1.5
            
                       options:UIViewAnimationOptionTransitionFlipFromLeft|UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        [cardFront setAlpha:1.0];
                        [cardBack setAlpha:0.0];
                    } completion:^(BOOL finished){}];
    
    [UIView transitionWithView:cardBack duration:1.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft|UIViewAnimationOptionCurveEaseInOut
                    animations:^{}
                    completion:^(BOOL finished){}];
    
}
/*
 http://stackoverflow.com/questions/4754392/uiview-with-rounded-corners-and-drop-shadow
 
 http://stackoverflow.com/questions/1509547/uiview-with-rounded-corners
 
 */
- (void)loadView {
//    self.backgroundColor = [UIColor purpleColor];
    
    cardFront = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    cardBack = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    cardBack.backgroundColor = [UIColor greenColor];
    cardFront.backgroundColor = [UIColor orangeColor];
    
    [self addSubview:cardBack];
    [self addSubview:cardFront];
//    UIView *myView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.backgroundColor = [UIColor whiteColor];
    
//    [self  = myView;
 /*
  
    cardContainer = [CATransformLayer layer];
    cardContainer.frame = self.frame;
//    CGRectMake(200, 250, 200, 150);
    
    
    cardFront  = [CALayer layer];
    cardFront.frame     = cardContainer.bounds;
    cardFront.zPosition = 5;   // Higher than the zPosition of the back of the card
    cardFront.contents  = (id)[UIImage imageNamed:@"Steve"].CGImage;
    cardFront.opacity = 0.5;
    
    [cardContainer addSublayer:cardFront];
  
     http://stackoverflow.com/questions/2209734/add-text-to-calayer
  
     */
    /*
    cardBack  = [UIView alloc] initWithFrame:CGRectMake(200, 250, 200, 150);
//    cardBack.frame     = cardContainer.bounds;
//    cardBack.zPosition = 4;
    //    cardBack.contents  = (id)[UIImage imageNamed:@"Ben"].CGImage; // You may need to mirror this image
    cardBack.backgroundColor = [[UIColor grayColor] CGColor];
    
    [cardContainer addSublayer: cardBack];
    
    cardBackText  = [CATextLayer layer];
    // http://stackoverflow.com/questions/3815443/how-to-get-text-in-a-catextlayer-to-be-clear
    

// http://www.taffysoft.com/pages/20120202-01.html
    
    cardBackText.contentsScale = [[UIScreen mainScreen] scale];
    cardBackText.position = self.center;
    cardBackText.position = CGPointMake(40, 50);
    //    cardBackText.position = cardBack.contentsCenter.origin;
    
    cardBackText.string = @"Hello";
    //    cardBack.frame = CGRectMake(0.f, 10.f, cardContainer.frame.size.width, cardContainer.frame.size.height / 10.f);
    cardBackText.frame     = CGRectMake(0, 0, 100, 30.f);;
//    cardBackText.zPosition = 4;
//    cardBackText.backgroundColor = [[UIColor grayColor] CGColor];
//    cardBack.transform = CATransform3DMakeRotation(M_PI, 1.0f, 0.0f, 0.0f); // Pre-flip card
//    cardBackText.geometryFlipped = YES;
    cardBackText.alignmentMode = kCAAlignmentCenter;
    CFTypeRef *font = (CFTypeRef *)CTFontCreateWithName(CFSTR("Times"), 48, NULL);
    cardBackText.font = font;
    //    cardFront.opacity = 0.95;
    
    [cardBack addSublayer: cardBackText];
    //    cardBack.position = CGPointMake(0.f,5.f);
    
    [self.layer addSublayer:cardContainer];
    

    
    
    
    //    [cardContainer setNeedsDisplay];
    
     
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
