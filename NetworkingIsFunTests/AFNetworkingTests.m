//
//  AFNetworkingTests.m
//  NetworkingIsFunTests
//
//  Created by Steve Baker on 7/16/13.
//  Copyright (c) 2013 Beepscore LLC. All rights reserved.
//

#import "AFNetworking.h"
#import <SenTestingKit/SenTestingKit.h>
#import "OCMock.h"

@interface AFNetworkingTests : SenTestCase
@end

@implementation AFNetworkingTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testAFHTTPClientGetPath
{
    // References
    // https://matthiaswessendorf.wordpress.com/2012/11/21/ocmock-and-afnetworking/
    // http://alexvollmer.com/posts/2010/06/28/making-fun-of-things-with-ocmock/
    
    id mockClient = [OCMockObject mockForClass:[AFHTTPClient class]];
    
    NSString *expectedValue = @"Good morning";
    
    //  Expect that the "getPath" is invoked, once!
    //  use andDo argument to invoke the success block with our mocked JSON
    [[[mockClient expect] andDo:^(NSInvocation *invocation) {
        
        // declare successBlock , initialize as nil
        void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) = nil;
        
        // When the test runs, it will pass in an NSInvocation
        // invocation argument indices 0 and 1 indicate the hidden arguments self and _cmd
        // invocation arguments for the actual method start with 2
        // invocation argument 4 references the actual successBlock
        [invocation getArgument:&successBlock atIndex:4];
        NSLog(@"successBlock %@", successBlock);
        
        // call the successBlock with operation nil and responseObject a dictionary
        successBlock(nil, @{@"greetings": expectedValue});
        
    }] // end of andDo
     
     getPath:[OCMArg any]
     parameters:nil
     success:[OCMArg any]
     failure:[OCMArg any]
     ]; // end of expect
    
    // run the test
    [mockClient getPath:@"a_path"
             parameters:nil
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSString *actualValue = [responseObject objectForKey:@"greetings"];
                    STAssertEqualObjects(expectedValue,
                                         actualValue,
                                         @"Expected %@ but got %@", expectedValue, actualValue);
                    NSLog(@"testAFHTTPClient PASS");
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"testAFHTTPClient FAIL");
                }
     ];
}

@end
