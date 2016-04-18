//
//  SingleImageView.h
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 14/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import <UIKit/UIKit.h>

/** Image representer */
@interface SingleImageView : UIImageView

/** Image name */
@property(nonatomic, strong) NSString *imageName;

/** Custom init method */
- (instancetype) initWithImageData: (NSData *)imageData imageName:(NSString *)imageName;

/** Save Image to filestore */
- (void)saveImage;

@end
