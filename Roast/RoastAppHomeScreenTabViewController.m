//
//  RoastAppHomeScreenTabViewController.m
//  Roast
//
//  Created by Alexander Kissinger on 3/13/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppHomeScreenTabViewController.h"
#import "RoastAppFeedViewController.h"

@interface RoastAppHomeScreenTabViewController ()

@end

@implementation RoastAppHomeScreenTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"REACHED TABBARVC");
    UIStoryboard *storyboard = self.storyboard;
    UINavigationController *shopListView = [storyboard instantiateViewControllerWithIdentifier:@"ShopNav"];
    RoastAppFeedViewController *feedView = [storyboard instantiateViewControllerWithIdentifier:@"Feed"];
    /*
    if ([self.viewControllers[0] class] == [UINavigationController class]) {
        shopListView = self.viewControllers[0];
        feedView = self.viewControllers[1];
    }
    else {
        shopListView = self.viewControllers[1];
        feedView = self.viewControllers[0];
    }
     */
    
    self.shopListTabBarArray = [NSMutableArray arrayWithObjects:shopListView, nil];
    self.feedTabBarArray = [NSMutableArray arrayWithObjects:feedView, nil];

    [self setViewControllers:self.shopListTabBarArray animated:YES];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    UIImage *btnImageRight = [UIImage imageNamed:@"swipe_right-50.png"];
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRight.frame = CGRectMake(screenWidth - 60, screenHeight - 50, 50, 50);
    [btnRight setBackgroundImage:btnImageRight forState:UIControlStateNormal];
    
    [btnRight setTintColor:[UIColor colorWithRed:61.0/255.0 green:61.0/255.0 blue:61/255.0 alpha:0.10]];
    UIImage * __weak imageRight = [btnRight.currentBackgroundImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [btnRight setBackgroundImage:imageRight forState:UIControlStateNormal];
    [btnRight setTag:9];
    
    
    [self.view addSubview:btnRight];
    
    UIImage *btnImageLeft = [UIImage imageNamed:@"swipe_left-50.png"];
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLeft.frame = CGRectMake(10, screenHeight - 50, 50, 50);
    [btnLeft setBackgroundImage:btnImageLeft forState:UIControlStateNormal];
    [btnLeft setTintColor:[UIColor colorWithRed:61.0/255.0 green:61.0/255.0 blue:61/255.0 alpha:0.10]];
    UIImage * __weak imageLeft = [btnLeft.currentBackgroundImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [btnLeft setBackgroundImage:imageLeft forState:UIControlStateNormal];
    [btnLeft setTag:8];
    [self.view addSubview:btnLeft];
    //[self presentViewController:shopListView animated:YES completion:nil];
    //[self.tabBarController.tabBar setHidden:YES];
	// Do any additional setup after loading the view.
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
