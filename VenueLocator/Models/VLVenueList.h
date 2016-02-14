//
//  VLVenueList.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 14/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLBaseModel.h"
#import "VLVenue.h"

@interface VLVenueList : VLBaseModel

@property (nonatomic, readonly) NSArray<VLVenue *>* items;

@end
