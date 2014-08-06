//
//  STFilterObjectProtocol.h
//  Bond
//
//  Created by Bartek Hugo Trzcinski on 05/08/14.
//  Copyright (c) 2014 Untitled Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BHTNestedSelectionObjectProtocol <NSObject>

@property (strong, nonatomic, readonly) NSString *navigationBarTitle;
@property (strong, nonatomic, readonly) NSString *recordName;
@property (strong, nonatomic, readonly) NSString *detailName;

@property (strong, nonatomic, readonly) NSArray  *children; // array of objects conforming to BHTNestedSelectionObjectProtocol
@property (strong, nonatomic, readonly) id<BHTNestedSelectionObjectProtocol> parent;

@end
