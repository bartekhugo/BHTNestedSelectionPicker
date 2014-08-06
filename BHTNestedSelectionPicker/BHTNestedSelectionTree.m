//
//  STFFilterSelection.m
//  MultipleSelectionTableView
//
//  Created by Bartek Hugo Trzcinski on 06/08/14.
//  Copyright (c) 2014 Bartek Hugo Trzcinski. All rights reserved.
//

#import "BHTNestedSelectionTree.h"
#import <JTTree/JTTree.h>

//TODO: optimize to dont search in levels below desired object level

@interface BHTNestedSelectionTree ()

@property (nonatomic, strong, readwrite) JTTree *rootNode;

@end

@implementation BHTNestedSelectionTree

- (NSArray *)selectedLeafObjects
{
    __block NSMutableArray *flatObjects = [NSMutableArray array];
    
    void (^enumerationBlock)(JTTree *descendant, BOOL *stop) = ^(JTTree *descendant, BOOL *stop) {
        if (descendant.isLeaf && descendant.object)
            [flatObjects addObject:descendant.object];
    };
    
    [self.rootNode enumerateDescendantsWithOptions:JTTreeTraversalDepthFirstPreOrder
                                        usingBlock:enumerationBlock];
    
    return [flatObjects copy];
}


- (void)toggleObjectSelection:(id<BHTNestedSelectionObjectProtocol>)object
{
    if (!object) return;
    
    JTTree *treeNode = [self treeNodeWithObject:object];
    
    if (treeNode)
    {
        [self removeTreeNode:treeNode];
    }
    else
    {
        [self treeNodeForObject:object recursiveChildren:YES];
    }
}

- (void)removeTreeNode:(JTTree *)treeNode
{
    JTTree *parentTreeNode = treeNode.parent;
    [treeNode removeFromParent];

    if (parentTreeNode.object && !parentTreeNode.numberOfChildren)
    {
        [self removeTreeNode:parentTreeNode];
    }
}

- (JTTree *)treeNodeForObject:(id<BHTNestedSelectionObjectProtocol>)object recursiveChildren:(BOOL)recursive
{
    JTTree *objectTreeNode = [self treeNodeWithObject:object];
    
    if (recursive)
    {
        for (id<BHTNestedSelectionObjectProtocol> child in object.children)
        {
            JTTree *childTreeNode = [self treeNodeForObject:child
                                          recursiveChildren:recursive];

            [objectTreeNode insertChild:childTreeNode atIndex:0];
        }
    }
    
    [self addObjectRecursivelyToTree:object andChildNode:nil];
    
    
    return objectTreeNode;
}

- (JTTree *)rootNode
{
    if (!_rootNode)
    {
        JTTree *node = [[JTTree alloc] init];
        _rootNode = node;
    }
    return _rootNode;
}

//TODO: keep selected object also in NSSet to improve performance when checing if selected
- (BOOL)isObjectSelected:(id<BHTNestedSelectionObjectProtocol>)object
{
    return [self treeNodeWithObject:object] != nil;
}

- (void)addObjectRecursivelyToTree:(id<BHTNestedSelectionObjectProtocol>)object andChildNode:(JTTree *)child
{
    if (!object)
    {
        if (child)
            [self.rootNode insertChild:child atIndex:0];
        return;
    }
    
    JTTree *treeNode = [self treeNodeWithObject:object];

    if (!treeNode)
        treeNode = [JTTree treeWithObject:object];
    
    //TODO: will go up unitl it will find root object - unnecessery (re-adding existing nodes)
    if (child)
        [treeNode insertChild:child atIndex:0];
    
    [self addObjectRecursivelyToTree:object.parent andChildNode:treeNode];
}

- (JTTree *)treeNodeWithObject:(id<BHTNestedSelectionObjectProtocol>)object
{
    __block JTTree *treeNode;
    
    [self.rootNode enumerateDescendantsWithOptions:JTTreeTraversalBreadthFirst
                                        usingBlock:^(JTTree *descendant, BOOL *stop) {

                                            id<BHTNestedSelectionObjectProtocol> nodeObject = descendant.object;
                                            
                                            if ([nodeObject isEqual:object])
                                            {
                                                treeNode = descendant;
                                                *stop = YES;
                                            }
                                        }];
    return treeNode;
}

@end
