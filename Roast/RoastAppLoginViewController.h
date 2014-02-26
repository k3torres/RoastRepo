//
//  RoastAppLoginViewController.h
//  Roast
//
//  Created by Alexander Kissinger on 2/8/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FBProfilePictureView.h>
#import <FacebookSDK/FBLoginView.h>

@interface RoastAppLoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;

@end

@interface LoginUIViewController : UIViewController <FBLoginViewDelegate>
@end

