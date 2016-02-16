//
//  VLMockSearchSource.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 16/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VLSearchSourceProtocol.h"

typedef NS_ENUM(NSUInteger, VLMockSearchSourceState) {
    VLMockSearchSourceShouldReturnData,
    VLMockSearchSourceShouldReturnEmpty,
    VLMockSearchSourceShouldReturnError,
};

@interface VLMockSearchSource : NSObject <VLSearchSourceProtocol>
@property (nonatomic, assign) VLMockSearchSourceState state;
@end
