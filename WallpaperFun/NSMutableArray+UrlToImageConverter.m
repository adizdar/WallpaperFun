//
//  NSMutableArray+UrlToImageConverter.m
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 17/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import "NSMutableArray+UrlToImageConverter.h"

@implementation NSMutableArray (UrlToImageConverter)

NSUInteger objectIndex = 0;
id currentObject = nil;

- (id)getImageObjectAtIndex:(NSUInteger)index
{
    SingleImageModel *imageModel;
    index = index % ([self count]);

    if (![[self objectAtIndex: index] isKindOfClass: [SingleImageModel class]]) {
        NSLog(@"NSMutableArray+UrlToImageConverter -> No Object type of SingleImageModel");
        return nil;
    }
    
    imageModel = [self objectAtIndex: index];
    return [self convertUrlToImage: imageModel.url imageName: [@(imageModel.imageId) stringValue]];
}


- (SingleImageView *)convertUrlToImage:(NSString *)url imageName: (NSString *)imageName
{
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
    
    return [[SingleImageView alloc] initWithImageData: imageData imageName: imageName];
}

- (id)getNextObject
{
    NSUInteger index = 0;
    
    if(!self.count) return nil;
    
    if (!currentObject) {
        currentObject = [self objectAtIndex:0];
    }
    
    for (id object in self) {
        index = [self indexOfObject: object];

        if (currentObject == object && index != [self count]-1) {
            currentObject =  [self objectAtIndex: index+1];
            break;
        } else if (currentObject == object && index == [self count]-1) {
            return nil;
        }
    }
    
    return currentObject ? [self getImageObjectAtIndex: [self indexOfObject: currentObject]] : nil;
}

- (id)getPreviousObject
{
    NSUInteger index = 0;
    
    if(!self.count) return nil;
    
    if (!currentObject) {
        currentObject = [self objectAtIndex:0];
    }
    
    for (id object in self) {
        index = [self indexOfObject: object];
        
        if (currentObject == object && index != 0) {
            currentObject = [self objectAtIndex: index-1];
            break;
        } else if (currentObject == object && index == 0) {
            return nil;
        }
    }
    
    return currentObject ? [self getImageObjectAtIndex: [self indexOfObject: currentObject]] : nil;
}

- (int)getCurrentObjectIndex
{
    return (int)[self indexOfObject: currentObject];
}

- (void)resetCurrentObject
{
    currentObject = nil;
    
    if ([self count] != 0 && [[self getImageObjectAtIndex: 0] isKindOfClass: [SingleImageView class]]) {
        currentObject = [self objectAtIndex:0];
    }
}


@end
