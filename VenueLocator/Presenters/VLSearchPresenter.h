//
//  VLSearchPresenter.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 14/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VLPresenterProtocol.h"
#import "VLVenue.h"

typedef NS_ENUM(NSUInteger, SearchPresenterState) {
    SearchPresenterStateInitial,
    SearchPresenterStateLoading,
    SearchPresenterStateHasContent,
    SearchPresenterStateEmpty,
    SearchPresenterStateError,
};

@class VLSearchPresenter;

@protocol VLSearchPresenterDelegate <NSObject>
@required
- (void)reloadList;
- (void)presentLoadingIndicator;
- (void)hideLoadingIndicator;
- (void)presentStateViewForState:(SearchPresenterState)state;
@end

@interface VLSearchPresenter : NSObject <VLPresenterProtocol>

@property (nonatomic, weak) id<VLSearchPresenterDelegate> delegate;
@property (nonatomic, readonly) SearchPresenterState state;

- (void)search:(NSString *)query;

- (NSUInteger)numberOfVenues;
- (VLVenue *)venueAtIndex:(NSUInteger)index;


@end
