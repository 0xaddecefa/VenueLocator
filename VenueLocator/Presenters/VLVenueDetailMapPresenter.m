//
//  VLVenueDetailMapPresenter.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 15/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLVenueDetailMapPresenter.h"
#import "VLVenue.h"
#import "VLLocationManager.h"

@interface VLVenueDetailMapPresenter() <MKMapViewDelegate>
@property (nonatomic, readwrite) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) VLVenue *venue;

@end

@implementation VLVenueDetailMapPresenter

- (void)setModel:(VLBaseModel *)model {
    self.venue = DYNAMIC_CAST(model, VLVenue);
}

- (VLBaseModel *)getModel {
    return self.venue;
}

- (void)setVenue:(VLVenue *)venue {
    _venue = venue;
    
    [self decorateMapView];
}

- (void)decorateMapView {
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:self.venue.location.coordinate];
    MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
    MKCoordinateRegion region = {self.venue.location.coordinate, span};
    
    [self.mapView setRegion:region];
    [self.mapView addAnnotation:annotation];

}

@end
