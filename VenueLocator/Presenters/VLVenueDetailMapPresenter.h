//
//  VLVenueDetailMapPresenter.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 15/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLPresenterProtocol.h"

@import MapKit;

@interface VLVenueDetailMapPresenter : UIView <VLPresenterProtocol>
@property (nonatomic, readonly) IBOutlet MKMapView *mapView;

@end
