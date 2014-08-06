//
//  BHTNestedSelectionTableViewController.h
//  MultipleSelectionTableView
//
//  Created by Bartek Hugo Trzcinski on 05/08/14.
//  Copyright (c) 2014 Bartek Hugo Trzcinski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHTNestedSelectionObjectProtocol.h"
#import "BHTNestedSelectionCell.h"


@class BHTNestedSelectionTableViewController;

/*
 Data Source Protocol
 */
@protocol BHTNestedSelectionTableViewDataSource <NSObject>

- (BOOL)bhtNestedSelectionTableViewController:(BHTNestedSelectionTableViewController *)controller isObjectSelected:(id<BHTNestedSelectionObjectProtocol>)object;
@optional
- (BHTNestedSelectionCell *)bhtNestedSelectionTableViewController:(BHTNestedSelectionTableViewController *)controller cellWithReuseIdentifier:(NSString *)reuseIdentifier;

@end


/*
 Delegate Protocol
 */
@protocol BHTNestedSelectionTableViewDelegate <NSObject>

- (void)bhtNestedSelectionTableViewController:(BHTNestedSelectionTableViewController *)controller didSelectObject:(id<BHTNestedSelectionObjectProtocol>)object;
- (void)bhtNestedSelectionTableViewController:(BHTNestedSelectionTableViewController *)controller didSelectAccessoryForObject:(id<BHTNestedSelectionObjectProtocol>)object;
@optional
- (void)bhtNestedSelectionTableViewController:(BHTNestedSelectionTableViewController *)controller configureCell:(BHTNestedSelectionCell *)cell withObject:(id<BHTNestedSelectionObjectProtocol>)object;

@end



@interface BHTNestedSelectionTableViewController : UITableViewController

- (instancetype)initWithObject:(id<BHTNestedSelectionObjectProtocol>)object;

@property (nonatomic, weak) id<BHTNestedSelectionTableViewDelegate>   delegate;
@property (nonatomic, weak) id<BHTNestedSelectionTableViewDataSource> dataSource;

@end
