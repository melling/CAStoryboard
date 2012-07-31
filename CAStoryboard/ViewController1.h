//
//  ViewController1.h
//  CAStoryboard
//
//  Created by Michael Mellinger on 7/16/12.
//  Copyright (c) 2012 Michael Mellinger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CardView.h"

@interface ViewController1 : UIViewController {
    CALayer *pulseLayer_;
    CALayer *moneyLayer_;

    CALayer *hangmanLayer_;
    CATransformLayer *cardContainer;
    CardView *card1_;
    
//    CALayer *cardFront;
//    CALayer *cardBack;

}

@end
