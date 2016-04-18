//
//  ImageRealm.h
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 13/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

/** Image model that stores data from the API
  @discussion Realm DB used
 */
#import <Realm/Realm.h>
#import "SingleImageModel.h"

@interface ImageRealm : RLMObject

/** User tags, like categories where the image is assosiciated with 
    @warning properties in the model class have no attributes like nonatomic, strong, or copy. Realm takes care of those and we need not worry about them.
 */
@property NSString *tags;
/** Represents the image URL */
@property NSString *url;
/** Image Width */
@property int imageWidth;
/** Image Height */
@property int imageHeight;

- (id)initWithMantleModel:(SingleImageModel *)imageModel;


@end
