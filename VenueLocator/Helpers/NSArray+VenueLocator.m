//
//  NSArray+VenueLocator.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 14/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "NSArray+VenueLocator.h"

@implementation NSArray(VenueLocator)

- (NSArray *)vl_map:(id (^)(id obj))block {
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:[self count]];
    for (id element in self) {
        id newElement = block(element);
        if (newElement) {
            [resultArray addObject:newElement];
        }
    }
    
    return [resultArray copy];
}


@end
