//
//  NSObject+Category.m
//  RuntimePractice
//
//  Created by yurongde on 16/4/21.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "NSObject+Category.h"
#import <objc/runtime.h>
char carNamekey;

@implementation NSObject (Category)
- (void)setCarName:(NSString *)car {
    objc_setAssociatedObject(self, &carNamekey, car, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)carName {
    return objc_getAssociatedObject(self, &carNamekey);
}
@end
