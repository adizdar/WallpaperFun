//
//  SingleImageModel.h
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 11/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

/** 
 @discussion Model for representing the single image tkaen from pixabay API
 @warning The return type of the response needs to match the type of the declared properties, 
          when not you get nil as response when ypu try to map it
 */
@interface SingleImageModel : MTLModel <MTLJSONSerializing>

/** User tags, like categories where the image is assosiciated with */
@property (nonatomic, copy) NSString *tags;
/** Represents the image URL */
@property (nonatomic, copy) NSString *url;
/** Image Width */
@property int imageWidth;
/** Image Height */
@property int imageHeight;
/** Image ID */
@property NSInteger imageId;

@end
