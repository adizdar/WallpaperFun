//
//  SingleImageResponseModel.m
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 11/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import "SingleImageResponseModel.h"

@implementation SingleImageResponseModel

#pragma mark - Mantle

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"collection" : @"hits"
            };
}

#pragma mark - JSON Transformer

+ (NSValueTransformer *)collectionJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass: SingleImageModel.class];
}


@end
