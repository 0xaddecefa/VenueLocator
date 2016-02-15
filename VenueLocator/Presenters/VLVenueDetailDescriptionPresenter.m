//
//  VLVenueDetailDescriptionPresenter.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 15/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLVenueDetailDescriptionPresenter.h"
#import "VLCompleteVenue.h"

@interface VLVenueDetailDescriptionPresenter()
@property (nonatomic, readwrite) UITextView *textView;

@property (nonatomic, strong) VLCompleteVenue *venue;
@end

@implementation VLVenueDetailDescriptionPresenter


- (void)setModel:(VLBaseModel *)model {
    self.venue = DYNAMIC_CAST(model, VLCompleteVenue);

    self.textView.text = self.venue.venueDescription;
}

- (VLBaseModel *)getModel {
    return self.venue;
}

@end
