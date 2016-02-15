//
//  VLVenueCardPresenterTestCase.m
//  VenueLocator
//
//  Created by Tamas Nemeth on 15/02/16.
//  Copyright © 2016 Tamas Nemeth. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VLVenueCardPresenter.h"
#import "VLVenue.h"

@interface VLVenueCardPresenterTestCase : XCTestCase
@property (nonatomic, strong) VLVenueCardPresenter *presenter;
@property (nonatomic, strong) NSDictionary *validInput;
@end

@implementation VLVenueCardPresenterTestCase

- (void)setUp {
    [super setUp];

    self.presenter = [[VLVenueCardPresenter alloc] initForTest];


    self.validInput = @{
                        @"id" : @"1234",
                        @"name" : @"test",
                        @"location" : @{
                                    @"distance" : @(12),
                                    @"formattedAddress" : @[@"Address 1", @"Address 2"]
                                }
                        };
    

    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testValidInput {

    [self.presenter setModel:[[VLVenue alloc] initWithDictionary:self.validInput]];
    
    
    XCTAssertTrue([self.presenter.nameLabel.text isEqualToString:self.validInput[@"name"]]);
    
    XCTAssertTrue([self.presenter.distanceLabel.text integerValue] == [self.validInput[@"location"][@"distance"] integerValue]);
    
    
    NSArray *addressComponents = (NSArray *)self.validInput[@"location"][@"formattedAddress"];
    
    XCTAssertTrue([self.presenter.addressTextView.text isEqualToString: [addressComponents componentsJoinedByString:@"\n"]] );

    
}

@end
