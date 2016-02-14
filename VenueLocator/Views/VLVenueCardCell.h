//
//  VLVenueCardCell.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 13/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLVenueCardPresenter.h"

@interface VLVenueCardCell : UICollectionViewCell
@property (nonatomic, strong) IBOutlet VLVenueCardPresenter *presenter;



@end
