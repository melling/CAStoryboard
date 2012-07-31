//
//  CardView.h
//  CAStoryboard
//
//  Created by Michael Mellinger on 7/24/12.
//  Copyright (c) 2012 Michael Mellinger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CardView : UIView {
//    CATransformLayer *cardContainer;
    UIView *cardFront;
    UIView *cardBack;
//    CATextLayer *cardBackText;
    
}

- (IBAction)flipCard;

@end
