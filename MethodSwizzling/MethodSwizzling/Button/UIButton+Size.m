//
//  UIButton+Size.m
//  MethodSwizzling
//
//  Created by mediaios on 2019/4/19.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "UIButton+Size.h"
#import <objc/runtime.h>

@implementation UIButton (Size)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 增大所有按钮大小
        Method origin_method = class_getInstanceMethod([self class], @selector(setFrame:));
        Method replaced_method = class_getInstanceMethod([self class], @selector(miSetFrame:));
        method_exchangeImplementations(origin_method, replaced_method);
        
    });
   
}

- (void)miSetFrame:(CGRect)frame
{
    frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width+20, frame.size.height+20);
    NSLog(@"设置按钮大小生效");
    [self miSetFrame:frame];
}

@end
