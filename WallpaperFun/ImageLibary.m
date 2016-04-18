//
//  ImageLibary.m
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 14/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import "ImageLibary.h"

@implementation ImageLibary

#pragma mark - Lifecycle

static NSString *const albumName = @"WallpaperFun";

- (instancetype)init
{
    self = [super init];
    
    if (!self) return nil;
    
    self.library = [[ALAssetsLibrary alloc] init];
    
    // create Album with name
    [self.library addAssetsGroupAlbumWithName: albumName
                                  resultBlock: ^(ALAssetsGroup *group) {
                                      
                                  } failureBlock: ^(NSError *error) {
                                      NSLog(@"NO album:%@", albumName);
                                  }];
    [self findAlbum];
    
    return self;
}

#pragma mark - Custom Accessors

#pragma mark - Public

- (void) saveImageToLibary: (UIImage *)image
{
    [self.library writeImageToSavedPhotosAlbum: image.CGImage
                                   orientation: (ALAssetOrientation) image.imageOrientation
                               completionBlock:^(NSURL *assetURL, NSError *error) {
                                   
                                   if (error.code != 0) {
                                       NSLog(@"saved image failed.\nerror code %li\n%@", (long)error.code, [error localizedDescription]);
                                       return;
                                   }
                                   
                                   // try to get the asset
                                   [self.library assetForURL:assetURL
                                                 resultBlock:^(ALAsset *asset) {
                                                     // assign the photo to the album
                                                     [self.albumGroupToAdd addAsset:asset];
                                                     NSLog(@"Added %@ to %@", [[asset defaultRepresentation] filename], albumName);
                                                 }
                                                failureBlock:^(NSError* error) {
                                                    NSLog(@"failed to retrieve image asset:\nError: %@ ", [error localizedDescription]);
                                                }];

                               }];
}

- (void)findAlbum
{
    [self.library enumerateGroupsWithTypes:ALAssetsGroupAlbum
                                usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                    
                                    if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:albumName]) {
                                        self.albumGroupToAdd = group;
                                    }
                                    
                                }
                              failureBlock:^(NSError* error) {
                                  NSLog(@"failed to enumerate albums:\nError: %@", [error localizedDescription]);
                              }];
    
}

#pragma mark - Private


@end
