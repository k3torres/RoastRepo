//
//  RoastAppMenuItemReviewController.h
//  Roast
//
//  Created by Nicholas Variz on 3/3/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStarRatingView.h"
@interface RoastAppMenuItemReviewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) NSString* menuItemID;

@property (strong, nonatomic) UIViewController* parentViewCtrlr;
@property (weak, nonatomic) IBOutlet ASStarRatingView *rateView;
@property (strong, nonatomic) IBOutlet UIView *textViewArea;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIImageView *userImage;



@end
