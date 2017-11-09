//
//  NSArrayAdditions.m
//  SendHome
//
//  Created by 李军 on 15/8/11.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NSArrayAdditions.h"

@implementation NSArray(exception)

- (id)objectForKey:(NSString *)key
{
    return nil;
}
- (id)objectForKeyedSubscript:(id)key
{
    return nil;
}
@end

@implementation NSMutableArray (reverse)

-(void) reverseArray
{
    if( [self count] > 0 )
    {
        int i = 0;
        int j = (int)[self count]  - 1;
        while( i < j )
        {
            [self exchangeObjectAtIndex:i withObjectAtIndex:j];
            i++;
            j--;
        }
    }
}

@end
