//
//  STFFilterSelection.h
//  MultipleSelectionTableView
//
//  Created by Bartek Hugo Trzcinski on 06/08/14.
//  Copyright (c) 2014 Bartek Hugo Trzcinski. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BHTNestedSelectionObjectProtocol.h"
#import <JTTree/JTTree.h>


@interface BHTNestedSelectionTree : NSObject

@property (nonatomic, strong, readonly) JTTree *rootNode;
- (NSArray *)selectedLeafObjects;

- (void)toggleObjectSelection:(id<BHTNestedSelectionObjectProtocol>)object;
- (BOOL)isObjectSelected:(id<BHTNestedSelectionObjectProtocol>)object;

@end
