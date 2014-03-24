//
//  RoastAppFeedService.m
//  Roast
//
//  Created by Alexander Kissinger on 1/31/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import <FacebookSDK/FBRequest.h>
#import <FacebookSDK/FBSession.h>
#import <FacebookSDK/FBAccessTokenData.h>
#import <FacebookSDK/FBGraphObject.h>
#import "RoastAppFeedService.h"
#import "RoastAppFeedItem.h"
#import "STHTTPRequest.h"


@implementation RoastAppFeedService

- (RoastAppFeedService *)init
{
    self = [super init];
    self.feedProfile = [[RoastAppFeedProfile alloc] init];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.feedArray = [[NSMutableArray alloc] init];
    
    return self;
}

- (RoastAppFeedService *)initWithProfile:(RoastAppFeedProfile *)newProfile
{
    self = [super init];
    self.feedProfile = newProfile;
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.feedArray = [[NSMutableArray alloc] init];
    
    return self;
}

- (UIImage *)getUIImageFromURLString:(NSString *)urlString
{
    NSURL *imageURL = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:imageURL];
    return [UIImage imageWithData:data];
}
@end
