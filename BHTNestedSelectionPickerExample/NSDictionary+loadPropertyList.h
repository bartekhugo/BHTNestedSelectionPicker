//
//  NSDictionary+loadPropertyList.h
//  Bond
//
//  Created by Paweł Sporysz on 28.07.2014.
//  Copyright (c) 2014 Untitled Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (loadPropertyList)

+(id)dictionaryFromPropertyListWithName:(NSString*)pListName;

@end
