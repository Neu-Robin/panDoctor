//
//  SettingsViewController.m
//  Pan大夫
//
//  Created by zxy on 2/24/15.
//  Copyright (c) 2015 Neil. All rights reserved.
//

#import "SettingsViewController.h"
#import "LoginViewController.h"
#import "UserTableViewController.h"
@interface SettingsViewController ()


@property (strong, nonatomic) LoginViewController *loginView;
@property (strong, nonatomic) UserTableViewController *userTableView;
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UILabel *userLabel;
@end

@implementation SettingsViewController

@synthesize loginView;
@synthesize loginButton;
@synthesize userTableView;
@synthesize userLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    //使视图可滑动以避免键盘遮挡文本框

    
    //上方图像
    UIImage* userImage;
    if (FrameH > 319 && FrameH < 321) {
        userImage = [UIImage imageNamed:@"panda-4s.png"];
    }else{
        userImage = [UIImage imageNamed:@"panda.png"];
    }
    UIImageView* userImageView = [[UIImageView alloc] initWithImage:userImage];
   
    userImageView.frame = CGRectMake(0, 64, userImageW, userImageH);
    userLabel= [[UILabel alloc]initWithFrame:CGRectMake((userImageW - labelW)/2, 64 + userImageH - 1.8*labelH, labelW, labelH)];
    userTableView = [[UserTableViewController alloc]initWithFrame:CGRectMake(0, 64 + userImageH, [[UIScreen mainScreen]bounds].size.width,[[UIScreen mainScreen]bounds].size.height- userImageH -tableUp)];
    
    [self.view addSubview:userImageView];
    
    //登录显示
    userLabel.text = @"未登录";
    userLabel.textColor = [UIColor whiteColor];
    userLabel.font = [UIFont systemFontOfSize:loginFont];
    [self.view addSubview:userLabel];
    
    //下方表格
    [self.view addSubview:userTableView.tableView];
    userTableView.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1];

    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    //检查plist文件
//    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//    NSString *documentsDirectory =[paths objectAtIndex:0];
//    NSString *documentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"login.plist"];//plist文件位置
//    
//    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:documentPlistPath];
//    NSString *isLoggedIn = [plistDictionary objectForKey:@"login"];
//    NSLog(@"asd %@",isLoggedIn);
//    
//    //未登录
//    if ([isLoggedIn isEqualToString:@"no"])
//    {
//        if (loginView == nil) {
//            loginView = [[LoginViewController alloc]initWithNav:NO];
//            loginView.settingsView = self;
//            [self.view addSubview:loginView.view];
    
            
            //            loginView.title = @"登录";
            //            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginView];
            //            nav.navigationBar.barTintColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
            //            nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:0/255.0 green:175/255.0 blue:170/255.0 alpha:1.0],NSFontAttributeName : [UIFont boldSystemFontOfSize:28]};
            //            [self.navigationController presentViewController:nav animated:YES completion:^(void){}];
            
//        }
//    }
//    
//    //已登录
//    else
//    {
        [self userDidLogin:@"yes"];
 //   }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  用户成功登录时执行，改变UI
 */
- (void)userDidLogin:(NSString*)IDNum{
    userLabel.text = @"";
    userLabel.frame = CGRectMake((userImageW - labelWL)/2, 64 + userImageH - 1.8*labelH, labelWL, labelH);
    userLabel.font = [UIFont systemFontOfSize:telFont];
}

@end
