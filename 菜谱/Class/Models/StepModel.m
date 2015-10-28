//
//  StepModel.m
//  菜谱
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import "StepModel.h"
#import "NSObject+NSCoding.h"
@implementation StepModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [self autoEncodeWithCoder:aCoder];
}
//归档
-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    if (self) {
        
        [self autoDecode:aDecoder];
    }
    return self;
}

@end
