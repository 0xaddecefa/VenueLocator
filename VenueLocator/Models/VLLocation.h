//
//  VLLocation.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 14/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLBaseModel.h"

@interface VLLocation : VLBaseModel

@property (nonatomic, readonly) NSArray *formattedAddress;
@property (nonatomic, readonly) NSUInteger distance;

@end
