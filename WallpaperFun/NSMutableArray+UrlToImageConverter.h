//
//  NSMutableArray+UrlToImageConverter.h
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 17/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleImageModel.h"
#import "SingleImageView.h"

/** Category for NSMutableArray to extend behaviour for working with images */
@interface NSMutableArray (UrlToImageConverter)

/** Converting ImageModel to ImageView */
- (void)getImageObjectAtIndex:(NSUInteger)index andBlock:(void (^)(SingleImageView *imageView))getImageView;

/** Get next object from array 
 */
- (void)getNextObject: (void (^)(SingleImageView *imageView))getImageView;

/** Get previous object from array 
 */
- (void)getPreviousObject: (void (^)(SingleImageView *imageView))getImageView;

/** Get current object index
    @description max index is length-1
    @return int
 */
- (int)getCurrentObjectIndex;

/** Reset the object used for next/back iteration */
- (void)resetCurrentObject;

@end
