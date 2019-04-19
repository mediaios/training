//
//  Person.m
//  MethodSwizzling
//
//  Created by mediaios on 2019/4/17.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)speak:(NSString *)language
{
    NSLog(@"person speak language: %@",language);
}

+ (void)sleep:(NSUInteger)hour
{
    NSLog(@"person sleep: %lu",hour);
}
@end
