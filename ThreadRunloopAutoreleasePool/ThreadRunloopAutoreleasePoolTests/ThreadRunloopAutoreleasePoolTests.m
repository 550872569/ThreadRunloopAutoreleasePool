//
//  ThreadRunloopAutoreleasePoolTests.m
//  ThreadRunloopAutoreleasePoolTests
//
//  Created by sogou-Yan on 2018/5/24.
//  Copyright © 2018年 sogou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestObj.h"

@interface ThreadRunloopAutoreleasePoolTests : XCTestCase

@end

@implementation ThreadRunloopAutoreleasePoolTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}
- (void)testNewObj {
    [self checkObjInitDict:@{@"age":@12,@"name":@"lilei"}];
    [self checkObjInitDict:@{@"age":@12,@"name":@"      "}];
//    [self checkObjInitDict:@{@"age":@131,@"name":@"hanmeimei"}];
}
- (void)checkObjInitDict:(NSDictionary *)dict {
    NSString *name = dict[@"name"];
    NSInteger age = [dict[@"age"] integerValue];
    TestObj *obj = [TestObj objWithDict:dict];
    
    XCTAssert(obj.name == nil, @"姓名为空");
    XCTAssert([name isEqualToString:obj.name], @"姓名不一致");

    if (obj.age > 0 && obj.age < 130) {
        XCTAssert(age == obj.age, @"年龄不一致");
    } else {
        XCTAssert(obj.age == 0, @"年龄超限");
    }

    NSLog(@"obj:%@",obj);
    XCTAssertNotNil(obj);
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
//        [self testNewObj];

    }];
}

@end
