//
//  VLDistanceAnnotation.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 15/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLDistanceAnnotation.h"

@implementation VLDistanceAnnotation
- (void)setDistance:(CLLocationDistance)distance {
    _distance = distance;
    MKDistanceFormatter *formatter = [[MKDistanceFormatter alloc] init];
    formatter.unitStyle = MKDistanceFormatterUnitStyleAbbreviated;
    formatter.units = MKDistanceFormatterUnitsDefault;
    self.title = [formatter stringFromDistance:distance];
}

- (void)setExpectedTravelTime:(NSTimeInterval)expectedTravelTime {
    _expectedTravelTime = expectedTravelTime;
    
    NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
    formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleShort;
    
    self.subtitle = [formatter stringFromTimeInterval: expectedTravelTime];
}

@end
