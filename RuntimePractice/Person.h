//
//  Person.h
//  RuntimePractice
//
//  Created by yurongde on 16/4/21.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL isMan;
- (instancetype)initWithName:(NSString *)name;

- (void)run;

- (void)sing;
@end
