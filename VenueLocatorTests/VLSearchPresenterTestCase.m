//
//  VLSearchProviderTestCase.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 16/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VLSearchPresenter.h"

#import "VLMockSearchSource.h"
#import "VLMockLocationSource.h"

@interface VLSearchPresenterTestCase : XCTestCase <VLPresenterDelegate>
@property (nonatomic, strong) VLSearchPresenter *presenter;

@property (nonatomic, strong) NSDate *timeoutDate;
@property (nonatomic, assign) BOOL didComplete;

@property (nonatomic, assign) VLMockSearchSourceState state;
@property (nonatomic, assign) VLMockLocationSourceState locationState;


@property (nonatomic, assign) BOOL presentStateCalled;
@property (nonatomic, assign) BOOL presentLoadingIndicatorCalled;
@property (nonatomic, assign) BOOL hideLoadingIndicatorCalled;

@end

@implementation VLSearchPresenterTestCase

- (void)setUp {
    [super setUp];
    self.timeoutDate = [NSDate dateWithTimeIntervalSinceNow:1];
}

- (void)tearDown {
    [self waitForGroup];
    XCTAssertTrue(self.didComplete);
    [super tearDown];
}

- (void)testValidInputProcessed {
    self.locationState = VLMockLocationSourceLocation;
    self.state = VLMockSearchSourceShouldReturnData;
    
    [self.presenter search:@""];
}

- (void)testEmptyInputProcessed {
    self.locationState = VLMockLocationSourceLocation;
    self.state = VLMockSearchSourceShouldReturnEmpty;
    
    [self.presenter search:@""];
}



#pragma mark - Delete callbacks
- (void)refresh {
    
    XCTAssertTrue(self.presentLoadingIndicatorCalled);
    XCTAssertTrue(self.hideLoadingIndicatorCalled);

    if (self.state == VLMockSearchSourceShouldReturnData &&
        self.locationState == VLMockLocationSourceLocation) {
        XCTAssertNotNil([self.presenter getModel]);
        XCTAssertTrue([[self.presenter getModel] isKindOfClass:[VLVenueList class]]);
        VLVenueList *venueList = (VLVenueList *)[self.presenter getModel];
        
        XCTAssertNotNil([venueList items]);
        XCTAssertTrue([self.presenter numberOfVenues] == 1);
    }

    if (self.state == VLMockSearchSourceShouldReturnEmpty &&
        self.locationState == VLMockLocationSourceLocation) {
        XCTAssertNotNil([self.presenter getModel]);
        XCTAssertTrue([[self.presenter getModel] isKindOfClass:[VLVenueList class]]);
        VLVenueList *venueList = (VLVenueList *)[self.presenter getModel];
        
        XCTAssertNotNil([venueList items]);
        XCTAssertTrue([self.presenter numberOfVenues] == 0);
        XCTAssertTrue(self.presentStateCalled);
    }
    self.didComplete = YES;

    
}


- (void)presentLoadingIndicator {
    self.presentLoadingIndicatorCalled = YES;
    
}
- (void)hideLoadingIndicator {
    self.hideLoadingIndicatorCalled = YES;
}
- (void)presentStateViewForState:(SearchPresenterState)state {
    self.presentStateCalled = YES;
}


- (void)waitForGroup {
    while (! self.didComplete && [self.timeoutDate compare: [NSDate date]] == NSOrderedDescending) {
        NSTimeInterval const interval = 0.002;
        if (! [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:interval]]) {
            [NSThread sleepForTimeInterval:interval];
        }
    }
}


- (VLSearchPresenter *)presenter {
    if (!_presenter) {
        _presenter = [VLSearchPresenter new];
        _presenter.delegate = self;

        VLMockSearchSource *source = [VLMockSearchSource new];
        source.state = self.state;
        _presenter.source = source;

        VLMockLocationSource *locationSource = [VLMockLocationSource new];
        locationSource.state = self.locationState;
        _presenter.locationSource = locationSource;
       
    }
    
    return _presenter;
}

@end
