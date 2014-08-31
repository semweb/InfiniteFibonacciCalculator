//
//  FibonacciGenerator.h
//  Fibonacci
//
//  Created by MIYAMOTO Shohei on 8/30/14.
//  Copyright (c) 2014 Miyamoto Shohei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FibonacciGenerator : NSObject
@property (nonatomic, readonly) NSUInteger count;
- (NSString *)fibonacciDescriptionAt:(NSUInteger)n;
- (void)generateTo:(NSUInteger)to;
@end
