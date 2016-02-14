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
@property (readwrite, strong) VLIcon *icon;

@end

@implementation VLVenue

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
    }
    
    return self;
}

@end
