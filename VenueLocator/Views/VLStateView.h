//
//  VLStateView.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 16/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, VLStateViewState) {
    VLStateViewStateNone,
    VLStateViewStateLoading,
    VLStateViewStateEmpty,
    VLStateViewStateError,
};

@interface VLStateView : UIView
@property (nonatomic, assign) VLStateViewState state;
@end
