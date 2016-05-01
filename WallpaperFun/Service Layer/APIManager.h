//
//  APIManager.h
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 11/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import "APIClient.h"
#import "SingleImageRequestModel.h"
#import "SingleImageResponseModel.h"

/** APIManager for obtaining data from PixelBay
 */
@interface APIManager : APIClient

/** GET method to obtain image collection
 @disscussion data fetched from pixabay API
 @param requestModel represents SingleImageRequestModel used to send request data
 @param success using BLOCK to obrain respone data as SingleImageResponseModel
 @param failure NSError BLOCK
 @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *) getImagesWithRequestModel:(SingleImageRequestModel *)requestModel
                                               success:(void (^)(SingleImageResponseModel *responseModel))success
                                               failure:(void (^)(NSError *error))failure;

/** GET method to get editor choice (favorites) image collection
 @disscussion data fetched from pixabay API
 @param requestModel represents SingleImageRequestModel used to send request data
 @param success using BLOCK to obrain respone data as SingleImageResponseModel
 @param failure NSError BLOCK
 @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *) getEditorChoiceImagesWithRequestModel:(SingleImageRequestModel *)requestModel
                                                          success:(void (^)(SingleImageResponseModel *responseModel))success
                                                          failure:(void (^)(NSError *error))failure;

@end
