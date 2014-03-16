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
@synthesize shopInfoTextView;
@synthesize scrolly;
@synthesize gearOutlet;
@synthesize drinkOutlet;
@synthesize foodOutlet;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = shopChoice;

    /*UIScrollView *tempScrollView=(UIScrollView *)self.view;
    tempScrollView.contentSize=CGSizeMake(1280,960);*/
    [scrolly setScrollEnabled:YES];
    [scrolly setContentSize:CGSizeMake(320, 1000)];

    self.backgroundtest = [NSMutableArray arrayWithObjects:@"Wood-Desktop-Wallpaper.jpg",@"Wood-Desktop-Wallpaper.png",
                           @"Wood-Desktop-Wallpaper2.png",@"Wood-Desktop-Wallpaper3.png",
                           @"Wood-Desktop-Wallpaper4.png",@"Wood-Desktop-Wallpaper5.png", nil];
    shopInfoTextView.layer.cornerRadius = 5.0;
    shopImage.layer.cornerRadius = 5.0;

    [self setRoundedBorder:gearOutlet];
    [self setRoundedBorder:drinkOutlet];
    [self setRoundedBorder:foodOutlet];
    
    [self loadInitialView];
   
}


- (void)loadInitialView
{
    self.pix = [RoastAppServerImageHandler requestCafeImagesForCarousel:shopChoice];
    
    self.imageIndex = 0;
    self.i = 0;
    shopImage.image = [self.pix objectAtIndex:self.imageIndex];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[self.backgroundtest objectAtIndex:self.i]]]];
    [self loadAboutInfo];
}
 
- (void)loadAboutInfo
{
    [shopInfoTextView setScrollEnabled:YES];
    self.shopAbout = [NSMutableArray arrayWithObjects:@"\tCoffee & Tea Collective is a group of people who care about the craft of coffee and the idea of sharing our passion with others. As a small-batch roastery and tasting room, we are able to intentionally focus on the entire experience from start to finish. We take pride in the coffees that we source and the brew methods in which we serve them. Specializing in a by-the-cup experience, we engage each interaction with intent and a desire to come alongside each individual as each experience and palette is different. All of our small-batch roasts are developed to produce the same consistent quality over time. We believe that coffee should not be a convenience. It is a craft as much as any other, and it's something we like to share.\n\tWe saw a lack of attention and care towards small-batch coffee roasting in the place we call home. So we decided to start our own roastery & tasting bar to share our passion with others.\n\tFor more information about our story, our shop and other inquiries contact: info@coffeeandteacollective.com",
        @"\tWhat started as a simple quest for a good cup of coffee has become the foundation on which Caffé Calabria stands today. After tasting coffee all over the country, Calabria's founder, Arne Holt, seized his calling to bring quality coffee to San Diego. Fifteen years, endless hours of work, dozens of trips to Italy, and millions of batches of coffee later – Caffé Calabria is one of the finest coffee roasters on the West Coast.\n\tIn our North Park cafe, coffee house, and roaster, our position is simple: Create and deliver an exceptional product.\n\tThis is our mission. This is our passion.",nil];
    
    if ( [shopChoice  isEqual: @"COFFEE & TEA COLLECTIVE"])
    {
        shopInfoTextView.text = [self.shopAbout objectAtIndex:0];
        //shopIcon.image = [UIImage imageNamed:@"candticoncrop.png"];
    }
    else if ([shopChoice isEqualToString:@"CAFFE CALABRIA"])
        shopInfoTextView.text = [self.shopAbout objectAtIndex:1];
   
    //[self contentSizeRectForTextView: shopInfoTextView];
    //[[shopInfoTextView layoutManager] usedRectForTextContainer:[shopInfoTextView textContainer]];
    [shopInfoTextView sizeToFit];
    [shopInfoTextView setScrollEnabled:NO];
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
- (IBAction)changeBack:(id)sender {

    //NSLog(@"i = %d", self.i);
    self.i = (self.i < 5) ? self.i + 1 : 0;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[self.backgroundtest objectAtIndex:self.i]]]];
    NSLog(@"Background: %@",[self.backgroundtest objectAtIndex:self.i] );
}

-(void)setRoundedBorder:(UIButton *)button
{
    CGPoint saveCenter = button.center;
    button.frame = CGRectMake(135.0, 180.0, 54.0, 54.0);//width and height should be same value
    button.clipsToBounds = YES;
    
    button.layer.cornerRadius = 27;//half of the width
    button.layer.borderColor=[UIColor colorWithRed: 51.0/255.0 green: 51.0/255.0 blue: 51.0/255.0 alpha:1.0].CGColor;
    button.layer.borderWidth=1.5f;
    button.center = saveCenter;
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
