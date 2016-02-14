//
//  VLVenue.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 13/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLBaseModel.h"
#import "VLIcon.h"

@interface VLVenue : VLBaseModel

@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) VLIcon *icon;
@end
