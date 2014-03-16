//
//  RoastAppFeedViewController.h
//  Roast
//
//  Created by Alexander Kissinger on 1/24/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoastAppFeedService.h"

@interface RoastAppFeedViewController : UITableViewController

@property NSMutableArray *feedItems;
@property RoastAppFeedService *feedService;
@property NSString *feedDateFormat;
@property UIRefreshControl *refreshControl;
@property (strong, nonatomic) IBOutlet UITableView *feedViewTable;
@property NSMutableArray *tabViewControllers;

@end
