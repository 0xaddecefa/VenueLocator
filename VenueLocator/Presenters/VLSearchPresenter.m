//
//  VLSearchPresenter.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 14/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLSearchPresenter.h"
#import "VLVenueList.h"

@interface VLSearchPresenter()

@property (nonatomic, readwrite) SearchPresenterState state;
@property (nonatomic, strong) VLVenueList *venueList;
@end

@implementation VLSearchPresenter


- (void)search:(NSString *)query {
    
}

- (NSUInteger)numberOfVenues {
    return 0;
}

- (VLVenue *)venueAtIndex:(NSUInteger)index {
    return nil;
}

- (void)setModel:(VLBaseModel *)model {
    VLVenueList *venueList = DYNAMIC_CAST(model, VLVenueList);
    
}

@end
