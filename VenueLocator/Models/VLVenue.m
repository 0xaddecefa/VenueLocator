//
//  VLVenue.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 13/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLVenue.h"

@interface VLVenue()

@property (readwrite, strong) NSString *identifier;
@property (readwrite, strong) NSString *name;
@property (nonatomic, strong) VLLocation *location;

@property (readwrite, strong) VLIcon *icon;
@end

@implementation VLVenue

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.name = DYNAMIC_CAST(dictionary[@"name"], NSString);
        self.identifier = DYNAMIC_CAST(dictionary[@"id"], NSString);
        self.location = [[VLLocation alloc] initWithDictionary:DYNAMIC_CAST(dictionary[@"location"], NSDictionary)];
        
        NSArray *categories = DYNAMIC_CAST(dictionary[@"categories"], NSArray);
        NSDictionary *firstCategory = DYNAMIC_CAST([categories firstObject], NSDictionary);
        NSDictionary *iconForFirstCategory = DYNAMIC_CAST(firstCategory[@"icon"], NSDictionary);
        
        self.icon = [[VLIcon alloc] initWithDictionary:iconForFirstCategory];
    }
    
    return self;
}

@end
