//
//  VLSearchPresenter.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 14/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VLPresenterProtocol.h"
#import "VLSearchSourceProtocol.h"
#import "VLLocationSourceProtocol.h"

#import "VLVenue.h"
#import "VLVenueCardCell.h"
#import "VLVenueDetailViewController.h"

@interface VLSearchPresenter : NSObject <VLPresenterProtocol>

@property (nonatomic, weak) id<VLPresenterDelegate> delegate;
@property (nonatomic, readonly) SearchPresenterState state;
@property (nonatomic, strong) id<VLSearchSourceProtocol> source;
@property (nonatomic, strong) id<VLLocationSourceProtocol> locationSource;

- (void)search:(NSString *)query;

- (NSUInteger)numberOfVenues;
- (VLVenue *)venueAtIndex:(NSUInteger)index;

- (void)prepareSegueToDetailViewController: (UIViewController *)destinationViewController
                             fromVenueCell: (VLVenueCardCell *)venueCell;
@end
