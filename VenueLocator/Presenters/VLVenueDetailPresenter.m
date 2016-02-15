//
//  VLVenueDetailPresenter.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 15/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLVenueDetailPresenter.h"
#import "VLVenue.h"

@interface VLVenueDetailPresenter()
@property (nonatomic, strong) VLVenue *venue;
@end

@implementation VLVenueDetailPresenter

- (void)setModel:(VLBaseModel *)model {
    self.venue = DYNAMIC_CAST(model, VLVenue);
}

- (VLBaseModel *)getModel {
    return self.venue;
}

@end
