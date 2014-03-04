//
//  RoastAppMenuItemReviewController.h
//  Roast
//
//  Created by Nicholas Variz on 3/3/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoastAppMenuItemReviewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSString* menuItemID;
@property (nonatomic, retain) IBOutlet UITextField *textField;

@end
