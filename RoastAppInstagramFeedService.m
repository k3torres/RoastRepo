//
//  RoastAppInstagramFeedService.m
//  Roast
//
//  Created by Alexander Kissinger on 3/24/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppInstagramFeedService.h"

@implementation RoastAppInstagramFeedService
NSString * const CLIENT_ID = @"159d17709bf84b329e5fe4a388afe380";
NSString * const URL_REQ_FORMAT = @"https://api.instagram.com/v1/tags/%@/media/recent?client_id=%@";

- (RoastAppInstagramFeedService *)init
{
    self = [super init];
    
    return self;
}

- (RoastAppInstagramFeedService *)initWithFeedProfile:(RoastAppFeedProfile *)newProfile
{
    self = [super initWithProfile:newProfile];
    
    return self;
}

- (void)retrieveNewFeeds
{
    for(NSString *instagramTag in self.feedProfile.tags)
    {
        //we can for loop here through self.feedProfile.tags and change tagURLMedia
        NSURLRequest *urlRequest =
            [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:URL_REQ_FORMAT,instagramTag, CLIENT_ID]]];
        
        // Make asynchronous request
        [NSURLConnection
            sendAsynchronousRequest:urlRequest
            queue:[[NSOperationQueue alloc] init]
            completionHandler:^(NSURLResponse *response, NSData *urlData, NSError *connectionError)
         {
             if (!connectionError)
             {
                 NSDictionary *parsedDict = [NSJSONSerialization
                                                            JSONObjectWithData:urlData
                                                            options:NSJSONReadingMutableContainers
                                                            error:nil];
                 
                 //get 3 latest instagram posts for instagramTag
                 UIImage *instagramBadge = [UIImage imageNamed:@"instagramicon.png"];
                 
                 NSNumberFormatter * numFormatter = [[NSNumberFormatter alloc] init];
                 [numFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                 
                 for (int i = 0; i < 3; i++)
                 {
                     RoastAppFeedItem *feedItem = [[RoastAppFeedItem alloc] init];

                     feedItem.serviceName = @"Instagram";
                     feedItem.serviceBadge = instagramBadge;
                     feedItem.userName = [[parsedDict
                                           valueForKeyPath:@"data.user.username"]
                                           objectAtIndex:i];
                     feedItem.photo = [UIImage imageWithData:
                                       [NSData dataWithContentsOfURL:
                                        [NSURL URLWithString:[[parsedDict
                                                               valueForKeyPath:@"data.images.low_resolution.url"]
                                                              objectAtIndex:i]]]];
                     feedItem.userPic = [UIImage imageWithData:
                                         [NSData dataWithContentsOfURL:
                                          [NSURL URLWithString:[[parsedDict
                                                                 valueForKeyPath:@"data.user.profile_picture"]
                                                                objectAtIndex:i]]]];
                     feedItem.timestamp = [NSDate dateWithTimeIntervalSince1970:
                                           [[[parsedDict valueForKeyPath:@"data.created_time"]
                                             objectAtIndex:i]
                                            integerValue]];
                     feedItem.idNum = [numFormatter numberFromString:[[parsedDict valueForKeyPath:@"data.user.id"] objectAtIndex:i]];
                     
                     if ([[parsedDict valueForKeyPath:@"data.caption.text"] objectAtIndex:i] == [NSNull null])
                     {
                         feedItem.message = [NSString stringWithFormat:@"#%@" , instagramTag];
                     }
                     else
                     {
                         feedItem.message = [[parsedDict valueForKeyPath:@"data.caption.text"] objectAtIndex:i];
                     }
                     
                     [[NSNotificationCenter defaultCenter]
                      postNotificationName:@"IncomingFeedItem"
                      object:feedItem];
                 }
             }
             else
             {
                 NSLog(@"Instagram failed fetching tag object: %@", connectionError);
             }
         }];
    }
}

@end
