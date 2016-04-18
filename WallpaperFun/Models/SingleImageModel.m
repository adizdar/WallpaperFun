//
//  SingleImageModel.m
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 11/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import "SingleImageModel.h"

@implementation SingleImageModel

#pragma mark - Mantle JSONKeyPathsByPropertyKey

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"tags": @"tags",
             @"url": @"webformatURL",
             @"imageWidth": @"imageWidth",
             @"imageHeight": @"imageHeight",
             @"imageId": @"id"
             };
}



@end
