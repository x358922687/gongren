//
//  ImageDataParam.m
//  BankApp
//
//  Created by yhj on 17/3/23.
//  Copyright © 2017年 QDPCI. All rights reserved.
//

#import "ImageDataParam.h"

@implementation ImageDataParam


- (NSString *)name
{
    if (_name.length == 0) {
        _name = @"testImage[]";
    }
    return _name;
}

- (NSString *)mimeType
{
    if (_mimeType.length == 0) {
        _mimeType = @"image/jpeg";
    }
    return _mimeType;
}
@end
