//
//  APIClient.h
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 10/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

/** Universal API CLient
 @discussion Base Client for communication with the API
 @param APIClient inherits from AFHTTPSessionManager
 */
@interface APIClient : AFHTTPSessionManager

/** Singleton for retriving sharedManager
 @return id
 */
+ (id)sharedManager;

@end
