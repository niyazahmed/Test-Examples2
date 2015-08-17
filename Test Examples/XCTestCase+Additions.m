//
//  XCTestCase+Additions.m
//  Screwdriver
//
//  Created by Phil on 2/19/15.
//  Copyright (c) 2015 Tablesand LLC. All rights reserved.
//

#import "XCTestCase+Additions.h"
#import  <objc/runtime.h>

@implementation XCTestCase (Additions)

#pragma mark - Helpers

- (void)swapInstanceMethodsForClass:(Class)class selector:(SEL)selector1 andSelector:(SEL)selector2 {
    Method method1 = class_getInstanceMethod(class, selector1);
    Method method2 = class_getInstanceMethod(class, selector2);
    method_exchangeImplementations(method1, method2);
}

@end
