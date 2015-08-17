//
//  ViewController.m
//  Test Examples
//
//  Created by Phil Beadle on 8/16/15.
//  Copyright (c) 2015 Tablesand LLC. All rights reserved.
//

#import "ViewController.h"
#import "ResultsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ResultsSegue"]) {
        ResultsViewController *resultsViewController = segue.destinationViewController;
        resultsViewController.resultString = self.activeResultString;
    }
}

#pragma IBActions

- (IBAction)resultsButtonTapped:(id)sender {
    self.activeResultString = @"Test";
    [self performSegueWithIdentifier:@"ResultsSegue" sender:self];
}

#pragma mark - Private

- (UIAlertController *)alertController {
    UIAlertController *alertController = [self.UIAlertControllerClass alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [self.UIAlertActionClass actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    return alertController;
}

- (void)keyboardWasShown:(NSNotification *)notification {
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
}

#pragma mark - Public

- (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertController = [self alertController];
    alertController.title = title;
    alertController.message = message;
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)registerForKeyboardNotifications {
    [self.defaultNotificationCenter addObserver:self
                                       selector:@selector(keyboardWasShown:)
                                           name:UIKeyboardWillShowNotification
                                         object:nil];
    
    [self.defaultNotificationCenter addObserver:self
                                       selector:@selector(keyboardWillBeHidden:)
                                           name:UIKeyboardWillHideNotification
                                         object:nil];
}

- (void)unregisterForKeyboardNotifications {
    [self.defaultNotificationCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [self.defaultNotificationCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Getters

- (NSNotificationCenter *)defaultNotificationCenter {
    if (!_defaultNotificationCenter) {
        _defaultNotificationCenter = [NSNotificationCenter defaultCenter];
    }
    return _defaultNotificationCenter;
}

- (Class)UIAlertControllerClass {
    if (!_UIAlertControllerClass) {
        _UIAlertControllerClass = [UIAlertController class];
    }
    return _UIAlertControllerClass;
}

- (Class)UIAlertActionClass {
    if (!_UIAlertActionClass) {
        _UIAlertActionClass = [UIAlertAction class];
    }
    return _UIAlertActionClass;
}

@end
