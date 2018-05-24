//
//  ViewController.m
//  ThreadRunloopAutoreleasePool
//
//  Created by sogou-Yan on 2018/5/24.
//  Copyright © 2018年 sogou. All rights reserved.
//

#import "ViewController.h"
#import "MrcObj.h"

@interface ViewController ()

@end

@implementation ViewController



/**
 
 本工程为MRC
 结论
 1. 主线程有一个NSRunLoop
 2. 每一个子线程有一个NSRunLoop
 3. releae --> retaincount -1
 4. autoreleae --> retaincount 不会立即 -1，
    将对象添加至在当前的releasepool，pool销毁之后没有对象持有当前对象会release 这一点可以从内存分布可以验证
 5. 至于每一runloop 是否存在一个 autoreleaepool 应该是有，暂时没有找到验证方法，但是 确实在当前函数栈区回收之后对象被销毁，根据官方文档对autoreleaepool 的说明介意解释的通
 
 内存分布查看方法点击图层按钮右边的第一个按钮查看当前内存分布
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    MrcObj *mrcObj = [MrcObj new];//1
    NSLog(@"mrcObj:%d",[mrcObj retainCount]);//1
    [mrcObj release];//0
#warning release 之后retaincount 为0 再发消息对象已经被销毁会crash
//    NSLog(@"mrcObj:%d",[mrcObj retainCount]);//exc_bad_access

   
    MrcObj *mrcObj1 = [MrcObj new];//1
    [mrcObj1 autorelease];//延迟release
    
    /** p [NSRunLoop currentRunLoop]
     (NSRunLoop *) $0 = 0x000060c0000b95c0 */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"mrcObj1:%d",[mrcObj1 retainCount]);//mrcObj:1
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self read];/** p [NSRunLoop currentRunLoop]
                     (NSRunLoop *) $1 = 0x000060c0000b9a40 */
    });
}

- (void)read {
    MrcObj *mrcObj2 = [MrcObj new];//1
    NSLog(@"mrcObj2:%d",[mrcObj2 retainCount]);//1
    [mrcObj2 autorelease];//不会立即release
    /** p [NSRunLoop currentRunLoop]
     (NSRunLoop *) $3 = 0x000060c0000b9a40 */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"mrcObj2:%d",[mrcObj2 retainCount]);//mrcObj2:1
        
        /**  p [NSRunLoop currentRunLoop]
         (NSRunLoop *) $2 = 0x000060c0000b95c0 */
    });
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"self:%@",self);
    /**  p [NSRunLoop currentRunLoop]
     (NSRunLoop *) $2 = 0x000060c0000b95c0 */
}


@end
