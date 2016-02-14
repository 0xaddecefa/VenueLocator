//
//  VLSearchPresenter.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 14/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLSearchPresenter.h"
#import "VLVenueList.h"
#import "VLApiClient.h"

@interface VLSearchPresenter()

@property (nonatomic, readwrite) SearchPresenterState state;
@property (nonatomic, strong) VLVenueList *venueList;
@end

@implementation VLSearchPresenter


- (void)search:(NSString *)query {
    if (self.state == SearchPresenterStateLoading) {
    //cancel previous operation
    }
    // do the search
    self.state = SearchPresenterStateLoading;
    
    
    __block VLSearchPresenter * blockSelf = self;
    [[VLAPIClient sharedInstance] searchForQuery: query
                                       lattitude: 0
                                       longitude: 0
                                          radius: 0
                                 successCallback: ^(VLVenueList * _Nullable venueList) {
                                     blockSelf.model = venueList;
                                 } errorCallback: ^(NSError * _Nullable error) {
                                 }];
}

- (void)setModel:(VLBaseModel *)model {
    self.venueList = DYNAMIC_CAST(model, VLVenueList);
    self.state = self.venueList.items.count > 0 ? SearchPresenterStateHasContent : SearchPresenterStateEmpty;
}

- (void)setState:(SearchPresenterState)state {
    if (state != self.state) {
        _state = state;
        
        
        switch (_state) {
            case SearchPresenterStateEmpty:
                [self.delegate presentStateViewForState:_state];
                //NOTE: continue without break to reload the empty collection
            case SearchPresenterStateHasContent:
                [self.delegate reloadList];
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


@end
