//
//  ImageDataParam.h
//  BankApp
//
//  Created by yhj on 17/3/23.
//  Copyright © 2017年 QDPCI. All rights reserved.
//

//上传图片model

#import <Foundation/Foundation.h>

@interface ImageDataParam : NSObject
/**
 *  上传文件的二进制数据
 */
@property (nonatomic, strong) NSData *data;
/**
 *  上传的参数名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  上传到服务器的文件名称
 */
@property (nonatomic, copy) NSString *fileName;

/**
 *  上传文件的类型
 */
@property (nonatomic, copy) NSString *mimeType;
@end
