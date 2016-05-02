//
//  NSMutableArray+UrlToImageConverter.m
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 17/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import "NSMutableArray+UrlToImageConverter.h"

@implementation NSMutableArray (UrlToImageConverter)

id currentObject = nil;
NSUInteger objectIndex = 0;

- (void)getImageObjectAtIndex:(NSUInteger)index andBlock:(void (^)(SingleImageView *imageView))getImageView
{
    SingleImageModel *imageModel;
    index = index % ([self count]);

    if (![[self objectAtIndex: index] isKindOfClass: [SingleImageModel class]]) {
        NSLog(@"NSMutableArray+UrlToImageConverter -> No Object type of SingleImageModel");
        return;
    }
    
    imageModel = [self objectAtIndex: index];
    [self convertUrlToImage: imageModel.url
                         imageName: [@(imageModel.imageId) stringValue]
                          andBlock: ^(SingleImageView *imageData) {
                              getImageView(imageData);
                          }];
}


- (void)convertUrlToImage:(NSString *)url
                             imageName: (NSString *)imageName
                              andBlock:(void (^)(SingleImageView *imageData))processImage
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: url]];
        
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error) {
                               if( !error ) {
                                   processImage([[SingleImageView alloc] initWithImageData: data imageName: imageName]);
                               } else {
                                   processImage(nil);
                               }
                           }];
}

- (void)getNextObject: (void (^)(SingleImageView *imageView))getImageView
{
    NSUInteger index = 0;
    
    if(!self.count) {
        getImageView(nil);
        return;
    }
    
    if (!currentObject) {
        currentObject = [self objectAtIndex:0];
    }
    
    for (id object in self) {
        index = [self indexOfObject: object];

        if (currentObject == object && index != [self count]-1) {
            currentObject =  [self objectAtIndex: index+1];
            break;
        } else if (currentObject == object && index == [self count]-1) {
            getImageView(nil);
            return;
        }
    }
    
    [self getImageObjectAtIndex: [self indexOfObject: currentObject]
                       andBlock: ^(SingleImageView *imageView) {
                           getImageView(currentObject ? imageView : nil);
    }];
}

- (void)getPreviousObject: (void (^)(SingleImageView *imageView))getImageView
{
    NSUInteger index = 0;
    
    if(!self.count) {
        getImageView(nil);
        return;
    }
    
    if (!currentObject) {
        currentObject = [self objectAtIndex:0];
    }
    
    for (id object in self) {
        index = [self indexOfObject: object];
        
        if (currentObject == object && index != 0) {
            currentObject = [self objectAtIndex: index-1];
            break;
        } else if (currentObject == object && index == 0) {
            getImageView(nil);
            return;
        }
    }
    
    [self getImageObjectAtIndex: [self indexOfObject: currentObject]
                       andBlock: ^(SingleImageView *imageView) {
                           getImageView(currentObject ? imageView : nil);
                       }];
    
}

- (int)getCurrentObjectIndex
{
    return (int)[self indexOfObject: currentObject];
}

- (void)resetCurrentObject
{
    currentObject = nil;
    
    if ([self count] != 0) {
        currentObject = [self objectAtIndex:0];
    }
}


@end
