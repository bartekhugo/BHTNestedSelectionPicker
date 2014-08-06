//
//  BHTNestedSelectionCell.m
//  MultipleSelectionTableView
//
//  Created by Bartek Hugo Trzcinski on 06/08/14.
//  Copyright (c) 2014 Bartek Hugo Trzcinski. All rights reserved.
//

#import "BHTNestedSelectionCell.h"

@implementation BHTNestedSelectionCell

- (void)setMarked:(BOOL)marked
{
    _marked = marked;
    self.backgroundColor = marked ? [UIColor greenColor] : [UIColor whiteColor];
}

- (void)setDisplayName:(NSString *)displayName
{
    self.textLabel.text = displayName;
}

- (void)setDisplayType:(NSString *)displayType
{
    self.detailTextLabel.text = displayType;
}

- (void)setChildrenCount:(NSInteger)childrenCount
{
    self.accessoryType = childrenCount > 0 ? UITableViewCellAccessoryDetailButton : UITableViewCellAccessoryNone;
}

@end
