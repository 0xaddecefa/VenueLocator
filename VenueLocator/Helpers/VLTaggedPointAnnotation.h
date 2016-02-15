//
//  MKTaggedPointAnnotation.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 15/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface VLTaggedPointAnnotation : MKPointAnnotation
@property (nonatomic, assign) NSUInteger tag;
@end
