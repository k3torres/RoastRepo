//
//  RoastAppFacebookFeedService.h
//  Roast
//
//  Created by Alexander Kissinger on 3/23/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppFeedService.h"
#import <FacebookSDK/FBRequest.h>
#import <FacebookSDK/FBSession.h>
#import <FacebookSDK/FBAccessTokenData.h>
#import <FacebookSDK/FBGraphObject.h>

@interface RoastAppFacebookFeedService : RoastAppFeedService

@property FBRequestConnection *fbService;
@property FBRequestConnection *fbReqConn;

/*** Overridden Methods ***/
- (void)retrieveNewFeeds;

/*** Class Specific Methods ***/
- (FBRequestConnection *)connectFB;
@end
