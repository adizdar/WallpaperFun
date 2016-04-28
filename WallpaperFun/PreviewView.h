//
//  PreviewView.h
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 25/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtillsClass.h"

/** Displays Preview image */
@interface PreviewView : UIImageView

/** Theme initializer ( init with image is alos active )
    @parameter lightTheme
    @parameter darkTheme
 */
- (instancetype) initWithThemes: (NSString *)lightTheme
                      darkTheme: (NSString *)darkTheme;

/** Calculates avarge color of image
    @parameter bgImage as UIImage
    @return UIColor
 */
- (UIColor *)averageColor: (UIImage *)bgImage;

/** Checks if image is more likely dark or light
 @parameter bgImage as UIImage
 @return BOOL
 */
- (BOOL) isImageDark: (UIImage *)bgImage;

/** Changes preview image to dark or light color
    @parameter bgImage as UIImage
 */
- (void)setPreviewImage: (UIImage *)bgImage;

/** Set Light and dark preview theme/image
 @parameter lightTheme as NSString
 @parameter darkTheme as NSString
 */
- (void)setLightAndDarkTheme: (NSString *)lightTheme
                   darkTheme: (NSString *)darkTheme;

@end
