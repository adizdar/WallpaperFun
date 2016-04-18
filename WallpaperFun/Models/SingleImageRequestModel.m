//
//  SingleImageRequestModel.m
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 11/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import "SingleImageRequestModel.h"

@implementation SingleImageRequestModel

#pragma mark - Custom Accessors

- (NSString *)safesearch
{
    return @"true";
}

- (NSString *)orientation
{
    return @"vertical";
}

#pragma mark - Mantle

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"query": @"q",
             @"safesearch": @"safesearch",
             @"orientation": @"orientation"
            };
}

@end
