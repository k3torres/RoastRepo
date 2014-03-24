//
//  RoastAppTwitterFeedService.m
//  Roast
//
//  Created by Alexander Kissinger on 3/23/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppTwitterFeedService.h"

@implementation RoastAppTwitterFeedService
NSString * const CONSUMERKEY = @"FBx0CGvWk5aNx809oOTA";
NSString * const CONSUMERSHH = @"tQATEamxHiy61VtFumuAKpps1snMJDd8vSVjOEeIw";;

- (RoastAppTwitterFeedService *) init
{
    self = [super init];
    self.twitterService = Nil;
    [self.dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss '+'zzzz yyyy"];
    
    return self;
}

- (RoastAppTwitterFeedService *) initWithProfile: (RoastAppFeedProfile *)newProfile
{
    self = [super initWithProfile:newProfile];
    self.twitterService = Nil;
    [self.dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss '+'zzzz yyyy"];
    
    return self;
}

- (STTwitterAPI *)connectTwitter
{
    /* Twitter OAUTH and Request */
    self.twitterService = [STTwitterAPI
                           twitterAPIAppOnlyWithConsumerKey:CONSUMERKEY
                           consumerSecret:CONSUMERSHH];
    return self.twitterService;
}

- (void)retrieveNewFeeds //Retrieve new feeds; Returns YES if successful, NO if err
{
    self.feedArray = [[NSMutableArray alloc] init];
    if(self.twitterService == Nil)
    {
        [self connectTwitter];
    }
    
    //Twitter Object Request for USERS
    [self.twitterService verifyCredentialsWithSuccessBlock:^(NSString *bearerToken)
     {
         for(NSString *user in self.feedProfile.users)
         {
             [self.twitterService getUserInformationFor:user successBlock:^(NSDictionary *response)
             {
                 
                 [self.twitterService getUserTimelineWithScreenName:user count:3 successBlock:^(NSArray *statuses)
                  {
                      UIImage *twitterBadge = [UIImage imageNamed:@"twittericon.png"];
                      
                      for(NSDictionary *status in statuses)
                      {
                          RoastAppFeedItem *feedItem = [[RoastAppFeedItem alloc] init];
                          
                          feedItem.serviceName = @"Twitter";
                          feedItem.serviceBadge = twitterBadge;
                          feedItem.userName = status[@"user"][@"screen_name"];
                          feedItem.message = status[@"text"];
                          feedItem.timestamp = [self.dateFormatter dateFromString:status[@"created_at"]];
                          feedItem.userPic = [self getUIImageFromURLString:[response objectForKey:@"profile_image_url"]];
                          feedItem.idNum = status[@"id"];
                          
                          [self.feedArray addObject:feedItem];
                          [[NSNotificationCenter defaultCenter]
                           postNotificationName:@"IncomingFeedItem"
                           object:feedItem];
                      }
                      
                  } errorBlock:^(NSError *error)
                  {
                      NSLog(@"Twitter failed fetching user object: %@", error.debugDescription);
                  }];
                 
                 
             } errorBlock:^(NSError *error) {
                 NSLog(@"Twitter failed getting user info: %@", error.debugDescription);
             }];
             
         }
     }
    errorBlock:^(NSError *error)
     {
         NSLog(@"Twitter service failed verification: %@", error.debugDescription);
         
     }];

}

@end