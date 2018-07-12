//
//  ViewController.m
//  runtime
//
//  Created by 曾觉新 on 2018/7/11.
//  Copyright © 2018年 曾觉新. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "Person.h"

@interface ViewController ()
{
    NSString *address;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"曾觉新";
    
    
    //获取成员变量
    unsigned int ivarCount = 0;
    Ivar *ivars = class_copyIvarList([ViewController class], &ivarCount);
    for (int i = 0; i < ivarCount; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSLog(@"变量名 = %s, 变量类型 = %s", name, type);
    }
    free(ivars);
    
    //获取属性
    unsigned int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList([ViewController class], &propertyCount);
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t property = propertys[i];
        const char *name = property_getName(property);
        const char *attribute = property_getAttributes(property);
        NSLog(@"属性名 = %s, 属性特性 = %s", name, attribute);
    }
    free(propertys);
    
    //访问私有类
    Ivar nameIvar = class_getInstanceVariable(self.class, "_name");
    NSString *name = object_getIvar(self, nameIvar);
    NSLog(@"%@", name);
    
    //方法交换
//    Method method1 = class_getInstanceMethod(self.class, @selector(a));
//    Method method2 = class_getInstanceMethod(self.class, @selector(b));
//    method_exchangeImplementations(method1, method2);
//    [self a];
    
    
    //方法替换
    IMP imp = class_getMethodImplementation(self.class, @selector(b));
    class_replaceMethod(self.class, @selector(a), imp, nil);
    [self a];
    
    
}

- (void)a
{
    NSLog(@"方法a");
}
- (void)b
{
    NSLog(@"方法b");
}

+ (void)c
{
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
