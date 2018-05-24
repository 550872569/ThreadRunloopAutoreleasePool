//
//  TestObj.m
//  ThreadRunloopAutoreleasePool
//
//  Created by sogou-Yan on 2018/5/24.
//  Copyright © 2018年 sogou. All rights reserved.
//

#import "TestObj.h"

@implementation TestObj

+ (instancetype)objWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
