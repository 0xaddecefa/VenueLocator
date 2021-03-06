//
//  ViewController.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 13/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import "VLSearchViewController.h"
#import "VLSearchPresenter.h"
#import "VLAPIClient.h"
#import "VLLocationManager.h"

#import "VLVenueCardCell.h"
#import "VLStateView.h"

static NSString *kCellReuseIdentifier = @"VenueCardCell";

@interface VLSearchViewController () <VLPresenterDelegate, UISearchBarDelegate>
@property (nonatomic, strong) VLSearchPresenter *presenter;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *collectionViewBottomContraint;

@property (nonatomic, strong) IBOutlet VLStateView *stateView;

@end

@implementation VLSearchViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardFrameChanged:(NSNotification *) notification {
    NSDictionary *userinfo = notification.userInfo;
    CGRect endFrame;
    [[userinfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&endFrame];
    endFrame = [self.view convertRect:endFrame fromView:nil];
    NSNumber *durationValue = DYNAMIC_CAST(userinfo[UIKeyboardAnimationDurationUserInfoKey], NSNumber);
    CGFloat animationDuration = [durationValue floatValue];
    
    self.collectionViewBottomContraint.constant = 5 + (self.view.bounds.size.height - endFrame.origin.y);

    [UIView animateWithDuration: animationDuration
                          delay: 0.0f
                        options: UIViewAnimationOptionBeginFromCurrentState
                     animations: ^{
                         [self.collectionView.collectionViewLayout invalidateLayout];
                     }
                     completion:^(BOOL finished) {
                     }];
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [self.collectionView.collectionViewLayout invalidateLayout];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    VLVenueCardCell *senderCell = DYNAMIC_CAST(sender, VLVenueCardCell);
    
    [self.presenter prepareSegueToDetailViewController:segue.destinationViewController fromVenueCell:senderCell];
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
            columns = 3;
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

#pragma mark - lazy getters


- (VLSearchPresenter *)presenter {
    if (!_presenter) {
        _presenter = [VLSearchPresenter new];
        _presenter.source = [VLAPIClient sharedInstance];
        _presenter.locationSource = [VLLocationManager sharedInstance];
        _presenter.delegate = self;
    }
    
    return _presenter;
}

#pragma mark - VLPresenterDelegate

- (void)refresh {
    [self.collectionView reloadData];
}

- (void)presentLoadingIndicator {
    self.stateView.state = VLStateViewStateLoading;
}

- (void)hideLoadingIndicator {
    self.stateView.state = VLStateViewStateNone;
}

- (void)presentStateViewForState:(SearchPresenterState)state {
    VLStateViewState stateViewState = VLStateViewStateNone;
    
    switch (state) {
        case SearchPresenterStateEmpty:
            stateViewState = VLStateViewStateEmpty;
            break;
        case SearchPresenterStateLocationNotDetermined:
        case SearchPresenterStateError:
            stateViewState = VLStateViewStateError;
            break;
        default:
            break;
            
    }

    self.stateView.state = stateViewState;

}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.presenter search:searchText];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.presenter search:searchBar.text];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}


@end
