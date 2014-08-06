//
//  BHTNestedSelectionTableViewController.h
//  MultipleSelectionTableView
//
//  Created by Bartek Hugo Trzcinski on 05/08/14.
//  Copyright (c) 2014 Bartek Hugo Trzcinski. All rights reserved.
//

#import "BHTNestedSelectionTableViewController.h"
#import "BHTNestedSelectionCell.h"

@interface BHTNestedSelectionTableViewController () <BHTNestedSelectionCellDelegate>

@property (nonatomic, strong) id<BHTNestedSelectionObjectProtocol> object;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation BHTNestedSelectionTableViewController

- (instancetype)initWithObject:(id<BHTNestedSelectionObjectProtocol>)object
{
    if (!(self = [super init]))
        return nil;
    
    _object = object;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.object.navigationBarTitle;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    [self.tableView selectRowAtIndexPath:self.selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self deselectSelectedIndexPath];
}

- (void)deselectSelectedIndexPath
{
    if (self.selectedIndexPath)
    {
        [self.tableView deselectRowAtIndexPath:self.selectedIndexPath animated:YES];
        self.selectedIndexPath = nil;
    }
}

#pragma mark - UITabelViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<BHTNestedSelectionObjectProtocol> object = [self objectAtIndexPath:indexPath];
    [self.delegate bhtNestedSelectionTableViewController:self didSelectObject:object];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationFade];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self showChildrenForCellAtIndexPath:indexPath];
}

#pragma mark - UITabelViewDataSource

- (id<BHTNestedSelectionObjectProtocol>)objectAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.object children][indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.object children] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const reuseIdentifier = @"Cell";
    
    BHTNestedSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        if ([self.dataSource respondsToSelector:@selector(bhtNestedSelectionTableViewController:cellWithReuseIdentifier:)])
            cell = [self.dataSource bhtNestedSelectionTableViewController:self cellWithReuseIdentifier:reuseIdentifier];
        
        if (!cell)
            cell = [[BHTNestedSelectionCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
   
    return cell;
}

- (void)configureCell:(BHTNestedSelectionCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    id<BHTNestedSelectionObjectProtocol> object = [self objectAtIndexPath:indexPath];
    
    BOOL selected = [self.dataSource bhtNestedSelectionTableViewController:self isObjectSelected:object];
    
    [cell setDelegate:self];
    [cell setMarked:selected];
    [cell setDisplayName:object.recordName];
    [cell setDisplayType:object.detailName];
    [cell setChildrenCount:[object.children count]];

    if ([self.delegate respondsToSelector:@selector(bhtNestedSelectionTableViewController:configureCell:withObject:)])
        [self.delegate bhtNestedSelectionTableViewController:self configureCell:cell withObject:object];
}

#pragma mark - BHTNestedSelectionCellDelegate

- (void)bhtNestedSelectionCellDidSelectShowChildren:(BHTNestedSelectionCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
 
    [self showChildrenForCellAtIndexPath:indexPath];
}

- (void)showChildrenForCellAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    id<BHTNestedSelectionObjectProtocol> object = [self objectAtIndexPath:indexPath];
    [self.delegate bhtNestedSelectionTableViewController:self didSelectAccessoryForObject:object];
}

@end
