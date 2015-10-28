//
//  Search.h
//  菜谱
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Search : NSObject


@property(nonatomic,strong) NSString *title;//菜名
@property(nonatomic,strong) NSArray *albums;//图片名

@property(nonatomic,assign) NSString *idcid;//id
@property(nonatomic,strong) NSString *tags;//标签
@property(nonatomic,strong) NSString *imtro;//介绍
@property(nonatomic,strong) NSString *ingredients;//食材
@property(nonatomic,strong) NSString *burden;//佐料

@property(nonatomic,strong) NSMutableArray *steps;
@property(nonatomic,strong) NSString *img;//步骤图片
@property(nonatomic,strong) NSString *step;//步骤



@end
