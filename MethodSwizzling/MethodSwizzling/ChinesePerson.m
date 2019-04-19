//
//  ChinesePerson.m
//  MethodSwizzling
//
//  Created by mediaios on 2019/4/17.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "ChinesePerson.h"
#import <objc/runtime.h>

@implementation ChinesePerson

+ (void)load
{
    Class origin_class  = NSClassFromString(@"Person");
    Class swizzed_class = [self class];
    
    SEL origin_selector = NSSelectorFromString(@"speak:");
    SEL swizzed_selector = NSSelectorFromString(@"mi_speak:");
    
    Method origin_method = class_getInstanceMethod(origin_class, origin_selector);
    Method swizzed_method = class_getInstanceMethod(swizzed_class, swizzed_selector);
    
    BOOL add_method = class_addMethod(origin_class,
                                      swizzed_selector,
                                      method_getImplementation(swizzed_method),
                                      method_getTypeEncoding(swizzed_method));
    if (!add_method) {
        return;
    }
    
    swizzed_method = class_getInstanceMethod(origin_class, swizzed_selector);
    if (!swizzed_method) {
        return;
    }
    
    BOOL did_add_method = class_addMethod(origin_class,
                                          origin_selector,
                                          method_getImplementation(swizzed_method),
                                          method_getTypeEncoding(swizzed_method));
    if (did_add_method) {
        class_replaceMethod(origin_class,
                            swizzed_selector,
                            method_getImplementation(origin_method),
                            method_getTypeEncoding(origin_method));
    }else{
        method_exchangeImplementations(origin_method, swizzed_method);
    }
    
}

- (void)mi_speak:(NSString *)language
{
    if ([language isEqualToString:@"Chinese"]) {
        [self mi_speak:language];
    }
}

@end
