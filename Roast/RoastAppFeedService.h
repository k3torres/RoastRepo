//
//  RoastAppFeedService.h
//  Roast
//
//  Created by Alexander Kissinger on 1/31/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FBRequestConnection.h>
#import "RoastAppFeedProfile.h"
#import "STTwitter.h"

@interface RoastAppFeedService : NSObject

@property RoastAppFeedProfile *feedProfile;

@property STTwitterAPI *twitterService;
@property NSString *twitterConsumerKey;
@property NSString *twitterConsumerShh;
@property NSString *instagramClient_ID;
@property NSString *instagramRedirect_URI;
@property NSString *instagramClient_Secret;

@property FBRequestConnection *fbService;
@property NSString *fbAppID;
@property NSString *fbShh;
@property FBRequestConnection *fbReqConn;

- (id)init;
- (id)initWithProfile:(RoastAppFeedProfile *)newProfile;
- (STTwitterAPI *)connectTwitter;
-(NSMutableArray *)populateFeed:(NSMutableArray *)feedArray withTableView:(UITableView *)tableView;


@end
