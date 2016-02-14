//
//  VLVenueList.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 14/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLVenueList.h"

@interface VLVenueList()

@property (nonatomic, readwrite) NSArray<VLVenue *>* items;

@end

@implementation VLVenueList

- (instancetype)initWithDictionary: (NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
    }
    
    return self;
}


@end
