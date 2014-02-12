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

- (id)init
{
    self.twitterConsumerKey = @"FBx0CGvWk5aNx809oOTA";
    self.twitterConsumerShh = @"tQATEamxHiy61VtFumuAKpps1snMJDd8vSVjOEeIw";
    self.fbAppID = @"259155417579773";
    self.fbShh = @"3630c8a8b2ef8c2a0152f15c332c15cf";
    
    self.instagramClient_ID = @"159d17709bf84b329e5fe4a388afe380";
    self.instagramRedirect_URI = @"http://coffeeapp.cc/logged_in";
    self.instagramClient_Secret = @"0b453aed8d6e41c48b07a1b570a11815";
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



- (FBRequestConnection *)connectFB
{
    
    
    // create the connection object
    [self.fbService cancel];
    self.fbService = [[FBRequestConnection alloc] init];
    
    return self.fbService;
}

// FBSample logic
// Report any results.  Invoked once for each request we make.
- (void)requestCompleted:(FBRequestConnection *)connection
                 forFbID:fbID
                  result:(id)result
                   error:(NSError *)error {
    // not the completion we were looking for...
    if (self.fbReqConn &&
        connection != self.fbReqConn) {
        return;
    }
    
    // clean this up, for posterity
    self.fbReqConn = nil;
    
    NSString *text;
    if (error) {
        // error contains details about why the request failed
        /*
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"FB returned an error. Probably bad Oauth"
                                                       delegate:nil
                                              cancelButtonTitle:@"Nah"
                                              otherButtonTitles:nil];
        [alert show];
         */
    } else {
        // result is the json response from a successful request !!!!!!!!!!!!!
        NSDictionary *dictionary = (NSDictionary *)result;
        // we pull the name property out, if there is one, and display it
        /*
        NSMutableString *text = [NSMutableString stringWithString:@"It returned!/nCheck it: %@"];
        [text appendString:(NSMutableString *)[dictionary objectForKey:@"name"]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congrats"
                                                        message:text
                                                       delegate:nil
                                              cancelButtonTitle:@"Yee"
                                              otherButtonTitles:nil];
        [alert show];
         */
        
        
    }
}


- (UIImage *)getUIImageFromURLString:(NSString *)urlString
{
    NSURL *imageURL = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:imageURL];
    return [UIImage imageWithData:data];
}


-(NSMutableArray *)populateFeed:(NSMutableArray *)feedArray withTableView:(UITableView *)tableView
{
    //Connect to Services
    [self connectTwitter];
    [self connectFB];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //Twitter Request
    [self.twitterService verifyCredentialsWithSuccessBlock:^(NSString *bearerToken)
     {
         for(NSString *user in self.feedProfile.users)
         {
             [self.twitterService getUserInformationFor:user successBlock:^(NSDictionary *response) {
                 
                 [self.twitterService getUserTimelineWithScreenName:user count:5 successBlock:^(NSArray *statuses)
                  {
                      NSLog(@"Successful Verification and status retrival! %@", user);
                      
                      UIImage *twitterBadge = [UIImage imageNamed:@"twittericon.png"];
                      [formatter setDateFormat:@"EEE MMM dd HH:mm:ss '+'zzzz yyyy"];

                      for(NSDictionary *status in statuses)
                      {
                          RoastAppFeedItem *feedItem1 = [[RoastAppFeedItem alloc] init];
                          
                          feedItem1.serviceName = @"Twitter";
                          feedItem1.serviceBadge = twitterBadge;
                          feedItem1.userName = status[@"user"][@"screen_name"];
                          feedItem1.message = status[@"text"];
                          feedItem1.timestamp = [formatter dateFromString:status[@"created_at"]];
                          feedItem1.userPic = [self getUIImageFromURLString:[response objectForKey:@"profile_image_url"]];
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
    
    
    //Facebook Request
    for (NSString *fbid in self.feedProfile.users)
    {
        
        NSMutableString *graphPathString = [[NSMutableString alloc] initWithString:fbid];
        [graphPathString appendString:@"?fields=id,name,statuses.limit(5).fields(message),picture"];
        
        // create a handler block to handle the results of the request for fbid's profile
        [self.fbService
         addRequest:[[FBRequest alloc] initWithSession:FBSession.activeSession graphPath:graphPathString]
         completionHandler:^(FBRequestConnection *connection, id result, NSError *error)
         {
             if(!error)
             {
                 // result is the json response from a successful request !!!!!!!!!!!!!
                 NSDictionary *dictionary = (NSDictionary *)result;
                 UIImage *fbBadge = [UIImage imageNamed:@"fbicon.png"];
                 [formatter setDateFormat:@"YYYY-MM-dd'T'HH:mm:ss'+'zzzz"];

                 for(FBGraphObject *status in dictionary[@"statuses"][@"data"])
                 {
                     RoastAppFeedItem *feedItem = [[RoastAppFeedItem alloc] init];
                     
                     feedItem.serviceName = @"Facebook";
                     feedItem.serviceBadge = fbBadge;
                     feedItem.userName = dictionary[@"name"];
                     feedItem.message = status[@"message"];
                     feedItem.timestamp = [formatter dateFromString:status[@"updated_time"]];
                     feedItem.userPic = [self getUIImageFromURLString:dictionary[@"picture"][@"data"][@"url"]];
                     feedItem.idNum = status[@"id"];
                     
                     [feedArray addObject:feedItem];
                 }
                 
                 [[NSNotificationCenter defaultCenter]
                  postNotificationName:@"TestNotification"
                  object:self];
             }
         }];
    }
    
    [self.fbService start];
    
    
    
    
    
    
    
    
    
    
    
    
    return feedArray;
}

@end
