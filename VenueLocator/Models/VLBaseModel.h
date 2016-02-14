//
//  VLBaseModel.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 13/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VLBaseModel : NSObject

//subclass should implement this
- (instancetype)initWithDictionary: (NSDictionary *)dictionary;

@end
