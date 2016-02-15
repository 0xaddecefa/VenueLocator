//
//  VLVenueDetailPresenter.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 15/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLVenueDetailPresenter.h"
#import "VLVenue.h"

#import "VLAPIClient.h"


static NSString *kInfoCellReuseIdentifier = @"VenueDetailInfo";
static NSString *kDescriptionCellReuseIdentifier = @"VenueDetailDescription";
static NSString *kMapCellReuseIdentifier = @"VenueDetailMap";


@interface VLVenueDetailPresenter() 
@property (nonatomic, strong) VLVenue *venue;
@end

@implementation VLVenueDetailPresenter

- (void)setModel:(VLBaseModel *)model {
    self.venue = DYNAMIC_CAST(model, VLVenue);
    __block VLVenueDetailPresenter *blockSelf = self;
    [[VLAPIClient sharedInstance] loadVenueWithID:self.venue.identifier
                                  successCallback:^(VLCompleteVenue * _Nullable completeVenue) {
                                      blockSelf.venue = completeVenue;
                                      [blockSelf.delegate refresh];
                                  } errorCallback:^(NSError * _Nullable error) {
                                  }];
}

- (VLBaseModel *)getModel {
    return self.venue;
}

- (NSUInteger)numberOfRows {
    return [self.venue isKindOfClass:[VLCompleteVenue class]] ? 3 : 1;
}
- (NSString *)reuseIdentifierForIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return kInfoCellReuseIdentifier;
        case 1:
            return kDescriptionCellReuseIdentifier;
        case 2:
            return kMapCellReuseIdentifier;
    }
    
    assert(0);
    return nil;
}

- (void)decorateDetailPresenterWithPresenter:(id<VLPresenterProtocol>)presenter forIndexPath:(NSIndexPath *)indexPath {
    [presenter setModel:[self getModel]];
}

@end
