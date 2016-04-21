//
//  UIImage+Category.m
//  RuntimePractice
//
//  Created by yurongde on 16/4/21.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "UIImage+Category.h"
#import <objc/runtime.h>
@implementation UIImage (Category)
+ (void)load {
    // 获取两个类的类方法
    Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
    Method m2 = class_getClassMethod([UIImage class], @selector(yrd_imageNamed:));
    // 开始交换方法实现
    method_exchangeImplementations(m1, m2);
}
+ (UIImage *)yrd_imageNamed:(NSString *)imageName {
    NSLog(@"name: %@",imageName);
    imageName = [imageName stringByAppendingString:@"_ios"];
    NSLog(@"name: %@",imageName);
    return [UIImage yrd_imageNamed:imageName];
}
@end
