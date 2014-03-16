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
@property int i;
@property (strong, nonatomic) NSString *shopChoice;
@property (strong, nonatomic) IBOutlet UIImageView *shopImage;
- (IBAction)handleSwipe:(UISwipeGestureRecognizer *)sender;
@property NSMutableArray *shopAbout;
@property NSMutableArray *pix;
@property (strong, nonatomic) IBOutlet UITextView *shopInfoTextView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrolly;
//@property (strong, nonatomic) IBOutlet UIButton *changeBack;
@property (strong, nonatomic) IBOutlet UIButton *gearOutlet;
@property (strong, nonatomic) IBOutlet UIButton *foodOutlet;
@property (strong, nonatomic) IBOutlet UIButton *drinkOutlet;
//@property (strong, nonatomic) IBOutlet UIImageView *shopIcon;

@property NSMutableArray *backgroundtest;
@end
