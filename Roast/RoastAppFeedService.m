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
    self.instagramAuthURL   = @"https://instagram.com/oauth/authorize/?";
    self.instagramTagURL    = @"https://api.instagram.com/v1/tags/";
    self.instagramAPIURL    = @"https://api.instagram.com/v1/users/";
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
    
    
    
    for(NSString *tag in self.feedProfile.tags)
    {
        [self appendFeedArray:feedArray withTag:tag];
    }
     
    
    return feedArray;
}


- (void)appendFeedArray:(NSMutableArray *)feed withTag:(NSString *)instagramTag
{
    //we can for loop here through self.feedProfile.tags and change tagURLMedia
    NSLog(@"PART 0: appendFeedArray called recieved");
    NSString *tagURLMedia = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=%@", instagramTag, self.instagramClient_ID];
    NSURL *url = [NSURL URLWithString:tagURLMedia];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    
    // Fetch the JSON response
    
    // Make synchronous request
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *urlData, NSError *connectionError)
    {
       // NSLog(@"PING!!!!!!!!!!!!");
        NSDictionary *dictionaryFromResponse = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error:nil];
        
        // Get the objects you want
        NSMutableArray *username        = [dictionaryFromResponse valueForKeyPath:@"data.user.username"];
        NSMutableArray *profileURL      = [dictionaryFromResponse valueForKeyPath:@"data.user.profile_picture"];
        NSMutableArray *message         = [dictionaryFromResponse valueForKeyPath:@"data.caption.text"]; //could be null
        NSMutableArray *thumbnailURLs   = [dictionaryFromResponse valueForKeyPath:@"data.images.low_resolution.url"];
        //NSMutableArray *creation        = [dictionaryFromResponse valueForKeyPath:@"data.caption.created_time"];
        NSMutableArray *creation        = [dictionaryFromResponse valueForKeyPath:@"data.created_time"];
        NSMutableArray *idNumber        = [dictionaryFromResponse valueForKeyPath:@"data.user.id"];
        
        // Construct a String around the Data from the response
        UIImage *instagramBadge = [UIImage imageNamed:@"instagramicon.png"];
        
        NSURL *imageURL;
        NSData *data;
        UIImage *photo;
        
        //get 5 latest instagram posts for instagramTag
        for (int i=0; i<5; i++)
        {
            RoastAppFeedItem *feedItem1 = [[RoastAppFeedItem alloc] init];
            
            imageURL = [NSURL URLWithString:[thumbnailURLs objectAtIndex:i]];
            data = [NSData dataWithContentsOfURL:imageURL];
            photo = [UIImage imageWithData:data];
            
            feedItem1.photo = photo;
            
            imageURL = [NSURL URLWithString:[profileURL objectAtIndex:i]];
            data = [NSData dataWithContentsOfURL:imageURL];
            photo = [UIImage imageWithData:data];
            
            feedItem1.userPic = photo;
            
            feedItem1.serviceName = @"Instagram";
            feedItem1.serviceBadge = instagramBadge;
            feedItem1.userName = [username objectAtIndex:i];
            feedItem1.message = ([message objectAtIndex:i] == [NSNull null]) ? [NSString stringWithFormat:@"#%@" , instagramTag]  : [message objectAtIndex:i] ; //NULL CHECK
            
            //date
            feedItem1.timestamp = [NSDate dateWithTimeIntervalSince1970:[[creation objectAtIndex:i] integerValue]];
            //done with date
            
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            NSNumber * myNumber = [f numberFromString:[idNumber objectAtIndex:i]];
            feedItem1.idNum = myNumber;
            //NSLog(@"ADDING ---------------------------------------------> %d", i);
            [feed addObject:feedItem1];
        }
        
        NSLog(@"added instagram feedItems with tag = %@" , instagramTag );
    }];
    
    
    
    
}
@end
