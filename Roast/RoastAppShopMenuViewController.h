//
//  RoastAppShopMenuViewController.h
//  Roast
//
//  Created by Nicholas Variz on 2/10/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoastAppShopMenuViewController : UITableViewController

@property NSMutableArray *descriptions;
@property NSMutableArray *names;
@property NSMutableArray *prices;
@property NSMutableArray *types;
@property (strong, nonatomic) NSString *menuChoice;
@property (strong, nonatomic) NSString *shopChoice;

@end
