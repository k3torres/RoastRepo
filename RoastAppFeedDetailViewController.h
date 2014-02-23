//
//  RoastAppFeedDetailViewController.h
//  Roast
//
//  Created by KT on 2/14/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoastAppFeedItem.h"

@interface RoastAppFeedDetailViewController : UIViewController

@property NSString *detailName;
@property RoastAppFeedItem *selectedFeedItem;

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UITextView *comment;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *postPicture;

@end

