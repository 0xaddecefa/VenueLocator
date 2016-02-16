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


- (instancetype) init {
    self = [super init];
    
    if (self) {
    }
    
    return self;
}

- (void)search:(NSString *)query {
    if ([self.locationSource getLatestUserLocation]) {
        
        self.state = SearchPresenterStateLoading;
        
        CLLocationCoordinate2D userLocation = [self.locationSource getLatestUserLocation].coordinate;
        
        __block VLSearchPresenter * blockSelf = self;
        [self.delegate presentLoadingIndicator];
        [self.source searchForQuery: query
                           latitude: userLocation.latitude
                          longitude: userLocation.longitude
                             radius: 30000
                    successCallback: ^(VLVenueList * _Nullable venueList) {
                        [blockSelf.delegate hideLoadingIndicator];
                        blockSelf.model = venueList;
                    } errorCallback: ^(NSError * _Nullable error) {
                        [blockSelf setModel:nil];
                        [blockSelf.delegate hideLoadingIndicator];
                    }];
    } else {
        self.state = SearchPresenterStateError;
        [self.delegate refresh];
    }
}

- (void)setModel:(VLBaseModel *)model {
    self.venueList = DYNAMIC_CAST(model, VLVenueList);
    self.state = self.venueList ? (self.venueList.items.count > 0 ? SearchPresenterStateHasContent : SearchPresenterStateEmpty) : SearchPresenterStateError;
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
