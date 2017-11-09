//
//  YSCollectionView.h
//  BankApp
//
//  Created by yhj on 17/4/13.
//  Copyright © 2017年 QDPCI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSCollectionView : UIView

@property (nonatomic, strong) NSArray *newsArr;
@property (nonatomic, copy) SendBlock selectBlock;
@property (nonatomic, assign) BOOL isIndexBool;

@end
