//
//  ViewController1.m
//  CAStoryboard
//
//  Created by Michael Mellinger on 7/16/12.
//  Copyright (c) 2012 Michael Mellinger. All rights reserved.
//


#import "ViewController1.h"
#import <QuartzCore/QuartzCore.h>

//#import <CoreText/CoreText.h>

// Useful macros

#define UIColorFromRGBA(rgbValue, alphaValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]


//@interface ViewController1 ()
//
//@end

static int count=1;

@implementation ViewController1

+ (NSString *)friendlyName {
    return @"Layer Stuff";
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = [[self class] friendlyName];

        // Custom initialization
    }
    return self;
}

-(void)drawButtonRow:(NSString *)alphabet xLoc:(CGFloat)x yLoc:(CGFloat)y
          letterSize:(CGFloat)letterSize
     keySpacingDelta:(CGFloat)keyDelta {
    UIButton *button1;

    for (int i=0; i < [alphabet length]; i++) {
        NSUInteger idx = (NSUInteger)i;
        unichar aLetter = [alphabet characterAtIndex:idx];
        NSString *aTitle = [NSString stringWithCharacters:&aLetter length:1];
        button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];;
        button1.frame = CGRectMake(x, y, letterSize, letterSize);
        [button1 setTitle:aTitle forState:UIControlStateNormal];
        [button1 setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
        [button1 addTarget:self action:@selector(letterPressed:) forControlEvents:UIControlEventTouchUpInside];
        x += keyDelta;
        [self.view addSubview:button1];
    }
    
}

-(void)drawButtons {
    
    CGFloat keySpacingDelta = 70.0;
    CGFloat letterSize = 55;
    CGFloat x = 25;
    CGFloat y = 450;

    NSArray* names = @[@"QWERTYUIOP", @"ASDFGHJKL", @"ZXCVBNM"];
    for (NSString* row in names) {
        
        [self drawButtonRow:row xLoc:x yLoc:y
                 letterSize:letterSize
            keySpacingDelta:keySpacingDelta];
        
        x += keySpacingDelta/2.0;
        y += keySpacingDelta;
        
    }

}


-(void)letterPressed:(UIButton *)sender {
    NSLog(@"Letter Pressed");
    NSString *aLetter = [[sender titleLabel] text];
    NSLog(@"%@", aLetter);
//    layer.contents = (id)[[UIImage imageNamed:@"Ben.png"] CGImage];

    int i = [[moneyLayer_ valueForKey:@"moneyImageIsBen"] intValue];
    i = (i + 1) % 2;
    
    [moneyLayer_ setValue:[NSNumber numberWithInt:i] forKey:@"moneyImageIsBen"];
    [moneyLayer_ setNeedsDisplay];
    [self flipCard];


}

/*
 http://stackoverflow.com/questions/573372/how-to-get-touch-event-on-a-calayer

*/

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([touches count] == 1) {
        for (UITouch *touch in touches) {
            CGPoint point = [touch locationInView:[touch view]];
            point = [[touch view] convertPoint:point toView:nil];
            int tag = [[touch view] tag];
            NSLog(@"Touches tag: %d", tag);
            // point = [[touch view] convertPoint:point toView:self.view];

            CALayer *layer = [(CALayer *)self.view.layer.presentationLayer hitTest:point];
            
            layer = layer.modelLayer;
            layer.opacity = 0.5;
        }
    }
}

/*
 
 http://stackoverflow.com/questions/3831867/trying-to-make-a-card-from-calayers-that-can-flip-over
 
 http://stackoverflow.com/questions/7128829/could-i-get-a-basic-explanation-of-catransform3didentity
 
 http://stackoverflow.com/questions/3799194/how-to-make-a-catransform3dmakerotation-rotate-the-other-way-and-chain-together
 
 */

- (void) flipCard {
//    [self.flipTimer invalidate];
//    if (flipped){
//        return;
//    }
    NSLog(@"Count=%d", count);
    id animationsBlock = ^{
//        self.backView.alpha = 1.0f;
//        self.frontView.alpha = 0.0f;
//        [self bringSubviewToFront:self.frontView];
//        flipped = YES;
        NSLog(@"Flipping...");
        CALayer *layer = cardContainer;
        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;

        if (count == 0) {
            rotationAndPerspectiveTransform.m34 = 1.0 / 500;

            rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, M_PI, 1.0f, 0.0f, 0.0f);
        } else {
            rotationAndPerspectiveTransform.m34 = 1.0 / 500;

            rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 0.0f, 0.0f, 1.0f, 1.0f);
            
        }
        layer.transform = rotationAndPerspectiveTransform;
    };
    count = (count + 1) % 2;

    [UIView animateWithDuration:1.25
                          delay:0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:animationsBlock
                     completion:nil];
    
}


#pragma mark Load and unload the view

/*
 
 http://stackoverflow.com/questions/3831867/trying-to-make-a-card-from-calayers-that-can-flip-over
 
 http://gentlebytes.com/2012/02/scrolling-credits/
 
 */
- (void)loadView {
    


    UIView *myView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    myView.backgroundColor = [UIColor blueColor];
    myView.tag = 99;
    
    self.view = myView;
    
//    card1 = [[CardView alloc] initWithFrame:CGRectMake(10, 25, 200, 150)];
//    card1.tag = 22;
    
//    CardView *card2 = [[CardView alloc] initWithFrame:CGRectMake(225, 25, 200, 150)];
//    card2.tag = 23;
//    [myView addSubview:card1];
//    [myView addSubview:card2];
    
    cardContainer = [CATransformLayer layer];
    cardContainer.frame = CGRectMake(200, 250, 200, 150);
//    cardContainer.cornerRadius = 25.f;
    
    CALayer *cardFront  = [CALayer layer];
    cardFront.frame     = cardContainer.bounds;
    cardFront.cornerRadius = 25.f;

    cardFront.zPosition = 5;   // Higher than the zPosition of the back of the card
    cardFront.contents  = (id)[UIImage imageNamed:@"Ben"].CGImage;
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
    cardBack.cornerRadius = 25.f;
    [cardContainer addSublayer: cardBack];
    
    CATextLayer *cardBackText  = [CATextLayer layer];
    // http://stackoverflow.com/questions/3815443/how-to-get-text-in-a-catextlayer-to-be-clear
    
    http://www.taffysoft.com/pages/20120202-01.html
    
    cardBackText.contentsScale = [[UIScreen mainScreen] scale];
    cardBackText.position = self.view.center;
    cardBackText.position = CGPointMake(40, 50);
//    cardBackText.position = cardBack.contentsCenter.origin;

    cardBackText.string = @"Hello";
//    cardBack.frame = CGRectMake(0.f, 10.f, cardContainer.frame.size.width, cardContainer.frame.size.height / 10.f);
    cardBackText.frame     = CGRectMake(55, 60, 100, 30.f);;
    cardBackText.zPosition = 4;
    cardBackText.backgroundColor = [[UIColor greenColor] CGColor];
    cardBack.transform = CATransform3DMakeRotation(M_PI, 1.0f, 0.0f, 0.0f); // Pre-flip card
    cardBackText.geometryFlipped = YES;
    cardBackText.alignmentMode = kCAAlignmentCenter;
    CFTypeRef *font = (CFTypeRef *)CTFontCreateWithName(CFSTR("Times"), 48, NULL);
    cardBackText.font = font;
//    cardFront.opacity = 0.95;

    [cardBack addSublayer: cardBackText];
//    cardBack.position = CGPointMake(0.f,5.f);

    [self.view.layer addSublayer:cardContainer];
    
  
//    [cardContainer setNeedsDisplay];
    /*
     
     http://simplyhacking.com/core-animation-layered-clock.html
     
     */
    
    // Clock


}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self drawButtons];
  
}
    
- (void)viewWillAppear:(BOOL)animated {
    pulseLayer_.backgroundColor = [UIColorFromRGBA(0x000000, .75) CGColor];
    pulseLayer_.bounds = CGRectMake(0., 0., 300, 300.);
    pulseLayer_.cornerRadius = 12.;
    pulseLayer_.position = self.view.center; // Simply ask view for its center
    
    CGPoint p;
    p.x = self.view.center.x;
    p.y = self.view.center.y - 300;

    pulseLayer_.position = p;
    [pulseLayer_ setNeedsDisplay];
    
    moneyLayer_.backgroundColor = [[UIColor clearColor] CGColor];
    moneyLayer_.bounds = CGRectMake(0., 0., 290., 125.);
    moneyLayer_.position = p;
    moneyLayer_.delegate = self;
    [moneyLayer_ setValue:[NSNumber numberWithInt:0] forKey:@"moneyImageIsBen"];
    [moneyLayer_ setNeedsDisplay];
    
    // -------------
    
    p.x = 150;
    p.y = 150;
    hangmanLayer_.backgroundColor = [[UIColor greenColor] CGColor];
    hangmanLayer_.bounds = CGRectMake(0., 0., 200., 200);
    hangmanLayer_.position = p;
    hangmanLayer_.delegate = self;

    [hangmanLayer_ setNeedsDisplay];

}


- (void)viewDidAppear:(BOOL)animated {
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulseAnimation.duration = .5;
    pulseAnimation.toValue = [NSNumber numberWithFloat:1.1];
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulseAnimation.autoreverses = YES;
    pulseAnimation.repeatCount = FLT_MAX;
    
    [pulseLayer_ addAnimation:pulseAnimation forKey:nil];
}

- (void)displayLayer:(CALayer *)layer {
    if(layer == moneyLayer_) {
        if([[layer valueForKey:@"moneyImageIsBen"] intValue] == 0) {
            layer.contents = (id)[[UIImage imageNamed:@"Ben.png"] CGImage];
        } else if([[layer valueForKey:@"moneyImageIsBen"] intValue] == 1) {

            layer.contents = (id)[[UIImage imageNamed:@"Steve.png"] CGImage];
        }
    } else if(layer == hangmanLayer_) {
        layer.contents = (id)[[UIImage imageNamed:@"Steve.png"] CGImage];
        
    }

    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
