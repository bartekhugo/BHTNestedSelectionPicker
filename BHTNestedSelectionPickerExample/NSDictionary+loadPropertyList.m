//
//  NSDictionary+loadPropertyList.m
//  Bond
//
//  Created by Paweł Sporysz on 28.07.2014.
//  Copyright (c) 2014 Untitled Kingdom. All rights reserved.
//

#import "NSDictionary+loadPropertyList.h"

@implementation NSDictionary (loadPropertyList)

+(id)dictionaryFromPropertyListWithName:(NSString *)pListName
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:pListName ofType:@"plist"];
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSDictionary *dic = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML
                                                                         mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                                                                   format:&format
                                                                         errorDescription:&errorDesc];
    return dic;
}

@end
