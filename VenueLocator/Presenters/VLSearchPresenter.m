//
//  VLSearchPresenter.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 14/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLSearchPresenter.h"
#import "VLVenueList.h"
#import "VLLocationManager.h"

@interface VLSearchPresenter()

@property (nonatomic, readwrite) SearchPresenterState state;
@property (nonatomic, strong) VLVenueList *venueList;
@end

@implementation VLSearchPresenter


- (instancetype) init {
    self = [super init];
    
    if (self) {
        [[VLLocationManager sharedInstance] startUpdating];
    }
    
    return self;
}

- (void)search:(NSString *)query {
    self.state = SearchPresenterStateLoading;

    CLLocationCoordinate2D userLocation = [VLLocationManager sharedInstance].latestUserLocation.coordinate;
    
    __block VLSearchPresenter * blockSelf = self;
    [self.source searchForQuery: query
                                        latitude: userLocation.latitude
                                       longitude: userLocation.longitude
                                          radius: 30000
                                 successCallback: ^(VLVenueList * _Nullable venueList) {
                                     blockSelf.model = venueList;
                                 } errorCallback: ^(NSError * _Nullable error) {
                                 }];
}

- (void)setModel:(VLBaseModel *)model {
    self.venueList = DYNAMIC_CAST(model, VLVenueList);
    self.state = self.venueList.items.count > 0 ? SearchPresenterStateHasContent : SearchPresenterStateEmpty;
}

- (VLBaseModel *)getModel {
    return self.venueList;
}

- (void)setState:(SearchPresenterState)state {
    if (state != self.state) {
        _state = state;
        
        
        switch (_state) {
            case SearchPresenterStateEmpty:
                [self.delegate presentStateViewForState:_state];
                //NOTE: continue without break to reload the empty collection
            case SearchPresenterStateHasContent:
                [self.delegate refresh];
                break;
                
            case SearchPresenterStateError:
                [self.delegate presentStateViewForState:_state];
                break;
            default:
                break;
        }
    }
}

- (NSUInteger)numberOfVenues {
    return self.venueList.items.count;
}

- (VLVenue *)venueAtIndex:(NSUInteger)index {
    if (index < self.venueList.items.count) {
        return self.venueList.items[index];
    }
    
    return nil;
}

#pragma mark - Navigation

- (void)prepareSegueToDetailViewController: (UIViewController *)destinationViewController
                             fromVenueCell: (VLVenueCardCell *)venueCell {
    VLVenueDetailViewController *detailViewController = DYNAMIC_CAST(destinationViewController, VLVenueDetailViewController);
    [detailViewController.presenter setModel: DYNAMIC_CAST([venueCell.presenter getModel], VLVenue)];
}

@end
