//
//  VLDistanceAnnotation.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 15/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface VLDistanceAnnotation : MKPointAnnotation
@property (nonatomic, assign) CLLocationDistance distance; // overall route distance in meters
@property (nonatomic, assign) NSTimeInterval expectedTravelTime;
@end
