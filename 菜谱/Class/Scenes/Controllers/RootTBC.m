//
//  RootTBC.m
//  菜谱
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 白蕊. All rights reserved.
//

#import "RootTBC.h"
#import "DrawerViewController.h"
#import "AppDelegate.h"


@interface RootTBC ()

@end

@implementation RootTBC

- (void)viewDidLoad {
    [super viewDidLoad];
    //leftbar
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-daohangliebiao.png"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction:)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    
    
    
    
}

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
