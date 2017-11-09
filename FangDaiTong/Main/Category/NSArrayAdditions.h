//
//  NSArrayAdditions.h
//  SendHome
//
//  Created by 李军 on 15/8/11.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

//防止数组调用[@"key"]崩溃
@interface NSArray(exception)
- (id)objectForKey:(NSString *)key;
- (id)objectForKeyedSubscript:(id)key;
@end

@interface NSMutableArray (reverse)

-(void) reverseArray;

@end

