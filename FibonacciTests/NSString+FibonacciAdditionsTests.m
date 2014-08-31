//
//  NSString+FibonacciAdditionsTests.m
//  Fibonacci
//
//  Created by MIYAMOTO Shohei on 8/30/14.
//  Copyright (c) 2014 Miyamoto Shohei. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSString+FibonacciAdditions.h"

@interface NSString_FibonacciAdditionsTests : XCTestCase
@end

@implementation NSString_FibonacciAdditionsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFib_stringByAddingStringAsNumber
{
    XCTAssertEqualObjects([@"0" fib_stringByAddingStringAsNumber:@"0"],
                          @"0");
    XCTAssertEqualObjects([@"4" fib_stringByAddingStringAsNumber:@"6"],
                          @"10");
    XCTAssertEqualObjects([@"9" fib_stringByAddingStringAsNumber:@"99"],
                          @"108");
}

@end
