//
//  VLVenueDetailViewController.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 15/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VLVenueDetailPresenter.h"


@interface VLVenueDetailViewController : UIViewController
@property (nonatomic, readonly) VLVenueDetailPresenter *presenter;
@end
