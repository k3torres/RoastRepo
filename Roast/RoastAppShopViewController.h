//
//  RoastAppShopViewController.h
//  Roast
//
//  Created by Nicholas Variz on 1/26/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoastAppShopViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property int imageIndex;
@property (strong, nonatomic) NSString *shopChoice;
@property (strong, nonatomic) IBOutlet UIImageView *shopImage;
- (IBAction)handleSwipe:(UISwipeGestureRecognizer *)sender;

@property NSMutableArray *pix;

@end
