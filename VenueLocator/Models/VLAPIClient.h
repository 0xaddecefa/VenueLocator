//
//  VLAPIClient.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 14/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VLVenueList.h"
#import "VLCompleteVenue.h"

@interface VLAPIClient : NSObject

+ (instancetype _Nullable)sharedInstance;

- (void)searchForQuery: (NSString * _Nullable)query
              latitude: (double)latitude
             longitude: (double)longitude
                radius: (double)radius
       successCallback: (void (^ __nullable)(VLVenueList * _Nullable))successCallback
         errorCallback: (void (^ __nullable)(NSError  * _Nullable ))errorCallback;

- (void)loadVenueWithID: (NSString * __nullable)venueID
        successCallback: (void (^ __nullable)(VLCompleteVenue * _Nullable))successCallback
          errorCallback: (void (^ __nullable)(NSError  * _Nullable ))errorCallback;

@end
