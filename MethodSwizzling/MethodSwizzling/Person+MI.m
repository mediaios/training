//
//  Person+MI.m
//  MethodSwizzling
//
//  Created by mediaios on 2019/4/17.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "Person+MI.h"
#import <objc/runtime.h>

@implementation Person (MI)
+ (void)load
{
    Class class = [self class];
    SEL origin_selector  = @selector(sleep:);
    SEL swizzed_selector = @selector(mi_sleep:);
    
    Method origin_method = class_getClassMethod(class, origin_selector);
    Method swizzed_method = class_getClassMethod(class,swizzed_selector);
    
    if (!origin_method || !swizzed_method) {
        return;
    }
    
    IMP origin_imp = method_getImplementation(origin_method);
    IMP swizzed_imp = method_getImplementation(swizzed_method);
    const char* origin_type = method_getTypeEncoding(origin_method);
    const char* swizzed_type = method_getTypeEncoding(swizzed_method);
    
    // 添加方法到MetaClass中
    Class meta_class = objc_getMetaClass(class_getName(class));
    class_replaceMethod(meta_class, swizzed_selector, origin_imp, origin_type);
    class_replaceMethod(meta_class, origin_selector, swizzed_imp, swizzed_type);
    
}

+ (void)mi_sleep:(NSUInteger)hour
{
    if (hour >= 7) {
        [self mi_sleep:hour];
    }
}
@end
