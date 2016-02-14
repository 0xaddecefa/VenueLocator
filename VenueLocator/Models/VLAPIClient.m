//
//  VLAPIClient.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 14/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLAPIClient.h"
#import "AFNetworking.h"

@interface VLAPIClient()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSString *baseURL;
@end

@implementation VLAPIClient

+ (instancetype)sharedInstance {
    static VLAPIClient *sharedInstance = nil;
    static dispatch_once_t pred;
    
    if (sharedInstance) return sharedInstance;
    
    dispatch_once(&pred, ^{
        sharedInstance = [VLAPIClient new];
    });
    
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    self.baseURL = @"https://api.foursquare.com/v2/";
    
    return self;
}



- (NSURLSessionDataTask *)searchForQuery: (NSString *)query
                               lattitude: (double)lattitude
                               longitude: (double)longitude
                                  radius: (double)radius
                         successCallback: (void (^ __nullable)(VLVenueList *))successCallback
                           errorCallback: (void (^ __nullable)(NSError *))errorCallback
{
    
    NSMutableDictionary *parameters = [VLAPIClient defaultParameters];
    [parameters addEntriesFromDictionary:@{
                                           @"intent"    : @"browse",
                                           @"ll"        : @"40.7,-74",
                                           @"radius"    : @"2500",
                                           @"v"         : @"20120610"
                                           }];
    NSString *url = [self urlStringForResource:@"venues/search"];
    return [self.manager GET: url
                  parameters: parameters
                    progress: nil
                     success: ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         if (successCallback) {
                             NSDictionary *responseDictionary = DYNAMIC_CAST(responseObject, NSDictionary);
                             responseDictionary = responseDictionary[@"response"];
                             
                             VLVenueList *venueList = [[VLVenueList alloc] initWithDictionary:responseDictionary];
                             successCallback(venueList);
                         }
                     }
                     failure: ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         if (errorCallback) {
                             errorCallback(error);
                         }
                     }];
}


- (NSString *)urlStringForResource:(NSString *)resource {
    return [NSString stringWithFormat:@"%@%@", self.baseURL, resource];
}


// As FourSquare API requires to have the client parameters in the query, not as header fields,
// a default dictionary with those parameters are neccessiary to create by a factory method

+ (NSMutableDictionary *)defaultParameters {
    NSMutableDictionary *defaultParams = [@{
                                            @"client_id" : CLIENT_ID,
                                            @"client_secret" : CLIENT_SECRET,
                                            } mutableCopy];
    return defaultParams;
}

@end
