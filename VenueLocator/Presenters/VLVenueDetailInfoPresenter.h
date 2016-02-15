//
//  VLVenueDetailInfoPresenter.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 15/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLPresenterProtocol.h"

@interface VLVenueDetailInfoPresenter : UIView <VLPresenterProtocol>
@property (nonatomic, readonly) IBOutlet UIImageView *imageView;
@property (nonatomic, readonly) IBOutlet UILabel *nameLabel;
@property (nonatomic, readonly) IBOutlet UITextView *addressTextView;

@end
