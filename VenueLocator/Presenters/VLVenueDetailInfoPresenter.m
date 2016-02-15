//
//  VLVenueDetailInfoPresenter.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 15/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLVenueDetailInfoPresenter.h"
#import "VLVenue.h"
#import "Haneke.h"

@interface VLVenueDetailInfoPresenter()
@property (nonatomic, readwrite) UIImageView *imageView;
@property (nonatomic, readwrite) UILabel *nameLabel;
@property (nonatomic, readwrite) UITextView *addressTextView;

@property (nonatomic, strong) VLVenue *venue;
@end

@implementation VLVenueDetailInfoPresenter

- (void)setModel:(VLBaseModel *)model {
    self.venue = DYNAMIC_CAST(model, VLVenue);
    
    self.nameLabel.text = self.venue.name;
    self.addressTextView.text = [self.venue.location.formattedAddress componentsJoinedByString:@"\n"] ;
    
    NSURL *iconURL = [self.venue.icon urlForSize:VLIconSizeBig andWithBackground:YES];
    if (iconURL) {
        [self.imageView hnk_setImageFromURL: iconURL];
    }

}

- (VLBaseModel *)getModel {
    return self.venue;
}

@end
