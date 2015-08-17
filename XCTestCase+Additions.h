//
//  XCTestCase+Additions.h
//  Screwdriver
//
//  Created by Phil on 2/19/15.
//  Copyright (c) 2015 ToolWatch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  <objc/runtime.h>

#define MOCKITO_SHORTHAND
#import <OCMockitoIOS/OCMockitoIOS.h>
#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

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

- (void)swapInstanceMethodsForClass:(Class)cls selector:(SEL)sel1 andSelector:(SEL)sel2;

@end
