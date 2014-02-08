//
//  RoastAppServerImageHandler.m
//  Roast
//
//  Created by Nicholas Variz on 2/7/14.
//  Copyright (c) 2014 Affiliated. All rights reserved.
//

#import "RoastAppServerImageHandler.h"

@implementation RoastAppServerImageHandler

// Get image from Tomcat server via <server ip>/roast/GetCafeImages?image=<filename>
+(UIImage *)requestCafeImages:(NSString *)imageName{
    
    NSString *fullURL = [[@"http://54.201.5.175:8080/roast/" stringByAppendingString:@"GetCafeImages?image="] stringByAppendingString:imageName];
    
    UIImage* img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:fullURL]]];
    
    return img;
}

@end
