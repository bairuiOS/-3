//
//  Recipes+CoreDataProperties.h
//  菜谱
//
//  Created by lanou3g on 15/10/10.
//  Copyright © 2015年 白蕊. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Recipes.h"

NS_ASSUME_NONNULL_BEGIN

@interface Recipes (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *albums;
@property (nullable, nonatomic, retain) NSString *burden;
@property (nullable, nonatomic, retain) NSString *idcid;
@property (nullable, nonatomic, retain) NSString *img;
@property (nullable, nonatomic, retain) NSString *imtro;
@property (nullable, nonatomic, retain) NSString *ingredients;
@property (nullable, nonatomic, retain) NSString *number;
@property (nullable, nonatomic, retain) NSString *step;
@property (nullable, nonatomic, retain) NSData *steps;
@property (nullable, nonatomic, retain) NSString *tags;
@property (nullable, nonatomic, retain) NSString *title;

@end

NS_ASSUME_NONNULL_END
