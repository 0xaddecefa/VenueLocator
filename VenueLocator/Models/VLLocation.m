//
//  VLLocation.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 14/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLLocation.h"

@interface VLLocation()

@property (nonatomic, strong) NSArray *formattedAddress;
@property (nonatomic, assign) NSUInteger distance;

@end

@implementation VLLocation

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.formattedAddress = DYNAMIC_CAST(dictionary[@"formattedAddress"], NSArray);
        self.distance = [DYNAMIC_CAST(dictionary[@"distance"], NSNumber) unsignedIntegerValue];
    }
    return self;
}

@end
