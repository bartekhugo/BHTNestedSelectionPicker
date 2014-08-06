//
//  BHTNestedSelectionCell.h
//  MultipleSelectionTableView
//
//  Created by Bartek Hugo Trzcinski on 06/08/14.
//  Copyright (c) 2014 Bartek Hugo Trzcinski. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
    IMPORTANT: When subclassing and creating custom showChildrenButton its necessery to call delegate method inside that button action method
 */

@class BHTNestedSelectionCell;

@protocol BHTNestedSelectionCellDelegate <NSObject>

- (void)bhtNestedSelectionCellDidSelectShowChildren:(BHTNestedSelectionCell *)cell;

@end


@interface BHTNestedSelectionCell : UITableViewCell

@property (nonatomic, assign) BOOL marked;
@property (nonatomic, weak) id<BHTNestedSelectionCellDelegate> delegate;

- (void)setDisplayName:(NSString *)displayName;
- (void)setDisplayType:(NSString *)displayType;
- (void)setChildrenCount:(NSInteger)childrenCount;

@end
