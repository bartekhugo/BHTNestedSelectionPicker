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


@interface BHTViewController () <BHTNestedSelectionPickerDelegate>

@property (strong, nonatomic) BHTNestedSelectionPicker *selectionController;

@end

@implementation BHTViewController

- (IBAction)showPickerButtonAction:(id)sender
{
    BHTNestedSelectionCustomObject *rootObject = [[BHTNestedSelectionCustomObject alloc] initWithDictionary:[NSDictionary dictionaryFromPropertyListWithName:@"STFilterButtonTypeOptions"]];
    
    BHTNestedSelectionPicker *selectionController = [[BHTNestedSelectionPicker alloc] initWithRootObject:rootObject];
    selectionController.delegate = self;
    selectionController.multipleSelection = YES;
    self.selectionController = selectionController;
    
    [self presentViewController:selectionController.viewController animated:YES completion:nil];
}


#pragma mark - BHTNestedSelectionPickerDelegate

- (void)BHTNestedSelectionPicker:(BHTNestedSelectionPicker *)ceontroller didFinishWithSelectedLeafObjects:(NSArray *)selectedLeafObjects
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BHTNestedSelectionCell *)BHTNestedSelectionPicker:(BHTNestedSelectionPicker *)controller cellWithReuseIdentifier:(NSString *)reuseIdentifier
{
    BHTNestedSelectionCustomCell *cell = [[BHTNestedSelectionCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    return cell;
    
}

@end
