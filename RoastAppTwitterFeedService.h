//
//  RoastAppTwitterFeedService.h
//  Roast
//
//  Created by Alexander Kissinger on 3/23/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppFeedService.h"
#import "STTwitterAPI.h"


@interface RoastAppTwitterFeedService : RoastAppFeedService

@property STTwitterAPI *twitterService;
@property NSString *twitterConsumerKey;
@property NSString *twitterConsumerShh;

/*** Overridden Methods ***/
- (void)retrieveNewFeeds;

/*** Class Specific Methods ***/
- (STTwitterAPI *)connectTwitter;

@end
