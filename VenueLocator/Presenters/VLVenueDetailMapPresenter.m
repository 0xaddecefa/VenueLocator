//
//  VLVenueDetailMapPresenter.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 15/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLVenueDetailMapPresenter.h"
#import "VLVenue.h"
#import "VLDistanceAnnotation.h"
#import "VLTaggedPointAnnotation.h"


static NSString *kPointResueIdentifier = @"VenueMapViewAnnotation";
static NSString *kDistanceResueIdentifier = @"MapViewDistanceAnnotation";

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

- (void)showRoute {
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    MKMapItem *sourceItem = [MKMapItem mapItemForCurrentLocation];
    
    MKPointAnnotation *destinationAnnotation = DYNAMIC_CAST(self.mapView.annotations.firstObject, MKPointAnnotation);
    MKPlacemark *destinationPlaceMark = [[MKPlacemark alloc] initWithCoordinate: destinationAnnotation.coordinate
                                                              addressDictionary: nil];
    MKMapItem *destinationItem = [[MKMapItem alloc] initWithPlacemark:destinationPlaceMark];
    
    [request setSource:sourceItem];
    [request setDestination:destinationItem];
    [request setTransportType:MKDirectionsTransportTypeAutomobile];
    [request setRequestsAlternateRoutes:NO];
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    __weak VLVenueDetailMapPresenter *blockSelf = self;

    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (!error) {
            
            MKMapRect  area = MKMapRectNull;
            for (MKRoute *route in [response routes]) {
                MKPolyline *routeOverlay = [route polyline];
                
                [blockSelf.mapView addOverlay: routeOverlay
                                   level: MKOverlayLevelAboveRoads];
                
                MKMapPoint middlePoint = routeOverlay.points[routeOverlay.pointCount/2];
                
                CLLocationCoordinate2D coord = MKCoordinateForMapPoint(middlePoint);
                VLDistanceAnnotation *annotation = [VLDistanceAnnotation new];
                [annotation setCoordinate:coord];
                annotation.distance = route.distance;
                annotation.expectedTravelTime = route.expectedTravelTime;
                
                [blockSelf.mapView addAnnotation:annotation];
                
                area = MKMapRectUnion(area, routeOverlay.boundingMapRect);
            }

            [blockSelf.mapView setVisibleMapRect:area edgePadding:UIEdgeInsetsMake(20, 20, 20, 20) animated:YES];
        }
    }];
    
}


- (void)decorateMapView {
    
    VLTaggedPointAnnotation *annotation = [[VLTaggedPointAnnotation alloc] init];
    [annotation setCoordinate:self.venue.location.coordinate];
    annotation.tag = 1;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
    MKCoordinateRegion region = {self.venue.location.coordinate, span};
    
    [self.mapView setRegion:region];
    [self.mapView addAnnotation:annotation];
    
    [self showRoute];

}
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    VLDistanceAnnotation *distanceAnnotation = DYNAMIC_CAST(annotation, VLDistanceAnnotation);
    if (distanceAnnotation) {
        MKAnnotationView *pinView = DYNAMIC_CAST([mapView dequeueReusableAnnotationViewWithIdentifier:kDistanceResueIdentifier], MKAnnotationView);
        if ( pinView == nil ) {
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kDistanceResueIdentifier];
        }
        pinView.canShowCallout = YES;
        return pinView;
    } else {
        VLTaggedPointAnnotation *endPointAnnotation = DYNAMIC_CAST(annotation, VLTaggedPointAnnotation);
        MKAnnotationView *pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:kPointResueIdentifier];
        if ( pinView == nil ) {
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kPointResueIdentifier];
        }
        pinView.canShowCallout = NO;
        pinView.image = endPointAnnotation.tag == 1 ? [UIImage imageNamed:@"annotation_venue"] : [UIImage imageNamed:@"annotation_home"] ;
        
        return pinView;
    }
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views {
    
    [views enumerateObjectsUsingBlock:^(MKAnnotationView * _Nonnull annotationView, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([annotationView.reuseIdentifier isEqualToString:kDistanceResueIdentifier]) {
            [self.mapView selectAnnotation:annotationView.annotation animated:NO];
        }
    }];
    
}
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        [renderer setStrokeColor:[UIColor blueColor]];
        [renderer setLineWidth:5.0];
        return renderer;
    }
    return nil;
}


@end
