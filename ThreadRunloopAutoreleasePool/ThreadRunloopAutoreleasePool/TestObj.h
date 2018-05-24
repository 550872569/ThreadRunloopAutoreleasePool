//
//  TestObj.h
//  ThreadRunloopAutoreleasePool
//
//  Created by sogou-Yan on 2018/5/24.
//  Copyright © 2018年 sogou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestObj : NSObject

@property(nonatomic, assign) int age;

@property(nonatomic, copy) NSString *name;

+ (instancetype)objWithDict:(NSDictionary *)dict;

@end
