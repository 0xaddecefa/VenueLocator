//
//  VLLocationManager.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 14/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


typedef enum LocationManagerStatus {
    LocationManagerStatusNotDetermined = 0,
    LocationManagerStatusDenied,
    LocationManagerStatusAuthorized,
} _LocationManagerStatus;

@interface VLLocationManager : NSObject

@property (nonatomic, readonly) enum LocationManagerStatus status;
@property (nonatomic, readonly) CLLocation *latestUserLocation;

+ (VLLocationManager *)sharedInstance;
- (void)startUpdating;
- (void)stopUpdating;

@end
