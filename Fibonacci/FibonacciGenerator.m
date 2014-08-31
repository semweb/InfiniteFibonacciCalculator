//
//  FibonacciGenerator.m
//  Fibonacci
//
//  Created by MIYAMOTO Shohei on 8/30/14.
//  Copyright (c) 2014 Miyamoto Shohei. All rights reserved.
//

#import "FibonacciGenerator.h"

#import "NSString+FibonacciAdditions.h"

@interface FibonacciGenerator ()
@property (nonatomic, strong) NSMutableArray *results;
@end

@implementation FibonacciGenerator

- (instancetype)init
{
    self = [super init];
    if (self) {
        _results = [@[@"0", @"1"] mutableCopy];
    }
    return self;
}

- (NSUInteger)count
{
    return self.results.count;
}

- (NSString *)fibonacciDescriptionAt:(NSUInteger)n
{
    if (self.results.count <= n) {
        [self generateTo:n];
    }
    return self.results[n];
}

- (void)generateTo:(NSUInteger)to
{
    NSUInteger from = self.results.count;
    for (NSUInteger i = from; i <= to; i++) {
        NSString *pre = [self fibonacciDescriptionAt:i - 1];
        NSString *ppre = [self fibonacciDescriptionAt:i - 2];
        NSString *result = [pre fib_stringByAddingStringAsNumber:ppre];
        [self.results addObject:result];
    }
}

@end
