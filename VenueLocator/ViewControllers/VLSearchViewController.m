//
//  ViewController.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 13/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLSearchViewController.h"
#import "VLSearchPresenter.h"

#import "VLVenueCardCell.h"

static NSString *kCellReuseIdentifier = @"VenueCardCell";

@interface VLSearchViewController () <VLSearchPresenterDelegate>
@property (nonatomic, strong) VLSearchPresenter *presenter;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@end

@implementation VLSearchViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.presenter search:@"pizza"];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView: (UICollectionView *)collectionView
     numberOfItemsInSection: (NSInteger)section {
    if (self.presenter.state == SearchPresenterStateHasContent) {
        return [self.presenter numberOfVenues];
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: kCellReuseIdentifier
                                                                           forIndexPath: indexPath];
    
    VLVenueCardCell *venueCardCell = DYNAMIC_CAST(cell, VLVenueCardCell);
    [self configureCell:venueCardCell forRowAtIndexPath:indexPath];

    return cell;
}

- (void)configureCell: (VLVenueCardCell *)cell
    forRowAtIndexPath: (NSIndexPath *)indexPath {
    [cell.presenter setModel: [self.presenter venueAtIndex:indexPath.row]];
}

#pragma mark - lazy getters


- (VLSearchPresenter *)presenter {
    if (!_presenter) {
        _presenter = [VLSearchPresenter new];
        _presenter.delegate = self;
    }
    
    return _presenter;
}

#pragma mark - VLSearchPresenterDelegate

- (void)reloadList {
    [self.collectionView reloadData];
}

- (void)presentLoadingIndicator {

}

- (void)hideLoadingIndicator {
    
}

- (void)presentStateViewForState:(SearchPresenterState)state {
    
}

@end
