//
//  SingleImageRequestModel.h
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 11/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import <Mantle/Mantle.h>

/** Request model for pixabay
 * @discussion Requesting image data
 */
@interface SingleImageRequestModel : MTLModel<MTLJSONSerializing>

/** Qeury string for request */
@property (nonatomic, copy) NSString *query;

/** Safe Search property by default set to true*/
@property (nonatomic, copy) NSString *safesearch;

/** Orientation position by default set to vertical */
@property (nonatomic, copy) NSString *orientation;

/** Number Of images to download */
@property (nonatomic) NSUInteger requestedNumberOfImages;

@end
