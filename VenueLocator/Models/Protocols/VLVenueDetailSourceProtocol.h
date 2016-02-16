//
//  VLVenueDetailSourceProtocol.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 16/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VLCompleteVenue.h"

@protocol VLVenueDetailSourceProtocol <NSObject>
@required

- (void)loadVenueWithID: (NSString * __nullable)venueID
        successCallback: (void (^ __nullable)(VLCompleteVenue * _Nullable))successCallback
          errorCallback: (void (^ __nullable)(NSError  * _Nullable ))errorCallback;

@end