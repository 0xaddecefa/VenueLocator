//
//  VLVenueDetailPresenter.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 15/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VLPresenterProtocol.h"
#import "VLVenueDetailSourceProtocol.h"

@interface VLVenueDetailPresenter : NSObject <VLPresenterProtocol>
@property (nonatomic, strong) id<VLVenueDetailSourceProtocol> source;
@property (nonatomic, weak) id<VLPresenterDelegate> delegate;

- (NSUInteger)numberOfRows;
- (NSString *)reuseIdentifierForIndexPath:(NSIndexPath *)indexPath;

- (void)decorateDetailPresenterWithPresenter:(id<VLPresenterProtocol>)presenter forIndexPath:(NSIndexPath *)indexPath;

@end
