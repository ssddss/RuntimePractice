//
//  ViewController.m
//  RuntimePractice
//
//  Created by yurongde on 16/4/21.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "UIImage+Category.h"
#import "NSObject+Category.h"

#import <objc/runtime.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self normalPerson];
    
    [self exchangePersonMethod];
    
    [self normalPerson];
    
    [self setImage];
    
    [self setVCAdditionalProperty];
    
    [self setPersonAdditionalProperty];
    
    [self getPropertyInfoOfPerson];
    
    [self testArchieve];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)normalPerson {
   Person *man = [[Person alloc]initWithName:@"John"];
    [man run];
    [man sing];
}
/**
 *  交换方法，永久交换
 */
- (void)exchangePersonMethod {
    Method run = class_getInstanceMethod([Person class], @selector(run));
    
    Method sing = class_getInstanceMethod([Person class], @selector(sing));
    
    method_exchangeImplementations(run, sing);
    
    Person *man = [[Person alloc]initWithName:@"Amy"];
    [man run];
    [man sing];
}

- (void)setImage {
    [self.imageView setImage:[UIImage imageNamed:@"circle_market_banner_default"]];
}

/**
 *  给分类增加属性
 */
- (void)setVCAdditionalProperty {
    [self setCarName:@"BaoMa"];
    NSLog(@"vcCar_Property: %@",[self carName]);
}
- (void)setPersonAdditionalProperty {
    Person *man = [[Person alloc]initWithName:@"Baby"];
    [man run];
    [man sing];
    
    [man setCarName:@"Audi"];
    NSLog(@"Baby's_car_property: %@",man.carName);
}
/**
 *  获取person类的所有属性信息
 */
- (void)getPropertyInfoOfPerson {
    unsigned int outCount = 0;
    
    Ivar *ivars = class_copyIvarList([Person class], &outCount);
    
    //遍历所有成员
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSLog(@"成员变量名:%s  成员变量类型:%s",name,type);
    }
    
    free(ivars);
}
/**
 *  测试归档
 */
- (void)testArchieve {
    Person *man = [[Person alloc]initWithName:@"K"];
    man.isMan = NO;
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:man];
    
    [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"man"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSLog(@"保存成功");
    
     NSData *localData = [[NSUserDefaults standardUserDefaults] objectForKey:@"man"];
    Person *localMan = [NSKeyedUnarchiver unarchiveObjectWithData:localData];
    NSLog(@"localMan_Name: %@ isMan:%d",localMan.name,localMan.isMan);
}
@end
