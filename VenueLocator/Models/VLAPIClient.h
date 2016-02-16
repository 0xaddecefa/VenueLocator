//
//  VLAPIClient.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 14/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VLSearchSourceProtocol.h"
#import "VLVenueDetailSourceProtocol.h"

@interface VLAPIClient : NSObject <VLSearchSourceProtocol, VLVenueDetailSourceProtocol>

+ (instancetype _Nullable)sharedInstance;

@end
