//
//  KMMasterViewController.h
//  BlockPatternExampleNoArc
//
//  Created by Kim Hunter on 11/11/12.
//  Copyright (c) 2012 Kim Hunter. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KMDetailViewController;

@interface KMMasterViewController : UITableViewController

@property (strong, nonatomic) KMDetailViewController *detailViewController;

@end
