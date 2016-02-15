//
//  VLVenueDetailDescriptionPresenter.h
//  VenueLocator
//
//  Created by Tamas Nemeth on 15/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLPresenterProtocol.h"

@interface VLVenueDetailDescriptionPresenter : UIView <VLPresenterProtocol>
@property (nonatomic, readonly) IBOutlet UITextView *textView;
@end
