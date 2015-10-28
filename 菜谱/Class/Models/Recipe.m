//
//  Recipe.m
//  菜谱
//
//  Created by lanou3g on 15/10/5.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import "Recipe.h"
#import "StepModel.h"
@implementation Recipe

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        self.idcid = value;
    }
    
    
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"steps"]) {
        _steps = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            StepModel *step = [StepModel new];
            [step setValuesForKeysWithDictionary:dic];
            [_steps addObject:step];
            
        }
        return;
    }else if ([key isEqualToString:@"idcid"])
    {
        self.idcid = [NSString stringWithFormat:@"%@",value];
    }
    
    [super setValue:value forKey:key];
}


@end
