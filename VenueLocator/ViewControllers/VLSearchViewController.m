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

@interface VLSearchViewController () <VLSearchPresenterDelegate, UISearchBarDelegate>
@property (nonatomic, strong) VLSearchPresenter *presenter;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@end

@implementation VLSearchViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionViewFlowLayout *flowLayout = DYNAMIC_CAST(collectionViewLayout, UICollectionViewFlowLayout);
    
    CGFloat width = collectionView.bounds.size.width;
    width -= flowLayout.sectionInset.left + flowLayout.sectionInset.right;
    
    NSUInteger columns = 0;
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            columns = 4;
        } else {
            columns = 2;
        }
    } else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            columns = 2;
        } else {
            columns = 1;
        }
    }
    
    if (columns > 1) {
        width -= (columns - 1) * flowLayout.minimumInteritemSpacing;
    }
    
    width /= columns;
    
    return CGSizeMake(width, 160);
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(    NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.collectionView reloadData];
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

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.presenter search:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

@end
