//
//  VLVenueDetailInfoTableViewCell.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 15/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLVenueDetailInfoPresenter.h"

@interface VLVenueDetailInfoTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet VLVenueDetailInfoPresenter *presenter;
@end
