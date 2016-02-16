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
@property (nonatomic, assign) LocationSourceStatus status;
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

- (instancetype)init {
    self = [super init];
    if (self) {
        self.status = LocationSourceStatusNotDetermined;
        
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse ||
            [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways) {
            [self startUpdating];
        }
    }
    
    return self;
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
        self.status = LocationSourceStatusAuthorized;
    } else {
        if(status == kCLAuthorizationStatusNotDetermined) {
            self.status = LocationSourceStatusNotDetermined;
        } else {
            self.status = LocationSourceStatusDenied;
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = DYNAMIC_CAST(locations.lastObject, CLLocation);
    if (!self.latestUserLocation || [location distanceFromLocation:self.latestUserLocation] > self.locationManager.desiredAccuracy * 10.0) {
        self.latestUserLocation = location;
    }
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

#pragma mark - LocationSourceProtocol

- (CLLocation *)getLatestUserLocation {
    return self.latestUserLocation;
}

- (LocationSourceStatus)getStatus {
    return self.status;
}

@end
