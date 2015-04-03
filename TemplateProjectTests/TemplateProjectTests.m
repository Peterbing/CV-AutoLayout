//
//  TemplateProjectTests.m
//  TemplateProjectTests
//
//  Created by Peter on 1/9/15.
//  Copyright (c) 2015 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "UINavigationController+UpsideDown.h"

@interface TemplateProjectTests : XCTestCase

@property (nonatomic, strong) UINavigationController *navigationController;

@end

@implementation TemplateProjectTests

- (void)setUp {
	[super setUp];
	// Put setup code here. This method is called before the invocation of each test method in the class.
	self.navigationController = [UINavigationController new];
}

- (void)tearDown {
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	[super tearDown];
}

- (void)testExample {
	// This is an example of a functional test case.
	XCTAssert(YES, @"Pass");
}

- (void)testUpsideDown {
	XCTAssert(self.navigationController.shouldAutorotate);
	XCTAssert(self.navigationController.supportedInterfaceOrientations == UIInterfaceOrientationMaskAll);
}

- (void)testPerformanceExample {
	// This is an example of a performance test case.
	[self measureBlock:^{
		// Put the code you want to measure the time of here.
	}];
}

@end
