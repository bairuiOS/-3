//
//  SortDetailCollection.h
//  菜谱
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sort.h"

@interface SortDetailCollection : UICollectionViewController

@property(nonatomic,strong) Sort *sort;
@property(nonatomic,strong) NSMutableArray *sortArray;

@end
