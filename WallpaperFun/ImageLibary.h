//
//  ImageLibary.h
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 14/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "SingleImageView.h"

/** Libary used to store images in album */
@interface ImageLibary : UIView

/** Images libary used to access custom album */
@property (strong, nonatomic) ALAssetsLibrary *library;

/** Album instance */
@property (strong, nonatomic) ALAssetsGroup *albumGroupToAdd;

/** Save image to Phone liabary 
    @param image UIImage
 */
- (void)saveImageToLibary: (UIImage *)image;


@end
