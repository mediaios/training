//
//  Person.h
//  MethodSwizzling
//
//  Created by mediaios on 2019/4/17.
//  Copyright © 2019 mediaios. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
- (void)speak:(NSString *)language;

+ (void)sleep:(NSUInteger)hour;

@end

NS_ASSUME_NONNULL_END
