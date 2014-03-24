//
//  RoastAppFacebookFeedService.m
//  Roast
//
//  Created by Alexander Kissinger on 3/23/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppFacebookFeedService.h"

@implementation RoastAppFacebookFeedService
NSString * const APPID = @"259155417579773";
NSString * const APPSHH = @"3630c8a8b2ef8c2a0152f15c332c15cf";

- (RoastAppFacebookFeedService *) init
{
    self = [super init];
    self.fbService = Nil;
    self.fbReqConn = Nil;
    [self.dateFormatter setDateFormat:@"YYYY-MM-dd'T'HH:mm:ss'+'zzzz"];
    return self;
}

- (RoastAppFacebookFeedService *) initWithProfile:(RoastAppFeedProfile *)newProfile
{
    self = [super initWithProfile:newProfile];
    self.fbService = Nil;
    self.fbReqConn = Nil;
    [self.dateFormatter setDateFormat:@"YYYY-MM-dd'T'HH:mm:ss'+'zzzz"];
    
    return self;
}

- (FBRequestConnection *)connectFB
{
    // create the connection object
    [self.fbService cancel];
    self.fbService = [[FBRequestConnection alloc] init];
    
    return self.fbService;
}

- (void)retrieveNewFeeds
{
    [self connectFB];
    
    //Facebook Request
    if ([self.feedProfile.users count]) {
        for (NSString *fbid in self.feedProfile.users)
        {
            
            NSMutableString *graphPathString = [[NSMutableString alloc] initWithString:fbid];
            [graphPathString appendString:@"?fields=id,name,statuses.limit(3).fields(message),picture"];
            
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
                     
                     
                     for(FBGraphObject *status in dictionary[@"statuses"][@"data"])
                     {
                         RoastAppFeedItem *feedItem = [[RoastAppFeedItem alloc] init];
                         
                         feedItem.serviceName = @"Facebook";
                         feedItem.serviceBadge = fbBadge;
                         feedItem.userName = dictionary[@"name"];
                         feedItem.message = status[@"message"];
                         feedItem.timestamp = [self.dateFormatter dateFromString:status[@"updated_time"]];
                         feedItem.userPic = [self getUIImageFromURLString:dictionary[@"picture"][@"data"][@"url"]];
                         feedItem.idNum = status[@"id"];
                         
                         [self.feedArray addObject:feedItem];
                         
                         [[NSNotificationCenter defaultCenter]
                          postNotificationName:@"IncomingFeedItem"
                          object:feedItem];
                     }
                 }
                 else
                 {
                     //NSLog(@"Facebook failed fetching user object: %@", error);
                 }
             }];
        }
        
        [self.fbService start];
    }
}

@end
