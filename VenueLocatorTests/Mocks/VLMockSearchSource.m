//
//  VLMockSearchSource.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 16/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLMockSearchSource.h"

@implementation VLMockSearchSource

- (void)searchForQuery: (NSString * _Nullable)query
              latitude: (double)latitude
             longitude: (double)longitude
                radius: (double)radius
       successCallback: (void (^ __nullable)(VLVenueList * _Nullable))successCallback
         errorCallback: (void (^ __nullable)(NSError  * _Nullable ))errorCallback {

    
    switch (self.state) {
        case VLMockSearchSourceShouldReturnData: {
            
            //this could go into a plist
            NSDictionary *validInput = @{ @"venues" :
                                              @[@{
                                                    @"id" : @"1234",
                                                    @"name" : @"test",
                                                    @"location" : @{
                                                            @"distance" : @(12),
                                                            @"formattedAddress" : @[@"Address 1", @"Address 2"]
                                                            }
                                                    },
                                                ]
                                          };
            
            VLVenueList *venueList = [[VLVenueList alloc] initWithDictionary:validInput];
            if (successCallback) {
                successCallback(venueList);
            }
        }
    
            break;
        case VLMockSearchSourceShouldReturnEmpty: {
            NSDictionary *emptyInput = @{ @"venues" : @[]};
            VLVenueList *venueList = [[VLVenueList alloc] initWithDictionary:emptyInput];
            if (successCallback) {
                successCallback(venueList);
            }
        }
            
        case VLMockSearchSourceShouldReturnError: {
            if (errorCallback) {
                errorCallback(nil);
            }
        }
    }
}

@end
