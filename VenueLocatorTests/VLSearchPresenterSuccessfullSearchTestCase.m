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


@interface VLSearchPresenterSuccessfullSearchTestCase : XCTestCase <VLPresenterDelegate>
@property (nonatomic, strong) VLSearchPresenter *presenter;

@property (nonatomic, strong) NSDate *timeoutDate;
@property (nonatomic, assign) BOOL didComplete;

@end

@implementation VLSearchPresenterSuccessfullSearchTestCase

- (void)setUp {
    [super setUp];
    self.timeoutDate = [NSDate dateWithTimeIntervalSinceNow:1];
    self.presenter = [VLSearchPresenter new];
}

- (void)tearDown {
    [self waitForGroup];
    XCTAssertTrue(self.didComplete);
    [super tearDown];
}


- (void)testValidInputProcessed {
    self.presenter.source = [VLMockSearchSource new];
    self.presenter.delegate = self;
    
    [self.presenter search:@""];
}

#pragma mark - Delete callbacks
- (void)refresh {
    XCTAssertNotNil([self.presenter getModel]);
    self.didComplete = YES;
}


- (void)presentLoadingIndicator {
}
- (void)hideLoadingIndicator {
}
- (void)presentStateViewForState:(SearchPresenterState)state {
}


- (void)waitForGroup {
    while (! self.didComplete && [self.timeoutDate compare: [NSDate date]] == NSOrderedDescending) {
        NSTimeInterval const interval = 0.002;
        if (! [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:interval]]) {
            [NSThread sleepForTimeInterval:interval];
        }
    }
}

@end
