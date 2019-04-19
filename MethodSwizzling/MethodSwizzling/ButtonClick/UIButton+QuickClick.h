//
//  UIButton+QuickClick.h
//  MethodSwizzling
//
//  Created by mediaios on 2019/4/19.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (QuickClick)
@property (nonatomic,assign) NSTimeInterval delayTime;
@end

NS_ASSUME_NONNULL_END
