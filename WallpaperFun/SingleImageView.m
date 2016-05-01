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

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithImage: nil];
    
    if (!self) return nil;
    
    [self setup];
    
    self.image = image;
    self.imageName = @"default";
    
    return self;
}

- (instancetype)initWithImageData: (NSData *)imageData imageName:(NSString *)imageName
{
    self = [super initWithImage: nil];
    
    if (!self) return nil;
    
    [self setup];
    
    self.image = [[UIImage alloc] initWithData: imageData]; // to be sure that auto cycle will clear the memory
    self.imageName = imageName;
    
    return self;
}

- (void)setup
{
    float screenHeight = [UIScreen mainScreen].bounds.size.height;
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.frame = CGRectMake(0, 0, screenWidth, screenHeight);
}

#pragma mark - Custom Accessors

#pragma mark - Public

// Don't used in this app, but I left it here for future funcionality
- (void)saveImage
{
    UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil);
}

#pragma mark - Private



@end
