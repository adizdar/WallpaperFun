//
//  SingleImageView.m
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 14/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import "SingleImageView.h"

@implementation SingleImageView

#pragma mark - Lifecycle

- (instancetype) initWithImageData: (NSData *)imageData imageName:(NSString *)imageName
{
    self = [super initWithImage: nil];
    
    if (!self) return nil;
    
    float screenHeight = [UIScreen mainScreen].bounds.size.height;
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGRect frame = CGRectMake(0, 0, screenWidth, screenHeight);
    
    self.frame = frame;
    self.image = [[UIImage alloc] initWithData: imageData]; // to be sure that auto cycle will clear the memory
    self.imageName = [[NSString alloc] initWithString: imageName];
    
    return self;
}

#pragma mark - Custom Accessors

#pragma mark - Public

- (void)saveImage
{
    UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil);
}

#pragma mark - Private



@end
