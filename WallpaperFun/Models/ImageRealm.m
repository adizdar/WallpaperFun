//
//  ImageRealm.m
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 13/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import "ImageRealm.h"

@implementation ImageRealm

- (id)initWithMantleModel:(SingleImageModel *)imageModel
{
    self = [super init];
    if(!self) return nil;
    
    self.url = imageModel.url;
    self.imageWidth = imageModel.imageWidth;
    self.imageHeight = imageModel.imageHeight;
    self.tags = imageModel.tags;
    
    return self;
}

@end
