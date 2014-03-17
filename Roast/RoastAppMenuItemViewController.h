//
//  RoastAppMenuItemViewController.h
//  Roast
//
//  Created by Nicholas Variz on 2/24/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoastAppShopItem.h"
#import "ASStarRatingView.h"

@interface RoastAppMenuItemViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) IBOutlet UITextView *ratingTextView;
@property (strong, nonatomic) RoastAppShopItem *item;
@property (strong, nonatomic) IBOutlet UITextView *textInfoView;
@property (strong, nonatomic) IBOutlet ASStarRatingView *starRating;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) IBOutlet UIButton *rateButton;


@end
