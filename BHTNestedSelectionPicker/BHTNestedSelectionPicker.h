//
//  BHTNestedSelectionPicker.h
//  MultipleSelectionTableView
//
//  Created by Bartek Hugo Trzcinski on 05/08/14.
//  Copyright (c) 2014 Bartek Hugo Trzcinski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHTNestedSelectionObjectProtocol.h"
#import "BHTNestedSelectionCell.h"

@class BHTNestedSelectionPicker;

@protocol BHTNestedSelectionPickerDelegate <NSObject>

- (void)bhtNestedSelectionPicker:(BHTNestedSelectionPicker *)controller didFinishWithSelectedLeafObjects:(NSArray *)selectedLeafObjects;
@optional
- (BHTNestedSelectionCell *)bhtNestedSelectionPicker:(BHTNestedSelectionPicker *)controller cellWithReuseIdentifier:(NSString *)reuseIdentifier;
- (Class)bhtNestedSelectionPickerNavigationControllerClass:(BHTNestedSelectionPicker *)controller;

@end

@interface BHTNestedSelectionPicker : NSObject

- (instancetype)initWithRootObject:(id<BHTNestedSelectionObjectProtocol>)rootObject selectedObjects:(NSArray *)selectedObjects;
- (instancetype)initWithObjects:(NSArray *)objects selectedObjects:(NSArray *)selectedObjects;

//TODO: init with objects?
    
@property (nonatomic, weak) id<BHTNestedSelectionPickerDelegate> delegate;
@property (nonatomic, readonly) UIViewController *viewController;
@property (nonatomic, assign) BOOL multipleSelection;       // says if multiple selection of items is allowed

@end
