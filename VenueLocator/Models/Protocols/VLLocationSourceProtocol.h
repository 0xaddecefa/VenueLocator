//
//  Header.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 16/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


typedef NS_ENUM(NSUInteger, LocationSourceStatus) {
    LocationSourceStatusNotDetermined = 0,
    LocationSourceStatusDenied,
    LocationSourceStatusAuthorized,
};


@protocol VLLocationSourceProtocol <NSObject>
@required
- (LocationSourceStatus)getStatus;
- (CLLocation *)getLatestUserLocation;
@end