//
//  PreviewView.h
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 25/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtillsClass.h"

@interface PreviewView : UIImageView

- (UIColor *)averageColor: (UIImage *)bgImage;
- (BOOL) isImageDark: (UIImage *)bgImage;
- (void)setPreviewImage: (UIImage *)bgImage;

@end
