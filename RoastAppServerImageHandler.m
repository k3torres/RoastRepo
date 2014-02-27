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

/* All carousel images will be in a table on server, so this will first get a json array of all the filenames
 * of imageNames for the requested cafe, then by looping through this json array each image is loaded and inserted
 * into the array that will be returned to the caller
 */
+(NSMutableArray *)requestCafeImagesForCarousel:(NSString *)cafeName{
    
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    
    //SELECT filename FROM CarouselPics WHERE cafe LIKE '%cafeName%';
    NSString *fullURL = [[@"http://54.201.5.175:8080/roast/" stringByAppendingString:@"GetCarouselFilenames?cafe="] stringByAppendingString:cafeName];
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:fullURL]];
    NSError *error;
    NSDictionary *dictionaryFromResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    NSArray *jsonArray = [dictionaryFromResponse allValues];
    
    for( NSString* currentString in [jsonArray objectAtIndex:0]){
        UIImage * temp = [[UIImage alloc] init];
        temp = [RoastAppServerImageHandler requestCafeImages:currentString];
        [imageArray addObject:temp];
    }
    return imageArray;
}

@end
