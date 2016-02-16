//
//  VLPresenterProtocol.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 13/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//


#import "VLBaseModel.h"

@protocol VLPresenterProtocol <NSObject>
@required
- (void)setModel:(VLBaseModel *)model;
- (VLBaseModel *)getModel;
@end


typedef NS_ENUM(NSUInteger, SearchPresenterState) {
    SearchPresenterStateInitial,
    SearchPresenterStateLocationNotDetermined,
    SearchPresenterStateLoading,
    SearchPresenterStateHasContent,
    SearchPresenterStateEmpty,
    SearchPresenterStateError,
};

@protocol VLPresenterDelegate <NSObject>
@required
- (void)refresh;
- (void)presentLoadingIndicator;
- (void)hideLoadingIndicator;
- (void)presentStateViewForState:(SearchPresenterState)state;
@end

