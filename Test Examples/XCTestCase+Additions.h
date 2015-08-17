//
//  XCTestCase+Additions.h
//  Screwdriver
//
//  Created by Phil on 2/19/15.
//  Copyright (c) 2015 Tablesand LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  <objc/runtime.h>

#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

#define MOCKITO_SHORTHAND
#import <OCMockitoIOS/OCMockitoIOS.h>

static char *const StoryboardSegueKey = "SegueTestPrepareForSegueSegueKey";
static char *const SegueIdentifierKey = "SegueIdentifierKey";
static char *const SenderKey = "SegueTestPrepareForSegueSenderKey";
static char *const AnimatedKey = "TestAnimatedKey";
static char *const CompletionKey = "TestCompletionKey";
static char *const ViewControllerKey = "TestViewControllerKey";
static char *const NavigationControllerKey = "TestNavigationControllerKey";
static char *const TabBarControllerKey = "TestTabBarControllerKey";
static char *const PresentingVCKey = "PresentingVCKey";

@interface XCTestCase (Additions)

- (void)swapInstanceMethodsForClass:(Class)class selector:(SEL)selector1 andSelector:(SEL)selector2;

@end
