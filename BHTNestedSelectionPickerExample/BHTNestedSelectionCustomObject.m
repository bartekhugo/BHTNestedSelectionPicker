//
//  STFilterObject.m
//  Bond
//
//  Created by Paweł Sporysz on 29.07.2014.
//  Copyright (c) 2014 Untitled Kingdom. All rights reserved.
//

#import "BHTNestedSelectionCustomObject.h"

static NSString * const STFilterOptionTableViewCellTitleKey   = @"Title";
static NSString * const STFilterOptionTableViewCellNameKey    = @"Name";
static NSString * const STFilterOptionTableViewCellOptionsKey = @"Options";
static NSString * const STFilterOptionTableViewCellHintKey    = @"Hint";

@interface BHTNestedSelectionCustomObject()

@property (strong, nonatomic, readwrite) NSString *navigationBarTitle;
@property (strong, nonatomic, readwrite) NSString *recordName;
@property (strong, nonatomic, readwrite) NSString *detailName;

@property (strong, nonatomic, readwrite) NSArray *children;
@property (strong, nonatomic, readwrite) id<BHTNestedSelectionObjectProtocol> parent;

@property (nonatomic, readwrite) NSInteger defaultSelectedOptionIndex;

@end

@implementation BHTNestedSelectionCustomObject

#pragma mark - Properties

//-(NSString *)detailName
//{
//    NSInteger selectedCount = [self selectedchildrenCount];
//    if(selectedCount > 0)
//    {
//        return [NSString stringWithFormat:@"%@ (%ld)",_detailName, (long)[self selectedchildrenCount]];
//    }
//    else
//    {
//        return _detailName;
//    }
//}

#pragma mark - Selection

//-(NSInteger)selectedchildrenCount
//{
//    if(self.children)
//    {
//        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(STFilterObject *evaluatedObject, NSDictionary *bindings) {
//            return evaluatedObject.isSelected;
//        }];
//        return [self.children filteredArrayUsingPredicate:predicate].count;
//    }
//    return -1;
//}

//-(void)setchildrenSelected:(BOOL)selected
//{
//    if(self.children)
//    {
//        for(STFilterObject *filterObject in self.children)
//        {
//            filterObject.selected = selected;
//            [filterObject setchildrenSelected:selected];
//        }
//    }
//}

//-(BOOL)isAnyRecordSelected
//{
//    if(self.children)
//    {
//        for(STFilterObject *filterObject in self.children)
//        {
//            if(filterObject.isSelected)
//            {
//                return YES;
//            }
//        }
//    }
//    return NO;
//}

//-(NSIndexSet *)indexesForSelectedRows
//{
//    NSMutableIndexSet *mutableIndexSet = [[NSMutableIndexSet alloc]init];
//    
//    if(self.children)
//    {
//        for(STFilterObject *filterObject in self.children)
//        {
//            if(filterObject.isSelected)
//            {
//                [mutableIndexSet addIndex:[self.children indexOfObject:filterObject]];
//            }
//        }
//    }
//    
//    return mutableIndexSet;
//}

//-(NSArray *)selectedOptions {
//    
//    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
//    
//    if (self.children) {
//        
//        for (STFilterObject *filterObject in self.children) {
//
//            if (filterObject.isSelected) {
//                
//                if (filterObject.children && filterObject.children.count > 0) {
//                    NSArray *selectedchildren = [filterObject selectedOptions];
//                    [mutableArray addObject:selectedchildren];
//                }
//                else
//                {
//                    NSMutableArray *selectedObjectInfo = [NSMutableArray array];
//                    [selectedObjectInfo addObject:[filterObject recordName]];
//                    if (filterObject.categoryIdentifier) {
//                        [selectedObjectInfo addObject:filterObject.categoryIdentifier];
//                    }
//                    if (filterObject.unqID) {
//                        [selectedObjectInfo addObject:filterObject.unqID];
//                    }
//                    [mutableArray addObject:[selectedObjectInfo copy]];
//                }
//            }
//        }
//        if(mutableArray.count == 0)
//        {
//            STFilterObject *firstSubRecord = self.children[(NSUInteger) self.defaultSelectedOptionIndex];
//            [mutableArray addObject:firstSubRecord.recordName];
//        }
//    }
//    return mutableArray;
//}

//-(BOOL)isSelected
//{
//    return self.children ? [self selectedchildrenCount] > 0 : _selected;
//}

#pragma mark - Init

//-(void)setDefaultSelectedOptionIndex:(NSInteger)defaultSelectedOptionIndex
//{
//    _defaultSelectedOptionIndex = defaultSelectedOptionIndex;
//    STFilterObject *filterObject = self.children[(NSUInteger)defaultSelectedOptionIndex];
//    filterObject.selected = YES;
//}

-(id)initWithDictionary:(NSDictionary *)data
{
    if(self = [super init])
    {
        self.navigationBarTitle = [data valueForKey:STFilterOptionTableViewCellTitleKey];
        self.recordName = [data valueForKey:STFilterOptionTableViewCellNameKey];
        self.detailName = [data valueForKey:STFilterOptionTableViewCellHintKey];
        
        NSMutableArray *mutableArray = [[NSMutableArray alloc]init];
        for(id item in [data valueForKey:STFilterOptionTableViewCellOptionsKey])
        {
            if([item isKindOfClass:[NSString class]])
            {
                [mutableArray addObject:[[BHTNestedSelectionCustomObject alloc]initWithRecordName:item]];
            }
            else if([item isKindOfClass:NSArray.class]) {
                BHTNestedSelectionCustomObject *filterObject = [[BHTNestedSelectionCustomObject alloc]initWithRecordName:item[1]];
                filterObject.parent = self;
                filterObject.categoryIdentifier = item[3];
                [mutableArray addObject:filterObject];
            }
            else if([item isKindOfClass:[NSDictionary class]])
            {
                [mutableArray addObject:[[BHTNestedSelectionCustomObject alloc]initWithDictionary:item]];
            }
        }
        if(mutableArray && mutableArray.count > 0)
        {
            self.children = mutableArray;
        }
    }
    
    return self;
}

-(id)initWithDictionary:(NSDictionary *)data andDefaultSelectedIndex:(NSInteger)index
{
    if(self = [self initWithDictionary:data])
    {
        self.defaultSelectedOptionIndex = index;
    }
    return self;
}

-(id)initWithRecordName:(NSString *)recordName
{
    if(self = [super init])
    {
        self.recordName = recordName;
    }
    return self;
}

-(id)initWithTitles:(NSArray *)titles
{
    if(self = [super init])
    {
        NSMutableArray *mutableArray = [[NSMutableArray alloc]init];
        for(NSString *title in titles)
        {
            [mutableArray addObject:[[BHTNestedSelectionCustomObject alloc]initWithRecordName:title]];
        }
        if(mutableArray.count > 0)
        {
            self.children = mutableArray;
        }
    }
    return self;
}

-(id)initWithTitles:(NSArray *)titles andDefaultSelectedIndex:(NSInteger)index
{
    if(self = [self initWithTitles:titles])
    {
        self.defaultSelectedOptionIndex = index;
    }
    return self;
}

@end
