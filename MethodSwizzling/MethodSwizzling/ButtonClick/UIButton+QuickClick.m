//
//  UIButton+QuickClick.m
//  MethodSwizzling
//
//  Created by mediaios on 2019/4/19.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import "UIButton+QuickClick.h"
#import <objc/runtime.h>

@implementation UIButton (QuickClick)
static const char* delayTime_str = "delayTime_str";


+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originMethod =   class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
        Method replacedMethod = class_getInstanceMethod(self, @selector(miSendAction:to:forEvent:));
        method_exchangeImplementations(originMethod, replacedMethod);
    });
}


- (void)miSendAction:(nonnull SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (self.delayTime > 0) {
        if (self.userInteractionEnabled) {
            [self miSendAction:action to:target forEvent:event];
        }
        self.userInteractionEnabled = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                     (int64_t)(self.delayTime * NSEC_PER_SEC)),
                                     dispatch_get_main_queue(), ^{
                                         self.userInteractionEnabled = YES;
                                     });
    }else{
        [self miSendAction:action to:target forEvent:event];
    }
}


- (NSTimeInterval)delayTime
{
    return [objc_getAssociatedObject(self, delayTime_str) doubleValue];
}

- (void)setDelayTime:(NSTimeInterval)delayTime
{
    objc_setAssociatedObject(self, delayTime_str, @(delayTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
