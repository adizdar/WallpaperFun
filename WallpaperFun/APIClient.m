//
//  APIClient.m
//  WallpaperFun
//
//  Created by Ahmed Dizdar on 10/04/16.
//  Copyright © 2016 Ahmed Dizdar. All rights reserved.
//

#import "APIClient.h"

@implementation APIClient

static NSString* const BASE_URL = @"https://pixabay.com/api/";

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super initWithBaseURL: [NSURL URLWithString: BASE_URL]];
    
    if (!self) return nil;
    
    [self.requestSerializer setTimeoutInterval: 20.0];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    
    return self;
}

#pragma mark - Custom Accessors

#pragma mark - Public

+ (id)sharedManager
{
    static APIClient *_sessionManager = nil;
    static dispatch_once_t onceToken;
    
    // initialize only once
    dispatch_once(&onceToken, ^{
        _sessionManager = [[self alloc] init];
    });
    
    return _sessionManager;
}

#pragma mark - Private

#pragma mark - Protocol conformance

#pragma mark - NSObject


@end
