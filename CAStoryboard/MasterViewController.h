//
//  MasterViewController.h
//  CAStoryboard
//
//  Created by Michael Mellinger on 7/15/12.
//  Copyright (c) 2012 Michael Mellinger. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
