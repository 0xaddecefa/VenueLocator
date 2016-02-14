//
//  VLPresenterProtocol.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 13/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//


#import "VLBaseModel.h"

@protocol VLPresenterProtocol <NSObject>

@required
- (void)setModel:(VLBaseModel *)model;

@end
