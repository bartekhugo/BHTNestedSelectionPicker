//
//  BHTNestedSelectionCustomNavigationController.m
//  BHTNestedSelectionPickerExample
//
//  Created by Bartek Hugo Trzcinski on 07/08/14.
//  Copyright (c) 2014 Bartek Hugo Trzcinski. All rights reserved.
//

#import "BHTNestedSelectionCustomNavigationController.h"

@interface BHTNestedSelectionCustomNavigationController ()

@end

@implementation BHTNestedSelectionCustomNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.navigationBar.tintColor       = [UIColor redColor];
    self.navigationBar.backgroundColor = [UIColor yellowColor];
    
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0],
                                               NSForegroundColorAttributeName: [UIColor greenColor]};
}


@end
