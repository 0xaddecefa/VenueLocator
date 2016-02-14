//
//  VLAPIClient.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 14/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VLVenueList.h"

@interface VLAPIClient : NSObject

+ (instancetype _Nullable)sharedInstance;

- (NSURLSessionDataTask * _Nullable)searchForQuery: (NSString * _Nullable)query
                               lattitude: (double)lattitude
                               longitude: (double)longitude
                                  radius: (double)radius
                         successCallback: (void (^ __nullable)(VLVenueList * _Nullable))successCallback
                           errorCallback: (void (^ __nullable)(NSError  * _Nullable ))errorCallback;
@end
