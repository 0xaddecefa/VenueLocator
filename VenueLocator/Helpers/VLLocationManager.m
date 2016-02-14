//
//  VLLocationManager.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 14/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLLocationManager.h"


@interface VLLocationManager() <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *latestUserLocation;
@property (nonatomic, assign) enum LocationManagerStatus status;
@end

@implementation VLLocationManager

+ (VLLocationManager *)sharedInstance
{
    static VLLocationManager *sharedInstance = nil;
    if (sharedInstance) return sharedInstance;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [VLLocationManager new];
    });
    return sharedInstance;
}

- (void)startUpdating {
    [self.locationManager requestWhenInUseAuthorization];
}

- (void)stopUpdating {
    [self.locationManager stopUpdatingLocation];
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if(status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
        [self.locationManager startUpdatingLocation];
        self.status = LocationManagerStatusAuthorized;
    } else {
        if(status == kCLAuthorizationStatusNotDetermined) {
            self.status = LocationManagerStatusNotDetermined;
        } else {
            self.status = LocationManagerStatusDenied;
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.latestUserLocation = newLocation;
}

#pragma mark - Lazy getters

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [CLLocationManager new];
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        _locationManager.pausesLocationUpdatesAutomatically = YES;
        _locationManager.delegate = self;
    }
    return _locationManager;
}


@end
