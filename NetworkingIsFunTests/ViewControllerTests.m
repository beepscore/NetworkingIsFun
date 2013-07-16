//
//  ViewControllerTests.m
//  NetworkingIsFunTests
//
//  Created by Steve Baker on 7/16/13.
//  Copyright (c) 2013 Beepscore LLC. All rights reserved.
//

#import "ViewController.h"
#import <SenTestingKit/SenTestingKit.h>

@interface ViewControllerTests : SenTestCase
@property (strong, nonatomic) ViewController *viewController;
@end

@implementation ViewControllerTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    self.viewController = [[ViewController alloc] init];
}

- (void)tearDown
{
    // Tear-down code here.
    self.viewController = nil;
    
    [super tearDown];
}

# pragma mark - test viewDidLoad
- (void)testViewDidLoadSetsTableViewDataSource
{
    [self.viewController viewDidLoad];
    
    STAssertEquals(self.viewController,
                   self.viewController.tableView.delegate,
                   @"expected viewDidLoad sets tableView delegate to self");
}

@end
