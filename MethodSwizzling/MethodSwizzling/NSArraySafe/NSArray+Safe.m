//
//  NSArray+Safe.m
//  MethodSwizzling
//
//  Created by mediaios on 2019/4/18.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "NSArray+Safe.h"
#import <objc/runtime.h>

@implementation NSArray (Safe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // objectAtIndex: 方式取元素
        Method origin_method = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
        Method replaced_method = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(safeObjectAtIndex:));
        method_exchangeImplementations(origin_method, replaced_method);
        
        Method origin_method_muta = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
        Method replaced_method_muta = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(safeMutableObjectAtIndex:));
        method_exchangeImplementations(origin_method_muta, replaced_method_muta);
        
        // 直接通过数组下标的方式取元素
        Method origin_method_sub = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndexedSubscript:));
        Method replaced_method_sub = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(safeObjectAtIndexedSubscript:));
        method_exchangeImplementations(origin_method_sub, replaced_method_sub);
        
        Method origin_method_muta_sub = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndexedSubscript:));
        Method replaced_method_muta_sub = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(safeMutableObjectAtIndexedSubscript:));
        method_exchangeImplementations(origin_method_muta_sub, replaced_method_muta_sub);
    });
   
}

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if (self.count > index && self.count) {
        return [self safeObjectAtIndex:index];
    }
    NSLog(@"errorMsg:数组[NSArray]越界...");
    return nil;
}

- (id)safeMutableObjectAtIndex:(NSUInteger)index
{
    if (self.count > index && self.count) {
        return [self safeMutableObjectAtIndex:index];
    }
    NSLog(@"errorMsg:数组[NSMutableArray]越界...");
    return nil;
}

-(id)safeObjectAtIndexedSubscript:(NSUInteger)index
{
    if (self.count > index && self.count) {
        return [self safeObjectAtIndexedSubscript:index];
    }
    NSLog(@"errorMsg:数组[NSArray]越界...");
    return nil;
}

- (id)safeMutableObjectAtIndexedSubscript:(NSUInteger)index
{
    if (self.count > index && self.count) {
        return [self safeMutableObjectAtIndexedSubscript:index];
    }
    NSLog(@"errorMsg:数组[NSMutableArray]越界...");
    return nil;
}



@end
