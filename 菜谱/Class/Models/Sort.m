//
//  Sort.m
//  菜谱
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import "Sort.h"
#import "SortDetail.h"
@implementation Sort

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
    
}

- (void)setValue:(id)value forKey:(NSString *)key{
    
    [_list removeAllObjects];
    if ([key isEqualToString:@"list"]) {
        
        _list = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            
            SortDetail *sort = [SortDetail new];
            
            [sort setValuesForKeysWithDictionary:dic];
            
            [_list addObject:sort];
            
        }
        
        return;
    }
    
    [super setValue:value forKey:key];
}


@end
