//
//  VLMockLocationSource.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 16/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VLLocationSourceProtocol.h"

typedef NS_ENUM(NSUInteger, VLMockLocationSourceState) {
    VLMockLocationSourceLocation,
    VLMockLocationSourceNoLocation,
};

@interface VLMockLocationSource : NSObject <VLLocationSourceProtocol>
@property (nonatomic, assign) VLMockLocationSourceState state;
@end
