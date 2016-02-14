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
        NSArray *venuesJSON = DYNAMIC_CAST(dictionary[@"venues"], NSArray);

        self.items = [venuesJSON vl_map:^id(id obj) {
            NSDictionary *dictionary = DYNAMIC_CAST(obj, NSDictionary);
            if (dictionary) {
                VLVenue *venue = [[VLVenue alloc] initWithDictionary:dictionary];
                return venue;
            }
            
            return nil;
        }];
        
    }
    
    return self;
}


@end
