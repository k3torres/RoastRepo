//
//  RoastAppMenuItemViewController.h
//  Roast
//
//  Created by Nicholas Variz on 2/24/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoastAppShopItem.h"

@interface RoastAppMenuItemViewController : UIViewController

@property (strong, nonatomic) RoastAppShopItem *item;
@property (strong, nonatomic) UIImage *image;
@end
