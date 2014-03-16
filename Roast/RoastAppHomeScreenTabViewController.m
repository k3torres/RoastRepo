//
//  RoastAppHomeScreenTabViewController.m
//  Roast
//
//  Created by Alexander Kissinger on 3/13/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

//IMPORT ALL HOMESCREEN VIEW CONTROLLERS
#import "RoastAppHomeScreenTabViewController.h"
#import "RoastAppFeedViewController.h"
#import "RoastAppProfileViewController.h"

@interface RoastAppHomeScreenTabViewController ()

@end

@implementation RoastAppHomeScreenTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIStoryboard *storyboard = self.storyboard;
    UINavigationController *shopListView = [storyboard instantiateViewControllerWithIdentifier:@"ShopNav"];
    RoastAppFeedViewController *feedView = [storyboard instantiateViewControllerWithIdentifier:@"Feed"];
    RoastAppProfileViewController *profileView = [storyboard instantiateViewControllerWithIdentifier:@"Profile"];
    

    
    self.shopListTabBarArray = [NSMutableArray arrayWithObjects:shopListView, nil];
    self.feedTabBarArray = [NSMutableArray arrayWithObjects:feedView, nil];
    self.profileTabBarArray = [NSMutableArray arrayWithObjects:profileView, nil];

    //INITIAL HOME SCREEN VIEW
    [self setViewControllers:self.shopListTabBarArray animated:YES];

    //Draw Arrows
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    UIImage *btnImageRight = [UIImage imageNamed:@"arrow-right-60px.png"];
    
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect buttonFrameRight = btnRight.frame;
    buttonFrameRight = CGRectMake(screenWidth - 40, screenHeight - 43, 30.0f, 36.0f);
    btnRight.frame = buttonFrameRight;
    [btnRight setBackgroundImage:btnImageRight forState:UIControlStateNormal];

    [btnRight setTintColor:[UIColor colorWithRed:61.0/255.0 green:61.0/255.0 blue:61/255.0 alpha:0.60]];
    UIImage * __weak imageRight = [btnRight.currentBackgroundImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [btnRight setBackgroundImage:imageRight forState:UIControlStateNormal];
    [btnRight setTag:9];
    
    
    [self.view addSubview:btnRight];
    
    UIImage *btnImageLeft = [UIImage imageNamed:@"arrow-left-60px.png"];
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGRect buttonFrameLeft = btnLeft.frame;
    buttonFrameLeft = CGRectMake(10, screenHeight - 43, 30.f, 36.f);
    btnLeft.frame = buttonFrameLeft;
    
    [btnLeft setBackgroundImage:btnImageLeft forState:UIControlStateNormal];
    [btnLeft setTintColor:[UIColor colorWithRed:61.0/255.0 green:61.0/255.0 blue:61/255.0 alpha:0.60]];
    UIImage * __weak imageLeft = [btnLeft.currentBackgroundImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [btnLeft setBackgroundImage:imageLeft forState:UIControlStateNormal];
    [btnLeft setTag:8];
    [self.view addSubview:btnLeft];
}

- (NSMutableArray *) getFeedViewArray {
    return self.feedTabBarArray;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
