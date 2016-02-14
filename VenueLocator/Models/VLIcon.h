//
//  VLIcon.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 13/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLBaseModel.h"

typedef NS_ENUM(NSUInteger, VLIconSize) {
    VLIconSizeSmall = 32,
    VLIconSizeMedium = 64,
    VLIconSizeBig = 88
};

@interface VLIcon : VLBaseModel
- (NSURL *)urlForSize:(VLIconSize)iconSize andWithBackground:(BOOL)withBackground;
@end
