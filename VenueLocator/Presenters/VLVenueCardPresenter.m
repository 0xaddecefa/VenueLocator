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

@property (nonatomic, strong) VLVenue *venue;
@end

@implementation VLVenueCardPresenter



- (void)setModel:(VLBaseModel *)model {
    self.venue = DYNAMIC_CAST(model, VLVenue);
    
    self.nameLabel.text = self.venue.name;
    self.addressTextView.text = [self.venue.location.formattedAddress componentsJoinedByString:@"\n"] ;
    self.distanceLabel.text = [NSString stringWithFormat:@"%@ m", @(self.venue.location.distance)];
    
    NSURL *iconURL = [self.venue.icon urlForSize:VLIconSizeBig andWithBackground:YES];
    if (iconURL) {
        [self.imageView hnk_setImageFromURL: iconURL];
    }
}

- (VLBaseModel *)getModel {
    return self.venue;
}


- (instancetype)initForTest {
    self = [self init];
    if (self) {
        self.nameLabel = [UILabel new];
        self.addressTextView = [UITextView new];
        self.distanceLabel = [UILabel new];
    }
    return self;
}

@end
