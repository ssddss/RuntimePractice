//
//  Person.m
//  RuntimePractice
//
//  Created by yurongde on 16/4/21.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "Person.h"
#import "NSObject+Archieve.h"
@implementation Person
- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    _name = name;
    
    return self;
}
- (void)run {
    NSLog(@"%@_run",self.name);
}
- (void)sing {
    NSLog(@"%@_sing",self.name);
}
- (NSArray *)ignoreNames {
    return @[@"isMan"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        [self decode:aDecoder];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self encode:aCoder];
}
@end
