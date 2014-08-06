//
//  BHTNestedSelectionPicker.m
//  MultipleSelectionTableView
//
//  Created by Bartek Hugo Trzcinski on 05/08/14.
//  Copyright (c) 2014 Bartek Hugo Trzcinski. All rights reserved.
//

#import "BHTNestedSelectionPicker.h"
#import "BHTNestedSelectionTableViewController.h"
#import "BHTNestedSelectionTree.h"

@interface BHTNestedSelectionPicker () <BHTNestedSelectionTableViewDataSource, BHTNestedSelectionTableViewDelegate>

@property (nonatomic, strong) id<BHTNestedSelectionObjectProtocol> rootObject;
@property (nonatomic, strong) UINavigationController *navigationController; //TODO: rename

@property (nonatomic, strong) BHTNestedSelectionTree *objectsSelection;
@end


@implementation BHTNestedSelectionPicker

- (instancetype)initWithRootObject:(id<BHTNestedSelectionObjectProtocol>)rootObject
{
    if (!(self = [super init]))
        return nil;
    
    _rootObject = rootObject;

    return self;
}

- (UINavigationController *)navigationController
{
    if (!_navigationController)
    {
        BHTNestedSelectionTableViewController *selectionTableViewController = [self selectionTableViewControllerWithObject:self.rootObject];
        
        UINavigationController *naviagationController = [[UINavigationController alloc] initWithRootViewController:selectionTableViewController];
        _navigationController = naviagationController;
    }

    return _navigationController;
}

- (UIViewController *)viewController
{
    return self.navigationController;
}

- (BHTNestedSelectionTree *)objectsSelection
{
    if (!_objectsSelection)
    {
        BHTNestedSelectionTree *objectsSection = [[BHTNestedSelectionTree alloc] init];
        _objectsSelection = objectsSection;
    }
    
    return _objectsSelection;
}

- (BHTNestedSelectionTableViewController *)selectionTableViewControllerWithObject:(id<BHTNestedSelectionObjectProtocol>)object
{
    BHTNestedSelectionTableViewController *selectionTableViewController = [[BHTNestedSelectionTableViewController alloc] initWithObject:object];
    selectionTableViewController.dataSource = self;
    selectionTableViewController.delegate = self;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonAction:)];
    selectionTableViewController.navigationItem.rightBarButtonItem = doneButton;

    
    return selectionTableViewController;
}

- (void)showSubitemsOfObject:(id<BHTNestedSelectionObjectProtocol>)object
{
    BHTNestedSelectionTableViewController *selectionTableViewController = [self selectionTableViewControllerWithObject:object];
    [self.navigationController pushViewController:selectionTableViewController animated:YES];
}

- (void)doneButtonAction:(id)sender
{
    [self.delegate BHTNestedSelectionPicker:self didFinishWithSelectedLeafObjects:nil];
}

#pragma mark - BHTNestedSelectionTableViewDataSource

- (BHTNestedSelectionCell *)bhtNestedSelectionTableViewController:(BHTNestedSelectionTableViewController *)controller cellWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if ([self.delegate respondsToSelector:@selector(BHTNestedSelectionPicker:cellWithReuseIdentifier:)])
        return [self.delegate BHTNestedSelectionPicker:self cellWithReuseIdentifier:reuseIdentifier];

    return nil;
}

- (BOOL)bhtNestedSelectionTableViewController:(BHTNestedSelectionTableViewController *)controller isObjectSelected:(id<BHTNestedSelectionObjectProtocol>)object
{
    return [self.objectsSelection isObjectSelected:object];
}

#pragma mark - BHTNestedSelectionTableViewDelegate

- (void)bhtNestedSelectionTableViewController:(BHTNestedSelectionTableViewController *)controller didSelectObject:(id<BHTNestedSelectionObjectProtocol>)object
{
    [self.objectsSelection toggleObjectSelection:object];
}

- (void)bhtNestedSelectionTableViewController:(BHTNestedSelectionTableViewController *)controller didSelectAccessoryForObject:(id<BHTNestedSelectionObjectProtocol>)object
{
    [self showSubitemsOfObject:object];
}


@end