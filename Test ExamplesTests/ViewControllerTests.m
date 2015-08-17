//
//  ViewControllerTests.m
//  Test Examples
//
//  Created by Phil Beadle on 8/16/15.
//  Copyright (c) 2015 Tablesand LLC. All rights reserved.
//

#import "XCTestCase+Additions.h"
#import "ViewController.h"
#import "ResultsViewController.h"

@implementation ViewController (Testing)

- (UINavigationController *)navigationController {
    return objc_getAssociatedObject(self, NavigationControllerKey);
}

- (void)setNavigationController:(UINavigationController *)navigationController {
    objc_setAssociatedObject(self, NavigationControllerKey, navigationController, OBJC_ASSOCIATION_RETAIN);
}

- (void)testPresentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion {
    objc_setAssociatedObject(self, ViewControllerKey, viewController, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, AnimatedKey, @(animated), OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, CompletionKey, completion, OBJC_ASSOCIATION_RETAIN);
}

- (void)testPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    objc_setAssociatedObject(self, SegueIdentifierKey, identifier, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, SenderKey, sender, OBJC_ASSOCIATION_RETAIN);
}

@end

@interface ViewControllerTests : XCTestCase

@property (strong, nonatomic) ViewController *sut;
@property (strong, nonatomic) ResultsViewController *resultsViewController;
@property (nonatomic, strong) UIAlertController *mockAlertController;

@end

@implementation ViewControllerTests

- (void)setUp {
    [super setUp];
    self.sut = [ViewController new];
    self.resultsViewController = [ResultsViewController new];
    self.sut.UIAlertActionClass = mockClass([UIAlertAction class]);
    self.sut.UIAlertControllerClass = mockClass([UIAlertController class]);
    self.mockAlertController = mock([UIAlertController class]);
    [given([self.sut.UIAlertControllerClass alertControllerWithTitle:anything() message:anything() preferredStyle:UIAlertControllerStyleAlert]) willReturn:self.mockAlertController];
}

- (void)tearDown {
    self.sut = nil;
    self.resultsViewController = nil;
    self.mockAlertController = nil;
    [super tearDown];
}

#pragma mark - Helpers

- (void)swapPresentViewControllerMethod {
    [self swapInstanceMethodsForClass:[ViewController class] selector:@selector(presentViewController:animated:completion:) andSelector:@selector(testPresentViewController:animated:completion:)];
}

- (void)swapPerformSegueMethod {
    [self swapInstanceMethodsForClass:[ViewController class] selector:@selector(performSegueWithIdentifier:sender:) andSelector:@selector(testPerformSegueWithIdentifier:sender:)];
}

#pragma mark - Test UIAlertController

- (void)test_UIAlertControllerClass_Default_ShouldNotBeNil {
    self.sut.UIAlertControllerClass = nil;
    
    XCTAssertNotNil(self.sut.UIAlertControllerClass);
}

- (void)test_UIAlertControllerClass_Default_ShouldBeKindOfClassUIView {
    self.sut.UIAlertControllerClass = nil;
    
    XCTAssertEqual(self.sut.UIAlertControllerClass, [UIAlertController class]);
}

- (void)test_UIAlertControllerClass_SetObject_ShouldReturnSetObject {
    __strong Class mockUIAlertControllerClass = mockClass([UIAlertController class]);
    self.sut.UIAlertControllerClass = mockUIAlertControllerClass;
    
    XCTAssertEqualObjects(self.sut.UIAlertControllerClass, mockUIAlertControllerClass);
}

#pragma mark - Test UIAlertAction

- (void)test_UIAlertActionClass_Default_ShouldNotBeNil {
    self.sut.UIAlertActionClass = nil;
    
    XCTAssertNotNil(self.sut.UIAlertActionClass);
}

- (void)test_UIAlertActionClass_Default_ShouldBeKindOfClassUIView {
    self.sut.UIAlertActionClass = nil;
    
    XCTAssertEqual(self.sut.UIAlertActionClass, [UIAlertAction class]);
}

- (void)test_UIAlertActionClass_SetObject_ShouldReturnSetObject {
    __strong Class mockUIAlertActionClass = mockClass([UIAlertAction class]);
    self.sut.UIAlertActionClass = mockUIAlertActionClass;
    
    XCTAssertEqualObjects(self.sut.UIAlertActionClass, mockUIAlertActionClass);
}

#pragma mark - Test DefaultNotificationCenter

- (void)test_defaultNotificationCenter_default_ShouldNotBeNil {
    self.sut.defaultNotificationCenter = nil;
    
    XCTAssertNotNil(self.sut.defaultNotificationCenter);
}

- (void)test_defaultNotificationCenter_default_ShouldBeNSNotificationCenterType {
    self.sut.defaultNotificationCenter = nil;
    
    XCTAssertTrue([self.sut.defaultNotificationCenter isKindOfClass:[NSNotificationCenter class]]);
}

- (void)test_defaultNotificationCenter_default_ShouldBeSingletonInstance {
    self.sut.defaultNotificationCenter = nil;
    
    XCTAssertEqualObjects(self.sut.defaultNotificationCenter, [NSNotificationCenter defaultCenter]);
}

- (void)test_defaultNotificationCenter_Preexisting_ShouldBeEqual {
    NSNotificationCenter *mockNotificationCenter = mock([NSNotificationCenter class]);
    self.sut.defaultNotificationCenter = mockNotificationCenter;
    
    XCTAssertEqualObjects(self.sut.defaultNotificationCenter, mockNotificationCenter);
}

#pragma mark - Test PrepareForSegue

- (void)test_prepareForSegue_ResultsSegueWithActiveResultString_ResultStringShouldNotBeNil {
    UIStoryboardSegue *segue = [UIStoryboardSegue segueWithIdentifier:@"ResultsSegue" source:self.sut destination:self.resultsViewController performHandler:^{}];
    self.sut.activeResultString = @"Anything";
    
    [self.sut prepareForSegue:segue sender:self.sut];
    
    XCTAssertNotNil(self.resultsViewController.resultString);
}

- (void)test_prepareForSegue_ResultsSegueWithActiveResultString_ResultStringShouldBeTaco {
    UIStoryboardSegue *segue = [UIStoryboardSegue segueWithIdentifier:@"ResultsSegue" source:self.sut destination:self.resultsViewController performHandler:^{}];
    self.sut.activeResultString = @"Taco";
    
    [self.sut prepareForSegue:segue sender:self.sut];
    
    XCTAssertEqualObjects(self.resultsViewController.resultString, @"Taco");
}

#pragma mark - Test ShowAlertControllerWithTitle

- (void)test_showAlertControllerWithTitle_Default_AlertActionClassShouldAddActionCancelActionWithOKTitle {
    [self swapPresentViewControllerMethod];
    UIAlertAction *cancelAction = [UIAlertAction new];
    [given([self.sut.UIAlertActionClass actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:anything()]) willReturn:cancelAction];
    
    [self.sut showAlertControllerWithTitle:nil message:nil];
    
    [MKTVerify(self.mockAlertController) addAction:cancelAction];
    [self swapPresentViewControllerMethod];
}

- (void)test_showAlertControllerWithTitle_Default_AlertControllerStyleShouldBeAlert {
    [self swapPresentViewControllerMethod];
    
    [self.sut showAlertControllerWithTitle:nil message:nil];
    
    [MKTVerify(self.sut.UIAlertControllerClass) alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self swapPresentViewControllerMethod];
}

- (void)test_showAlertControllerWithTitle_ErrorTitle_AlertControllerTitleShouldBeError {
    [self swapPresentViewControllerMethod];
    
    [self.sut showAlertControllerWithTitle:@"Error" message:nil];
    
    [MKTVerify(self.mockAlertController) setTitle:@"Error"];
    [self swapPresentViewControllerMethod];
}

- (void)test_showAlertControllerWithTitle_ErrorMessage_AlertControllerTitleShouldBeMessage {
    [self swapPresentViewControllerMethod];
    
    [self.sut showAlertControllerWithTitle:nil message:@"Message"];
    
    [MKTVerify(self.mockAlertController) setMessage:@"Message"];
    [self swapPresentViewControllerMethod];
}

- (void)test_showAlertControllerWithTitle_PresentedVCShouldBeUIAlertController {
    [self swapPresentViewControllerMethod];
    
    [self.sut showAlertControllerWithTitle:nil message:nil];
    
    XCTAssertTrue([objc_getAssociatedObject(self.sut, ViewControllerKey) isKindOfClass:[UIAlertController class]]);
    [self swapPresentViewControllerMethod];
}

- (void)test_showAlertControllerWithTitle_ShouldPresentVCAnimatedYES {
    [self swapPresentViewControllerMethod];
    
    [self.sut showAlertControllerWithTitle:nil message:nil];
    
    XCTAssertTrue([objc_getAssociatedObject(self.sut, AnimatedKey) boolValue]);
    [self swapPresentViewControllerMethod];
}

- (void)test_showAlertControllerWithTitle_ShouldPresentVCWithCompletionBlockNil {
    [self swapPresentViewControllerMethod];
    
    [self.sut showAlertControllerWithTitle:nil message:nil];
    
    XCTAssertNil(objc_getAssociatedObject(self.sut, CompletionKey));
    [self swapPresentViewControllerMethod];
}

#pragma mark - Test ResultsButtonTapped

- (void)test_resultsButtonTapped_Default_SegueShouldBeResultsSegue {
    [self swapPerformSegueMethod];
    
    [self.sut resultsButtonTapped:nil];
    
    XCTAssertEqualObjects(objc_getAssociatedObject(self.sut, SegueIdentifierKey), @"ResultsSegue");
    [self swapPerformSegueMethod];
}

- (void)test_ResultsButtonTapped_Default_ActiveResultStringShouldBeTest {
    [self swapPerformSegueMethod];
    
    [self.sut resultsButtonTapped:nil];
    
    XCTAssertEqualObjects(self.sut.activeResultString, @"Test");
    [self swapPerformSegueMethod];
}


@end
