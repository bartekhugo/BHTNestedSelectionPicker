//
//  STFilterObject.h
//  Bond
//
//  Created by Paweł Sporysz on 29.07.2014.
//  Copyright (c) 2014 Untitled Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BHTNestedSelectionObjectProtocol.h"

@interface BHTNestedSelectionCustomObject : NSObject <BHTNestedSelectionObjectProtocol>

@property (nonatomic, getter = isSelected) BOOL selected;
@property (nonatomic, readonly) NSInteger defaultSelectedOptionIndex;
@property(nonatomic, copy) NSString *categoryIdentifier;
@property(nonatomic, copy) NSNumber *unqID;


-(id)initWithDictionary:(NSDictionary*)data;
-(id)initWithTitles:(NSArray*)titles;
-(id)initWithDictionary:(NSDictionary *)data andDefaultSelectedIndex:(NSInteger)index;
-(id)initWithTitles:(NSArray*)titles andDefaultSelectedIndex:(NSInteger)index;

//- (instancetype)initWitRecentPlaces:(NSArray *)recentPlaces;

//- (NSInteger)selectedchildrenCount;
//- (void)setchildrenSelected:(BOOL)selected;
//- (BOOL)isAnyRecordSelected;
//- (NSIndexSet*)indexesForSelectedRows;
//- (NSArray*)selectedOptions;

@end
