//
//  FibonacciGeneratorTests.m
//  Fibonacci
//
//  Created by MIYAMOTO Shohei on 8/31/14.
//  Copyright (c) 2014 Miyamoto Shohei. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "FibonacciGenerator.h"

NSUInteger Fibonacci(NSUInteger n)
{
    if (n <= 1) return n;

    NSUInteger a = Fibonacci(0);
    NSUInteger b = Fibonacci(1);
    for (NSUInteger i = 2; i <= n; i++) {
        NSUInteger tmp = b;
        b = a + b;
        a = tmp;
    }
    return b;
}


@interface FibonacciGeneratorTests : XCTestCase

@end

@implementation FibonacciGeneratorTests

- (void)testGenerate
{
    FibonacciGenerator *generator = [FibonacciGenerator new];
    XCTAssertEqual(generator.count, 2);

    [generator generateTo:100];
    XCTAssertEqual(generator.count, 101);

    for (int i = 0; i < 20; i++) {
        NSString *result = [generator fibonacciDescriptionAt:i];
        NSString *expectation = [NSString stringWithFormat:@"%@", @(Fibonacci(i))];
        XCTAssertEqualObjects(result, expectation);
    }
}

@end
