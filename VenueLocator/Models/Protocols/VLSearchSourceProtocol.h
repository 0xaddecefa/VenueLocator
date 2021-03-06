//
//  VLSearchSourceProtocol.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 16/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VLVenueList.h"

@protocol VLSearchSourceProtocol <NSObject>
@required

- (void)searchForQuery: (NSString * _Nullable)query
              latitude: (double)latitude
             longitude: (double)longitude
                radius: (double)radius
       successCallback: (void (^ __nullable)(VLVenueList * _Nullable))successCallback
         errorCallback: (void (^ __nullable)(NSError  * _Nullable ))errorCallback;

@end