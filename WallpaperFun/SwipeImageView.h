//
//  SwipeImageView.h
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 15/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <pop/POP.h>

#import "SingleImageView.h"
#import "NSMutableArray+UrlToImageConverter.h"
#import "UtillsClass.h"

@protocol SwipeImageViewProtocol <NSObject>

@optional
- (void)imageChanged: (UIImage *)image;
@end

/** Conteiner to manage swipe left and right od items */
@interface SwipeImageView : UIView

/** Initializer 
    @param collestion as NSMutableArray
 */
- (instancetype) initWithCollection:(NSMutableArray *)collection;

/** Collection property
    @desription setter is made to set first element in the SwipeContainer
 */
@property(nonatomic, strong) NSMutableArray *collection;

/** Get current image 
    @return SingleImageView subclassing UIView
 */
- (SingleImageView *)getCurrentImage;

@property (nonatomic, assign) id <SwipeImageViewProtocol> delegate;

@end
