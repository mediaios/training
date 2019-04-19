//
//  UIViewController+MI.m
//  MethodSwizzling
//
//  Created by mediaios on 2019/4/17.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "UIViewController+MI.h"
#import <objc/runtime.h>

@implementation UIViewController (MI)

+ (void)load{
    
    // 替换ViewController中的viewDidLoad方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL origin_selector  = @selector(viewDidLoad);
        SEL swizzed_selector = @selector(mi_viewDidLoad);
        
        Method origin_method = class_getInstanceMethod([self class], origin_selector);
        Method swizzed_method = class_getInstanceMethod([self class], swizzed_selector);
        
        BOOL did_add_method = class_addMethod([self class],
                                              origin_selector,
                                              method_getImplementation(swizzed_method),
                                              method_getTypeEncoding(swizzed_method));
        if (did_add_method) {
            NSLog(@"debugMsg: ViewController类中没有viewDidLoad方法(可能在其父类h中)，所以先添加后替换");
            class_replaceMethod([self class],
                                swizzed_selector,
                                method_getImplementation(origin_method),
                                method_getTypeEncoding(origin_method));
        }else{
            NSLog(@"debugMsg: 直接交换方法");
            method_exchangeImplementations(origin_method, swizzed_method);
        }
//
//
//
//        IMP origin_imp = method_getImplementation(origin_method);
//        IMP swizzed_imp = method_getImplementation(swizzed_method);
//        const char* origin_type = method_getTypeEncoding(origin_method);
//        const char* swizzed_type = method_getTypeEncoding(swizzed_method);
//
//        class_replaceMethod([self class], swizzed_selector, origin_imp, origin_type);
//        class_replaceMethod([self class], origin_selector, swizzed_imp, swizzed_type);
        
    });
}

- (void)mi_viewDidLoad
{
    [self mi_viewDidLoad];
    NSLog(@"debugMsg: 替换成功");
}

@end
