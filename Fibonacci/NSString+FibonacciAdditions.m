//
//  NSString+FibonacciAdditions.m
//  Fibonacci
//
//  Created by MIYAMOTO Shohei on 8/30/14.
//  Copyright (c) 2014 Miyamoto Shohei. All rights reserved.
//

#import "NSString+FibonacciAdditions.h"

@implementation NSString (FibonacciAdditions)

- (NSString *)fib_stringByAddingStringAsNumber:(NSString *)str
{
    int carry = 0;
    NSMutableArray *numbers = [NSMutableArray array];
    for (NSUInteger i = 0; i < MAX(str.length, self.length); i++) {
        unichar c1 = (self.length - i > 0) ? [self characterAtIndex:self.length - i - 1] : '0';
        unichar c2 = (str.length - i > 0) ? [str characterAtIndex:str.length - i - 1] : '0';
        if ('0' <= c1 && c1 <= '9' && '0' <= c2 && c2 <= '9') {
            int n = (c1 - '0') + (c2 - '0') + carry;
            carry = (n / 10);
            int quot = (int)(n % 10);
            char c[1];
            sprintf(c, "%d", quot);
            [numbers insertObject:[NSString stringWithCString:c encoding:NSASCIIStringEncoding]
                          atIndex:0];
        } else {
            return nil;
        }
    }
    if (carry > 0) {
        [numbers insertObject:[NSString stringWithFormat:@"%d", carry] atIndex:0];
    }
    return [numbers componentsJoinedByString:@""];
}

@end
