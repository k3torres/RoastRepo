//
//  RoastAppHomeScreenTabViewController.h
//  Roast
//
//  Created by Alexander Kissinger on 3/13/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoastAppHomeScreenTabViewController : UITabBarController
{
    UITabBar *shopListTabBar;
}

@property NSMutableArray *shopListTabBarArray;
@property NSMutableArray *feedTabBarArray;
@property NSMutableArray *profileTabBarArray;
-(NSMutableArray *)getFeedViewArray;
@end
