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

#pragma mark - JSON Transformers

//** Convert url to get the bigger image
+ (NSValueTransformer *)urlJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock: ^id(NSString* value, BOOL *success, NSError *__autoreleasing *error) {
        return [value stringByReplacingOccurrencesOfString:@"640" withString: @"960"];
    } reverseBlock: ^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return value;
    }];
}


@end
