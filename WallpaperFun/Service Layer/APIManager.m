//
//  APIManager.m
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 11/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager

static NSString *const kImagesListPath = @"";
static NSString *const apiKey = @"632377-16b4e17beb3981d0b97b429f3";

- (NSURLSessionDataTask *) getImagesWithRequestModel:(SingleImageRequestModel *)requestModel
                                             success:(void (^)(SingleImageResponseModel *responseModel))success
                                             failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = [MTLJSONAdapter JSONDictionaryFromModel:requestModel error:nil];
    NSMutableDictionary *parametersWithKey = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    
    [parametersWithKey setObject: apiKey forKey: @"key"];
    
    return [self GET:kImagesListPath parameters:parametersWithKey progress:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 
                 NSError *error;
                 NSDictionary *responseDictionary = (NSDictionary *)responseObject;
                 
                 SingleImageResponseModel *list = [MTLJSONAdapter modelOfClass:SingleImageResponseModel.class
                                                            fromJSONDictionary:responseDictionary error:&error];
                 success(list);
                 
             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 
                 failure(error);
                 
             }];
    
}

- (NSURLSessionDataTask *) getEditorChoiceImagesWithRequestModel:(SingleImageRequestModel *)requestModel
                                                         success:(void (^)(SingleImageResponseModel *responseModel))success
                                                         failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = [MTLJSONAdapter JSONDictionaryFromModel:requestModel error:nil];
    NSMutableDictionary *parametersWithKey = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    
    [parametersWithKey setObject: apiKey forKey: @"key"];
    [parametersWithKey setObject: @"true" forKey: @"editors_choice"];
        
    return [self GET:kImagesListPath parameters:parametersWithKey progress:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 
                 NSError *error;
                 NSDictionary *responseDictionary = (NSDictionary *)responseObject;
                 
                 SingleImageResponseModel *list = [MTLJSONAdapter modelOfClass:SingleImageResponseModel.class
                                                            fromJSONDictionary:responseDictionary error:&error];
                 success(list);
                 
             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 
                 failure(error);
                 
             }];
    
}



@end
