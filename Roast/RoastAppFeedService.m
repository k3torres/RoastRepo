//
//  RoastAppFeedService.m
//  Roast
//
//  Created by Alexander Kissinger on 1/31/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppFeedService.h"
#import "RoastAppFeedItem.h"
#import "STHTTPRequest.h"

@implementation RoastAppFeedService

- (id)init
{
    self.twitterConsumerKey = @"FBx0CGvWk5aNx809oOTA";
    self.twitterConsumerShh = @"tQATEamxHiy61VtFumuAKpps1snMJDd8vSVjOEeIw";
    self.fbAppID = @"259155417579773";
    self.fbShh = @"3630c8a8b2ef8c2a0152f15c332c15cf";
    
    return self;
}

- (id)initWithProfile:(RoastAppFeedProfile *)newProfile
{
    self = [self init];
    self.feedProfile = newProfile;
    
    return self;
}

- (STTwitterAPI *)connectTwitter
{
    /* Twitter OAUTH and Request */
    self.twitterService = [STTwitterAPI
                           twitterAPIAppOnlyWithConsumerKey:self.twitterConsumerKey
                           consumerSecret:self.twitterConsumerShh];
    return self.twitterService;
}

-(NSMutableArray *)populateFeed:(NSMutableArray *)feedArray withTableView:(UITableView *)tableView
{
    //Connect to Services
    [self connectTwitter];
    
    //Twitter Request
    [self.twitterService verifyCredentialsWithSuccessBlock:^(NSString *bearerToken)
     {
         for(NSString *user in self.feedProfile.users)
         {
             [self.twitterService getUserInformationFor:user successBlock:^(NSDictionary *response) {
                 NSURL *imageURL = [NSURL URLWithString:[response objectForKey:@"profile_image_url"]];
                 NSData *data = [NSData dataWithContentsOfURL:imageURL];
                 UIImage *userPic = [UIImage imageWithData:data];
                 
                 [self.twitterService getUserTimelineWithScreenName:user count:5 successBlock:^(NSArray *statuses)
                  {
                      NSLog(@"Successful Verification and status retrival! %@", user);
                      
                      UIImage *twitterBadge = [UIImage imageNamed:@"twittericon.png"];
                      for(NSDictionary *status in statuses)
                      {
                          RoastAppFeedItem *feedItem1 = [[RoastAppFeedItem alloc] init];
                          
                          feedItem1.serviceName = @"Twitter";
                          feedItem1.serviceBadge = twitterBadge;
                          feedItem1.userName = status[@"user"][@"screen_name"];
                          feedItem1.message = status[@"text"];
                          feedItem1.timestamp = status[@"created_at"];
                          feedItem1.userPic = userPic;
                          feedItem1.idNum = status[@"id"];
                          
                          [feedArray addObject:feedItem1];
                      }
                      
                      [[NSNotificationCenter defaultCenter]
                       postNotificationName:@"TestNotification"
                       object:self];
                      
                      
                  } errorBlock:^(NSError *error)
                  {
                      NSLog(@"%@", error.debugDescription);
                  }];
                 
                 
             } errorBlock:^(NSError *error) {
                 //
             }];
             
         }
     }
     errorBlock:^(NSError *error)
     {
         NSLog(@"%@", error.debugDescription);
     }];
    
    return feedArray;
}

@end
