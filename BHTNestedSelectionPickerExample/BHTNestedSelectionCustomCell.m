//
//  BHTCustomNestedSelectionCell.m
//  MultipleSelectionTableView
//
//  Created by Bartek Hugo Trzcinski on 06/08/14.
//  Copyright (c) 2014 Bartek Hugo Trzcinski. All rights reserved.
//

#import "BHTNestedSelectionCustomCell.h"

@interface BHTNestedSelectionCustomCell ()

@property (nonatomic, strong) UIButton *accessoryButton;

@end

@implementation BHTNestedSelectionCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
        return nil;
    
    [self comonInit];
    
    return self;
}

- (void)comonInit
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.accessoryView = self.accessoryButton;
}

- (void)setMarked:(BOOL)marked
{
    [super setMarked:marked];
    
    self.backgroundColor = marked ? [UIColor redColor] : [UIColor whiteColor];
}

- (void)setChildrenCount:(NSInteger)childrenCount
{
    self.accessoryView.hidden = childrenCount == 0;
}

- (UIButton *)accessoryButton
{
    if (!_accessoryButton)
    {
        UIButton *accessoryButton = [UIButton buttonWithType:UIButtonTypeSystem];
        accessoryButton.frame = CGRectMake(0, 0, 50, 44);
        
        [accessoryButton setTitle:@"haha" forState:UIControlStateNormal];
        [accessoryButton addTarget:self action:@selector(accessoryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
        _accessoryButton = accessoryButton;
    }
    
    return _accessoryButton;
}

- (void)accessoryButtonAction:(id)sender
{
    [self.delegate bhtNestedSelectionCellDidSelectShowChildren:self];
}


@end
