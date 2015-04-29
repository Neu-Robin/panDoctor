//
//  SettingsViewController.m
//  Pan大夫
//
//  Created by zxy on 2/24/15.
//  Copyright (c) 2015 Neil. All rights reserved.
//

#import "SettingsViewController.h"
#import "UserTableViewController.h"
#import "MyScrollView.h"
#import "TestViewController.h"

@interface SettingsViewController ()


@property (strong, nonatomic) UserTableViewController *userTableView;
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UILabel *userLabel;
@property (nonatomic, strong) NSArray  *imageArray;
@property (nonatomic, strong) MyScrollView *myScrollView;
@property(nonatomic) int firstLoad;

@end

@implementation SettingsViewController

@synthesize loginButton;
@synthesize userTableView;
@synthesize userLabel;
@synthesize imageArray;
@synthesize myScrollView;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //下方表格
    userTableView = [[UserTableViewController alloc]initWithFrame:CGRectMake(0, 64 + userImageH, [[UIScreen mainScreen]bounds].size.width,[[UIScreen mainScreen]bounds].size.height- userImageH -tableUp)];
    [self.view addSubview:userTableView.tableView];
    userTableView.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1];

    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
}


-(void)pushNavigationController
{
    int index = self.myScrollView.contentOffset.x / userImageW;
    if (index + 2 - self.myScrollView.contentSize.width/userImageW >= 0) {
        index = index + 2 - self.myScrollView.contentSize.width/userImageW;
    }   //此时的index对应myscrollView 中第index张图片，从0开始计算
    
    TestViewController *testViewController = [[TestViewController alloc]init];
    [testViewController setIndex:index];
    [myScrollView endTimer];
    [self.navigationController pushViewController:testViewController animated:YES];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (_firstLoad == 0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        imageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"introduction"], [UIImage imageNamed:@"question"],[UIImage imageNamed:@"report"],nil];
        myScrollView = [[MyScrollView alloc]initWithFrame:CGRectMake(0, 64, userImageW, userImageH) ImageArray:imageArray isURL:NO TimeInterval:3.0];
        [myScrollView setPageControlWithFrame:CGRectMake(0, scrollY+64 , scrollW, scrollH)];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushNavigationController)];
        singleTap.numberOfTapsRequired = 1;
        [myScrollView addGestureRecognizer:singleTap];
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
        doubleTap.numberOfTapsRequired = 2;
        [singleTap requireGestureRecognizerToFail:doubleTap];
        [myScrollView addGestureRecognizer:doubleTap];
        
        [self.view addSubview:myScrollView];
        _firstLoad++;
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
