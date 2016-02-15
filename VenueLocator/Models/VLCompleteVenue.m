//
//  VLCompleteVenue.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 15/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLCompleteVenue.h"

@interface VLCompleteVenue()
@property (nonatomic, readwrite) NSString *venueDescription;
@end

@implementation VLCompleteVenue
- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.venueDescription = DYNAMIC_CAST(dictionary[@"description"], NSString);
    }
    return self;
}
@end
