//
//  VLVenuePresenter.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 13/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLVenueCardPresenter.h"
#import "VLVenue.h"

#import "Haneke.h"


@interface VLVenueCardPresenter()
@property (nonatomic, readwrite, strong) UILabel *nameLabel;
@property (nonatomic, readwrite, strong) UITextView *addressTextView;
@property (nonatomic, readwrite, strong) UILabel *distanceLabel;
@property (nonatomic, readwrite, strong) UIImageView *imageView;
@end

@implementation VLVenueCardPresenter

- (void)setModel:(VLBaseModel *)model {
    VLVenue *venue = DYNAMIC_CAST(model, VLVenue);
    
    self.nameLabel.text = venue.name;
    self.addressTextView.text = [venue.location.formattedAddress componentsJoinedByString:@"\n"] ;
    self.distanceLabel.text = [NSString stringWithFormat:@"%@ m", @(venue.location.distance)];
    
    NSURL *iconURL = [venue.icon urlForSize:VLIconSizeBig andWithBackground:YES];
    if (iconURL) {
        [self.imageView hnk_setImageFromURL: iconURL];
    }
}

@end
