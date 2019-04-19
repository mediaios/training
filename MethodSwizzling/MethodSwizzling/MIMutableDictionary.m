//
//  MIMutableDictionary.m
//  MethodSwizzling
//
//  Created by mediaios on 2019/4/17.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "MIMutableDictionary.h"
#import <objc/runtime.h>

@implementation MIMutableDictionary

+ (void)load
{
    Class origin_class = NSClassFromString(@"__NSDictionaryM");
    Class swizzed_class = [self class];
    SEL origin_selector = @selector(setObject:forKey:);
    SEL swizzed_selector = @selector(mi_setObject:forKey:);
    Method origin_method = class_getInstanceMethod(origin_class, origin_selector);
    Method swizzed_method = class_getInstanceMethod(swizzed_class, swizzed_selector);
    IMP origin_imp = method_getImplementation(origin_method);
    IMP swizzed_imp = method_getImplementation(swizzed_method);
    const char* origin_type = method_getTypeEncoding(origin_method);
    const char* swizzed_type = method_getTypeEncoding(swizzed_method);

    class_replaceMethod(origin_class, swizzed_selector, origin_imp, origin_type);
    class_replaceMethod(origin_class, origin_selector, swizzed_imp, swizzed_type);
}

- (void)mi_setObject:(id)objContent forKey:(id<NSCopying>)keyContent
{
    if (objContent && keyContent) {
//        NSLog(@"执行了进去");
        [self mi_setObject:objContent forKey:keyContent];
    }
}


@end
