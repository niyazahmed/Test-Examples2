//
//  XCTestCase+Additions.m
//  Screwdriver
//
//  Created by Phil on 2/19/15.
//  Copyright (c) 2015 ToolWatch. All rights reserved.
//

#import "XCTestCase+Additions.h"
#import  <objc/runtime.h>

@implementation XCTestCase (Additions)

#pragma mark - Helpers

- (void)swapInstanceMethodsForClass:(Class)cls selector:(SEL)sel1 andSelector:(SEL)sel2 {
    Method method1 = class_getInstanceMethod(cls, sel1);
    Method method2 = class_getInstanceMethod(cls, sel2);
    method_exchangeImplementations(method1, method2);
}

@end
