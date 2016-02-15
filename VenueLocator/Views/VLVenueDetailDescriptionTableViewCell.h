//
//  VLVenueDetailDescriptionTableViewCell.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 15/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLVenueDetailDescriptionPresenter.h"

@interface VLVenueDetailDescriptionTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet VLVenueDetailDescriptionPresenter *presenter;
@end
