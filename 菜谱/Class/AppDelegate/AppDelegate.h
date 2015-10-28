//
//  AppDelegate.h
//  菜谱
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 白蕊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DrawerViewController.h"
#import "RootTBC.h"
#import "RecipeViewController.h"

#import "SortedRecipeViewController.h"

#import "SearchCollectionCell.h"

#import "SearchRecipeViewController.h"

@class leftTBC;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property(nonatomic,strong)DrawerViewController *sideViewController;

@property(nonatomic,strong) RecipeViewController *recipeVC;
@property(nonatomic,strong) RootTBC *rootTBC;
@property(nonatomic,strong) SortedRecipeViewController *sortVC;
@property(nonatomic,strong) SearchRecipeViewController *searchVC;

@property (nonatomic,strong)leftTBC *leftTbc;

@end

