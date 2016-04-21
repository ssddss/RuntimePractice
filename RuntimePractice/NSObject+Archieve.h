//
//  NSObject+Archieve.h
//  RuntimePractice
//
//  Created by yurongde on 16/4/21.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Archieve)
/**
 *  忽略的属性
 */
- (NSArray *)ignoreNames;
/**
 *  编码
 *
 *  @param aEncoder
 */
- (void)encode:(NSCoder *)aEncoder;
/**
 *  解码
 *
 *  @param aDecoder 
 */
- (void)decode:(NSCoder *)aDecoder;
@end
