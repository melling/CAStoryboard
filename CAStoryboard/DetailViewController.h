//
//  DetailViewController.h
//  CAStoryboard
//
//  Created by Michael Mellinger on 7/15/12.
//  Copyright (c) 2012 Michael Mellinger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UIButton *button2;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
