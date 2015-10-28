//
//  User.m
//  菜谱
//
//  Created by lanou3g on 15/10/8.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import "User.h"
#import "AppDelegate.h"
#import "DrawerViewController.h"


@interface User ()

@end

@implementation User

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置navigationbar  的颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    //设置title的颜色
    UIColor * color = [UIColor lightGrayColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    

    self.title = @"关于我们";
    
    
    
    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, [UIScreen mainScreen].bounds.size.width-40, 100)];
    
    self.view.backgroundColor= [UIColor whiteColor];
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backImage.image = [UIImage imageNamed:@"allbackground.png"];
    [self.view addSubview:backImage];
    
    la.text = @"       本App由白蕊开发,如果任何疑问或者问题。请联系邮箱：15832616936@163.com";
    la.numberOfLines = 0;
    la.textColor = [UIColor whiteColor];
    la.font = [UIFont systemFontOfSize:18.0];
    
    [self.view addSubview:la];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-daohangliebiao"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction:)];

    
}


#pragma mark - leftBarButtonItem触发左抽屉效果
- (void)leftBarButtonItemAction:(UIBarButtonItem *)sender
{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    DrawerViewController *sideViewController = [delegate sideViewController];
    [sideViewController showLeftViewController:true];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
