//
//  SingleImageResponseModel.h
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 11/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import "SingleImageModel.h"
#import "MTLModel.h"
#import <Mantle/Mantle.h>

/** Image collection
 * @discussion Response model collection
 */
@interface SingleImageResponseModel : MTLModel <MTLJSONSerializing>

/** Image collection for representing a collection of SingleImageModel's  */
@property (nonatomic, copy) NSMutableArray *collection;

/** Transform mapper for response JSON, it maps the coresponding properties to the 
    properties declared in JSONKeyPathsByPropertyKey 
    @warning the name of the transformer needs to match the name that you want to foramt, example
             for the collection propertie the name needs to strart with collection
 */
+ (NSValueTransformer *)collectionJSONTransformer;

@end
