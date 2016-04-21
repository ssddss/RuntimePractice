//
//  NSObject+Archieve.m
//  RuntimePractice
//
//  Created by yurongde on 16/4/21.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "NSObject+Archieve.h"
#import <objc/runtime.h>
@implementation NSObject (Archieve)
- (void)encode:(NSCoder *)aEncoder {
    Class c = self.class;
    
    while (c && c != [NSObject class]) {
        
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        
        NSArray *ignoreNames = @[];
        if ([self respondsToSelector:@selector(ignoreNames)]) {
            ignoreNames = [self ignoreNames];
        }
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *propertyName = [NSString stringWithUTF8String:ivar_getName(ivar)];
            if (ignoreNames.count) {
                if ([ignoreNames containsObject:propertyName]) {
                    continue;
                }
            }
            
            id value = [self valueForKeyPath:propertyName];
            [aEncoder encodeObject:value forKey:propertyName];
        }
        
        free(ivars);
        c = [c superclass];
    }
}

- (void)decode:(NSCoder *)aDecoder {
    Class c = self.class;
    
    while (c && c != [NSObject class]) {
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        
        NSArray *ignoreNames = @[];
        if ([self respondsToSelector:@selector(ignoreNames)]) {
            ignoreNames = [self ignoreNames];
        }
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *propertyName = [NSString stringWithUTF8String:ivar_getName(ivar)];
            if (ignoreNames.count) {
                if ([ignoreNames containsObject:propertyName]) {
                    continue;
                }
            }
            
            id value = [aDecoder decodeObjectForKey:propertyName];
            [self setValue:value forKey:propertyName];
        }
        
        free(ivars);

        
        c = [c superclass];
        
    }
}
@end
