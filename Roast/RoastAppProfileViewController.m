//
//  RoastAppProfileViewController.m
//  Roast
//
//  Created by Alexander Kissinger on 3/15/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppProfileViewController.h"
#import "RoastAppHomeScreenTabViewController.h"

@interface RoastAppProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *facebookLoginButton;
@property (weak, nonatomic) IBOutlet UIView *twitterLoginButton;
@property (weak, nonatomic) IBOutlet UIView *instagramLoginButton;

@end

@implementation RoastAppProfileViewController

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
	// Do any additional setup after loading the view.
    
    //Scroll View
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(280,950)];
    
    //FaceBook Login Button
    CALayer *fbButtonLayer = [self.facebookLoginButton layer];
    [fbButtonLayer setMasksToBounds:YES];
    [fbButtonLayer setCornerRadius:5.0];
    [fbButtonLayer setBorderWidth:1.0f];
    [fbButtonLayer setBorderColor:[[UIColor colorWithWhite:1.0 alpha:0.7f] CGColor]];
    
    //Twitter Login Button
    CALayer *tButtonLayer = [self.twitterLoginButton layer];
    [tButtonLayer setMasksToBounds:YES];
    [tButtonLayer setCornerRadius:5.0];
    [tButtonLayer setBorderWidth:1.0f];
    [tButtonLayer setBorderColor:[[UIColor colorWithWhite:1.0 alpha:0.7f] CGColor]];
    
    //Instagram Login Button
    CALayer *iButtonLayer = [self.instagramLoginButton layer];
    [iButtonLayer setMasksToBounds:YES];
    [iButtonLayer setCornerRadius:5.0];
    [iButtonLayer setBorderWidth:1.0f];
    [iButtonLayer setBorderColor:[[UIColor colorWithWhite:1.0 alpha:0.7f] CGColor]];
    
}

- (IBAction)swipeRight:(id)sender {
    RoastAppHomeScreenTabViewController *tmp = ((RoastAppHomeScreenTabViewController *)self.tabBarController);
    
    [UIView transitionFromView:[self view]
                        toView:[tmp.feedTabBarArray[0] view]
                      duration:0.25
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    completion:nil];
    
    [self.tabBarController setViewControllers:tmp.feedTabBarArray];
}

- (IBAction)swipeLeft:(id)sender {
    RoastAppHomeScreenTabViewController *tmp = ((RoastAppHomeScreenTabViewController *)self.tabBarController);
    
    [UIView transitionFromView:[self view]
                        toView:[tmp.shopListTabBarArray[0] view]
                      duration:0.25
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    completion:nil];
    
    [self.tabBarController setViewControllers:tmp.shopListTabBarArray];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
