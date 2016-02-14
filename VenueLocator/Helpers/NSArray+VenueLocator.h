//
//  NSArray+VenueLocator.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 14/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray(VenueLocator)
- (NSArray *)vl_map:(id (^)(id obj))block;
@end
