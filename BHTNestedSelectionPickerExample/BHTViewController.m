//
//  BHTViewController.m
//  BHTNestedSelectionPickerExample
//
//  Created by Bartek Hugo Trzcinski on 06/08/14.
//  Copyright (c) 2014 Bartek Hugo Trzcinski. All rights reserved.
//

#import "BHTViewController.h"

#import "BHTNestedSelectionPicker.h"

#import "NSDictionary+loadPropertyList.h"
#import "BHTNestedSelectionCustomObject.h"

#import "BHTNestedSelectionCustomCell.h"

#import "BHTNestedSelectionCustomNavigationController.h"


@interface BHTViewController () <BHTNestedSelectionPickerDelegate>

@property (strong, nonatomic) BHTNestedSelectionPicker *selectionController;
@property (strong, nonatomic) NSArray *selectedOptions;

@property (strong, nonatomic) BHTNestedSelectionCustomObject *rootObject;
@end

@implementation BHTViewController

- (IBAction)showPickerButtonAction:(id)sender
{
    BHTNestedSelectionPicker *selectionController = [[BHTNestedSelectionPicker alloc] initWithRootObject:self.rootObject selectedObjects:self.selectedOptions];
    selectionController.delegate = self;
    selectionController.multipleSelection = YES;
    self.selectionController = selectionController;
    
    [self presentViewController:selectionController.viewController animated:YES completion:nil];
}


-(BHTNestedSelectionCustomObject *)rootObject
{
    if (!_rootObject) {
        BHTNestedSelectionCustomObject *rootObject = [[BHTNestedSelectionCustomObject alloc] initWithDictionary:[NSDictionary dictionaryFromPropertyListWithName:@"STFilterButtonTypeOptions"]];
        _rootObject = rootObject;
    }
    return _rootObject;
}

#pragma mark - BHTNestedSelectionPickerDelegate

- (void)bhtNestedSelectionPicker:(BHTNestedSelectionPicker *)ceontroller didFinishWithSelectedLeafObjects:(NSArray *)selectedLeafObjects
{
    self.selectedOptions = selectedLeafObjects;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BHTNestedSelectionCell *)bhtNestedSelectionPicker:(BHTNestedSelectionPicker *)controller cellWithReuseIdentifier:(NSString *)reuseIdentifier
{
    BHTNestedSelectionCustomCell *cell = [[BHTNestedSelectionCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    return cell;
    
}
- (Class)bhtNestedSelectionPickerNavigationControllerClass:(BHTNestedSelectionPicker *)controller
{
    return [BHTNestedSelectionCustomNavigationController class];
}

@end
