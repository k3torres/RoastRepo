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
    
    //CALL INSTAGRAM FUNCTION
    for (NSString *tags in self.feedProfile.tags)
        [self appendFeedArray:feedArray withTag:tags];
    
    return feedArray;
}


- (void)appendFeedArray:(NSMutableArray *)feed withTag:(NSString *)instagramTag
{
    //we can for loop here through self.feedProfile.tags and change tagURLMedia
    
    NSString *tagURLMedia = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=%@", instagramTag, self.instagramClient_ID];
    NSURL *url = [NSURL URLWithString:tagURLMedia];

    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    // Fetch the JSON response
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    // Make synchronous request
    urlData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    NSDictionary *dictionaryFromResponse = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error:nil];
    
    // Get the objects you want
    NSMutableArray *username        = [dictionaryFromResponse valueForKeyPath:@"data.caption.from.username"];
    NSMutableArray *profileURL      = [dictionaryFromResponse valueForKeyPath:@"data.caption.from.profile_picture"];
    NSMutableArray *message         = [dictionaryFromResponse valueForKeyPath:@"data.caption.text"];
    NSMutableArray *thumbnailURLs   = [dictionaryFromResponse valueForKeyPath:@"data.images.thumbnail.url"];
    NSMutableArray *creation        = [dictionaryFromResponse valueForKeyPath:@"data.caption.created_time"];
    NSMutableArray *idNumber        = [dictionaryFromResponse valueForKeyPath:@"data.caption.id"];
    
    // Construct a String around the Data from the response
    UIImage *instagramBadge = [UIImage imageNamed:@"instagramicon.png"];
    
    //get 5 latest instagram posts for instagramTag
    for (int i=0; i<5; i++)
    {
        //NSLog(@"username = %@\nprofileURL = %@\nidnum = %@\nthumbunailURL = %@" , [username objectAtIndex:i],
              //[profileURL objectAtIndex:i] , [idNumber objectAtIndex:i] , [thumbnailURLs objectAtIndex:i]);
        
        NSURL *imageURL = [NSURL URLWithString:[thumbnailURLs objectAtIndex:i]];
        NSData *data = [NSData dataWithContentsOfURL:imageURL];
        UIImage *userPic = [UIImage imageWithData:data];
        
        RoastAppFeedItem *feedItem1 = [[RoastAppFeedItem alloc] init];
        
        feedItem1.serviceName = @"Instagram";
        feedItem1.serviceBadge = instagramBadge;
        feedItem1.userName = [username objectAtIndex:i];
        feedItem1.message = [message objectAtIndex:i];
        
        //date
        
        feedItem1.timestamp = [self feedDateFormatter:[creation objectAtIndex:i]];
        //done with date
        
        feedItem1.userPic = userPic;
        
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber = [f numberFromString:[idNumber objectAtIndex:i]];
        feedItem1.idNum = myNumber;
        
        [feed addObject:feedItem1];
    }
    
    NSLog(@"added instagram feedItems with tag = %@" , instagramTag );
    
}

-(NSString *)feedDateFormatter:(NSString *)oldDate
{
    //Format the date to match Twitter
    NSNumberFormatter * d = [[NSNumberFormatter alloc] init];
    [d setNumberStyle:NSNumberFormatterDecimalStyle];
    
    double dateNum = [[d numberFromString:oldDate] doubleValue];
    
    //use interval to get human readable date
    NSTimeInterval interval = dateNum;
    NSDate *aDate = [NSDate dateWithTimeIntervalSince1970: interval];
    
    //set format and return string
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [f setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    NSString *newDate = [f stringFromDate:aDate];
    
    return newDate;
    
}


@end
