//
//  RoastAppTwitterFeedService.m
//  Roast
//
//  Created by Alexander Kissinger on 3/23/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppTwitterFeedService.h"

@implementation RoastAppTwitterFeedService

- (RoastAppTwitterFeedService *) init
{
    self = [super init];
    
    /*** Secrets ***/
    self.twitterConsumerKey = @"FBx0CGvWk5aNx809oOTA";
    self.twitterConsumerShh = @"tQATEamxHiy61VtFumuAKpps1snMJDd8vSVjOEeIw";
    
    self.twitterService = Nil;
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss '+'zzzz yyyy"];
    self.feedProfile = [[RoastAppFeedProfile alloc] init];
    self.feedArray = [[NSMutableArray alloc] init];
    
    return self;
}

- (RoastAppTwitterFeedService *) initWithProfile: (RoastAppFeedProfile *)newProfile
{
    self = [super initWithProfile:newProfile];
    /*** Secrets ***/
    self.twitterConsumerKey = @"FBx0CGvWk5aNx809oOTA";
    self.twitterConsumerShh = @"tQATEamxHiy61VtFumuAKpps1snMJDd8vSVjOEeIw";
    
    self.twitterService = Nil;
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss '+'zzzz yyyy"];
    self.feedProfile = [[RoastAppFeedProfile alloc] init];
    self.feedArray = [[NSMutableArray alloc] init];
    
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

- (void)retrieveNewFeeds //Retrieve new feeds; Returns YES if successful, NO if err
{
    self.feedArray = [[NSMutableArray alloc] init];
    if(self.twitterService == Nil)
    {
        [self connectTwitter];
    }
    
    //Twitter Request
    [self.twitterService verifyCredentialsWithSuccessBlock:^(NSString *bearerToken)
     {
         for(NSString *user in self.feedProfile.users)
         {
             [self.twitterService getUserInformationFor:user successBlock:^(NSDictionary *response)
             {
                 
                 [self.twitterService getUserTimelineWithScreenName:user count:3 successBlock:^(NSArray *statuses)
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
                          feedItem1.timestamp = [self.dateFormatter dateFromString:status[@"created_at"]];
                          feedItem1.userPic = [self getUIImageFromURLString:[response objectForKey:@"profile_image_url"]];
                          feedItem1.idNum = status[@"id"];
                          
                          [self.feedArray addObject:feedItem1];
                          [[NSNotificationCenter defaultCenter]
                           postNotificationName:@"TestNotification"
                           object:feedItem1];
                      }
                      
                      
                      
                      
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
}

@end