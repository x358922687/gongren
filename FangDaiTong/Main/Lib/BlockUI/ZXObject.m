//
//  BUIView.m
//  sample
//
//  Created by 张玺 on 12-9-10.
//  Copyright (c) 2012年 张玺. All rights reserved.
//

#import "ZXObject.h"
#import <objc/runtime.h>

@implementation NSObject(ZXObject)

+(void)perform:(void(^)())block1 withCompletionHandler:(void (^)())block2
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        block1();
        dispatch_async(dispatch_get_main_queue(),^{
            block2();
        });
    });
}
-(void)perform:(void(^)())block1 withCompletionHandler:(void (^)())block2
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        block1();
        dispatch_async(dispatch_get_main_queue(),^{
            block2();
        });
    });
}
+ (void)perform:(void(^)())block afterDelay:(NSTimeInterval)delay
{
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(when,
                   dispatch_get_main_queue(),
                   block);
}
- (void)perform:(void(^)())block afterDelay:(NSTimeInterval)delay
{
    [[self class] perform:block afterDelay:delay];
}

//======================

const char ZXObjectStoreKey;
-(void)setZXObject:(id)obj
{
    objc_setAssociatedObject(self, &ZXObjectStoreKey, obj, OBJC_ASSOCIATION_COPY);
}
-(id)getZXObject
{
    return objc_getAssociatedObject(self, &ZXObjectStoreKey);
}
//=======================

const char ZXObjectDefaultEvent;
-(void)handlerDefaultEventwithBlock:(id)block
{
    objc_setAssociatedObject(self, &ZXObjectDefaultEvent, block, OBJC_ASSOCIATION_COPY);
}
-(id)blockForDefaultEvent
{
    return objc_getAssociatedObject(self,&ZXObjectDefaultEvent);
}
- (void)callBlockForDefaultEvent
{
    dispatch_block_t block = [self blockForDefaultEvent];
    if (block) {
        block();
    }
}
const char ZXObjectSingleObjectEvent;
-(void)receiveObject:(void(^)(id object))sendObject
{
    objc_setAssociatedObject(self,
                             &ZXObjectSingleObjectEvent,
                             sendObject,
                             OBJC_ASSOCIATION_COPY);
}
-(void)sendObject:(id)object
{
    void(^block)(id object) = objc_getAssociatedObject(self,&ZXObjectSingleObjectEvent);
    if(block != nil) block(object);
}
          
@end
