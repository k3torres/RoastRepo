//
//  RoastAppShopViewController.m
//  Roast
//
//  Created by Nicholas Variz on 1/26/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppShopViewController.h"
#import "RoastAppShopMenuViewController.h"
#import "RoastAppJSONHandler.h"
#import "RoastAppShopItem.h"
#import "RoastAppServerImageHandler.h"

@interface RoastAppShopViewController ()

@end

@implementation RoastAppShopViewController

@synthesize shopChoice;
@synthesize shopImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = shopChoice;

    /*UIScrollView *tempScrollView=(UIScrollView *)self.view;
    tempScrollView.contentSize=CGSizeMake(1280,960);*/
    
    [self loadInitialView];
   
}


- (void)loadInitialView
{
    self.pix = [RoastAppServerImageHandler requestCafeImagesForCarousel:shopChoice];
    
    self.imageIndex = 0;
    shopImage.image = [self.pix objectAtIndex:self.imageIndex];
}
 

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)unwindToShopList:(UIStoryboardSegue *)segue

{
    
    NSLog(@"Calling unwindToShopList");
    
}

- (IBAction)handleSwipe:(UISwipeGestureRecognizer *)sender {
    NSLog(@"swipped!!");
    UISwipeGestureRecognizerDirection direction = [(UISwipeGestureRecognizer *)sender direction];
    CATransition *animation = [CATransition animation];
    [animation setDuration:1.0]; //Animate for a duration of 1.0 seconds
    [animation setType:kCATransitionPush]; //New image will push the old image off

    switch (direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            NSLog(@"Swiped Left");
            self.imageIndex++;
            [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
            break;
        case UISwipeGestureRecognizerDirectionRight:
            NSLog( @"Swiped Right");
            self.imageIndex--;
            [animation setSubtype:kCATransitionFromLeft]; //Current image will slide off to the left, new image slides in from the right
            break;
        default:
            break;
    }
    self.imageIndex = (self.imageIndex < 0) ? ([self.pix count] -1) : self.imageIndex % [self.pix count];
    
    shopImage.image = [self.pix objectAtIndex:self.imageIndex];
    
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [[shopImage layer] addAnimation:animation forKey:nil];
    
    
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get reference to the ShopMenu view controller (destination)
    RoastAppShopMenuViewController *menuCtrlr = [segue destinationViewController];
    menuCtrlr.shopChoice = [self shopChoice];
    //Inform the menu VC which type of menu should be displayed
    if ([[segue identifier] isEqualToString:@"drinkMenuSegue"])
        menuCtrlr.menuChoice = @"drinkMenu";
    else if ([[segue identifier] isEqualToString:@"foodMenuSegue"])
        menuCtrlr.menuChoice = @"foodMenu";
    else if ([[segue identifier] isEqualToString:@"gearMenuSegue"])
        menuCtrlr.menuChoice = @"gearMenu";
}


/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

@end