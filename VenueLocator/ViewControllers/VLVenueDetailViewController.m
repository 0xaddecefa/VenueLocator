//
//  VLVenueDetailViewController.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 15/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLVenueDetailViewController.h"

@interface VLVenueDetailViewController ()
@property (nonatomic, strong) VLVenueDetailPresenter *presenter;
@end

@implementation VLVenueDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



#pragma mark - lazy getter

- (VLVenueDetailPresenter *)presenter {
    if (!_presenter) {
        _presenter = [VLVenueDetailPresenter new];
    }
    
    return _presenter;
}

@end
