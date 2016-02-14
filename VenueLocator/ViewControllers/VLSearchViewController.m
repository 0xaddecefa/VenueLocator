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

@interface VLSearchViewController ()
@property (nonatomic, strong) VLSearchPresenter *presenter;
@end

@implementation VLSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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


@end
