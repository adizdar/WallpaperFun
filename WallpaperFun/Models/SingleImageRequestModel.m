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

- (NSUInteger)requestedNumberOfImages
{
    return 40;
}

#pragma mark - Mantle JSONKeyPathsByPropertyKey

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"query": @"q",
             @"safesearch": @"safesearch",
             @"orientation": @"orientation",
             @"requestedNumberOfImages" : @"per_page"
            };
}

#pragma mark - JSON Transformers

//** Convert spaces in query to + sign
+ (NSValueTransformer *)queryJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock: ^id(NSString* value, BOOL *success, NSError *__autoreleasing *error) {
        return value;
    } reverseBlock: ^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [value stringByReplacingOccurrencesOfString: @" "
                                                withString: @"+"];
    }];
}

@end
