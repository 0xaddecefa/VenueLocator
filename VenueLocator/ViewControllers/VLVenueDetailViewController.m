//
//  VLVenueDetailViewController.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 15/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLVenueDetailViewController.h"
#import "VLVenueDetailInfoTableViewCell.h"
#import "VLVenueDetailDescriptionTableViewCell.h"
#import "VLVenueDetailMapTableViewCell.h"

@interface VLVenueDetailViewController () <VLPresenterDelegate>
@property (nonatomic, strong) VLVenueDetailPresenter *presenter;
@end

@implementation VLVenueDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0f;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}



#pragma mark - lazy getter

- (VLVenueDetailPresenter *)presenter {
    if (!_presenter) {
        _presenter = [VLVenueDetailPresenter new];
        _presenter.delegate = self;
    }
    
    return _presenter;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.presenter numberOfRows];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = [self.presenter reuseIdentifierForIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
}

- (void)configureCell: (UITableViewCell *)cell
    forRowAtIndexPath: (NSIndexPath *)indexPath {
    VLVenueDetailInfoTableViewCell *infoCell = DYNAMIC_CAST(cell, VLVenueDetailInfoTableViewCell);
    VLVenueDetailDescriptionTableViewCell *descriptionCell = DYNAMIC_CAST(cell, VLVenueDetailDescriptionTableViewCell);
    VLVenueDetailMapTableViewCell *mapCell = DYNAMIC_CAST(cell, VLVenueDetailMapTableViewCell);
    [self.presenter decorateDetailPresenterWithPresenter:infoCell.presenter forIndexPath:indexPath];
    [self.presenter decorateDetailPresenterWithPresenter:descriptionCell.presenter forIndexPath:indexPath];
    [self.presenter decorateDetailPresenterWithPresenter:mapCell.presenter forIndexPath:indexPath];
}


- (void)refresh {
    [self.tableView reloadData];
}

- (void)presentLoadingIndicator {
    
}
- (void)hideLoadingIndicator {
    
}
- (void)presentStateViewForState:(SearchPresenterState)state {
    
}


@end
