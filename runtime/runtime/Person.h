//
//  Person.h
//  runtime
//
//  Created by 曾觉新 on 2018/7/11.
//  Copyright © 2018年 曾觉新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;

@end
