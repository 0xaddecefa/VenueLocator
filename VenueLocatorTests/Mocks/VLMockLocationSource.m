//
//  VLMockLocationSource.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 16/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLMockLocationSource.h"

@implementation VLMockLocationSource
- (LocationSourceStatus)getStatus {
    return LocationSourceStatusAuthorized;
}

- (CLLocation *)getLatestUserLocation {
    switch (self.state) {
        case VLMockLocationSourceLocation:
            return [[CLLocation alloc] initWithLatitude:55.6761 longitude:12.5683];
        case VLMockLocationSourceNoLocation:
            return nil;
    }
}

- (void)startUpdating {}

@end
