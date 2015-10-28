//
//  CollectTVC.m
//  菜谱
//
//  Created by lanou3g on 15/10/10.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import "CollectTVC.h"
#import "AppDelegate.h"
#import "DrawerViewController.h"
#import "Recipes.h"

#import "Recipe.h"
#import "RecipeViewCell.h"
#import "RecipeViewController.h"
#import "RecipeDetailViewController.h"



#import "UIImageView+WebCache.h"
@interface CollectTVC ()

@property (nonatomic, strong) NSManagedObjectContext *context;

@property (nonatomic, strong) NSMutableArray *allDataArray;

@property (nonatomic, strong) RecipeDetailViewController *recipeDetail;

@property(nonatomic,strong)AppDelegate *appDelegate;

@end

@implementation CollectTVC

- (NSManagedObjectContext *)context
{
    if (!_context) {
        _context = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
        return _context;
    }
    return _context;
}




- (void)viewDidLoad {
    [super viewDidLoad];

    
    //设置navigationbar  的颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    //设置title的颜色
    UIColor * color = [UIColor lightGrayColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    

    
    self.appDelegate = [UIApplication sharedApplication].delegate;
    self.allDataArray = [NSMutableArray array];
    [self readFromDataBase];
    self.title = @"我的收藏";
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清空" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemAction:)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-daohangliebiao"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction:)];
    
    
    
    //设置背景图片
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"allbackground.png"]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2]];
    [self.tableView setBackgroundView:backImage];
    

    
}

#pragma mark - leftBarButtonItem触发左抽屉效果
- (void)leftBarButtonItemAction:(UIBarButtonItem *)sender
{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    DrawerViewController *sideViewController = [delegate sideViewController];
    [sideViewController showLeftViewController:true];
    
}

#pragma mark 清空的方法
- (void)rightBarButtonItemAction:(UIBarButtonItem *)sender
{

    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否清空所有收藏" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
    
        
        for (Recipes *recipes in _allDataArray) {
            
            [self.context deleteObject:recipes];
            
        }
        _allDataArray = nil;
        
        [self.tableView reloadData];
    
        
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    [alertC addAction:action1];
    
    [alertC addAction:action2];
    
    
    [self presentViewController:alertC animated:YES completion:^{
        
        
    }];
    

    
    }


#pragma mark - 从数据库读取文件
- (void)readFromDataBase
{
//    //创建数据请求
//    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Recipes"];
//    
//    //取出所有属性，再通过kvc赋值给模型
//    [request setReturnsObjectsAsFaults:NO];
//    
//    //根据请求获取数据
//    NSError *error2;
//    
//    NSArray *dataArray = [self.context executeFetchRequest:request error:&error2];
//    
//    self.allDataArray = [NSMutableArray arrayWithArray:dataArray];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Recipes" inManagedObjectContext:self.appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title like %@", @"*"];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"%@",error);
    }
    self.allDataArray = [NSMutableArray arrayWithArray:fetchedObjects];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _allDataArray.count;
    
    
}


//生成cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RecipeViewCell" bundle:nil] forCellReuseIdentifier:@"RecipeCell"];
    Recipes *recipes = _allDataArray[indexPath.row];
    
    RecipeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell" forIndexPath:indexPath];
    
    cell.recipeName.text = recipes.title;
    
    //图片赋值
    //反归档
   NSArray *albums = [NSKeyedUnarchiver unarchiveObjectWithData:recipes.albums];
    
    
    [cell.recipeImage sd_setImageWithURL:[NSURL URLWithString:albums[0]] placeholderImage:[UIImage imageNamed:@"18.png"]];
    [cell.tinyImage sd_setImageWithURL:[NSURL URLWithString:albums[0]] placeholderImage:[UIImage imageNamed:@"18.png"]];
    cell.tinyImage.layer.cornerRadius = 30;
    cell.tinyImage.layer.masksToBounds = YES;
    cell.tinyImage.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.tinyImage.layer.borderWidth = 2;
    
    //改变cell 的透明度
    cell.opaque = NO;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    [cell setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2]];
    

    
    return cell;
}
//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.recipeDetail = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RecipeDetail"];
    Recipes *re = _allDataArray[indexPath.row];
    Recipe *newRecipe = [Recipe new];
    newRecipe.title = re.title;
    newRecipe.albums = [NSKeyedUnarchiver unarchiveObjectWithData:re.albums];
    newRecipe.burden = re.burden;
    newRecipe.idcid = re.idcid;
    newRecipe.img = re.img;
    newRecipe.imtro = re.imtro;
    newRecipe.ingredients = re.ingredients;
    newRecipe.step = re.step;
    newRecipe.steps = [NSKeyedUnarchiver unarchiveObjectWithData:re.steps];
    
    
    newRecipe.tags = re.tags;

    self.recipeDetail.recipe = newRecipe;
    
    
    
    [self.navigationController pushViewController:_recipeDetail animated:YES];
    self.recipeDetail.navigationController.navigationBar.translucent=NO;
    
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 140;
}



//1.让table处于编辑状态
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    
    [self.tableView setEditing:editing animated:animated];
    
}

//2.设置某一行是否可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}
//3.设置编辑风格
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}
//4.编辑完成
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.appDelegate.managedObjectContext deleteObject:_allDataArray[indexPath.row]];
    [_allDataArray removeObjectAtIndex:indexPath.row];
    
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationLeft)];
    [self.appDelegate saveContext];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
