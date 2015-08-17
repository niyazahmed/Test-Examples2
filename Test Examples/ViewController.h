//
//  ViewController.h
//  Test Examples
//
//  Created by Phil Beadle on 8/16/15.
//  Copyright (c) 2015 Tablesand LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) NSNotificationCenter *defaultNotificationCenter;
@property (strong, nonatomic) Class UIAlertControllerClass;
@property (strong, nonatomic) Class UIAlertActionClass;
@property (strong, nonatomic) NSString *activeResultString;

- (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message;
- (void)registerForKeyboardNotifications;
- (void)unregisterForKeyboardNotifications;

- (IBAction)resultsButtonTapped:(id)sender;

@end

