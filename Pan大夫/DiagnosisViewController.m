//
//  DiagnosisViewController.m
//  心理助手
//
//  Created by tiny on 15/1/25.
//  Copyright (c) 2015年 tiny. All rights reserved.
//

#import "DiagnosisViewController.h"
#import "CoreDataManager.h"
#import "Question.h"

#import "testAnalysisViewController.h"


#define KDeviceWidth [[UIScreen mainScreen]bounds].size.width
@interface DiagnosisViewController ()

@property (strong , nonatomic) CoreDataManager *manager;

@property (strong , nonatomic) UITableView *table;

@property (strong , nonatomic) UIView *viewLeft;
@property (strong , nonatomic) UIView *viewRight;

@property (strong , nonatomic) UIImageView *bt1;
@property (strong , nonatomic) UIImageView *bt2;
@property (strong , nonatomic) UIImageView *bt3;

@property (strong, nonatomic)UIButton *buttonLeft;
@property (strong, nonatomic)UIButton *buttonRight;

@property (strong , nonatomic) NSString *choosedKind;
@property (strong , nonatomic) NSMutableArray *temp;
@property (strong , nonatomic) NSString *choosedSubKind;

@property(strong, nonatomic) testAnalysisViewController *result;

@property (strong , nonatomic) YiYuTestViewController *test;

@property CGRect viewFrame;
@property CGRect rightViewFrame;
@property CGRect leftViewFrame;

@property (nonatomic) BOOL isTableViewExisted;

@end

@implementation DiagnosisViewController
@synthesize manager,result;
@synthesize viewFrame,rightViewFrame,leftViewFrame;
@synthesize bt1,bt2,bt3;
@synthesize table;
@synthesize buttonLeft,buttonRight,test,choosedKind,temp,choosedSubKind;
@synthesize bottomSquare;
- (void)viewDidLoad {
    [super viewDidLoad];
    manager = [[CoreDataManager alloc]init];
    if ([[UIScreen mainScreen]bounds].size.height>479&&[[UIScreen mainScreen]bounds].size.height<481) {
        buttonLeft = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen]bounds].size.width/2, 40)];
        [buttonLeft setBackgroundImage:[UIImage imageNamed:@"icon_4s_press_left"] forState:UIControlStateNormal];
        [buttonLeft addTarget:self action:@selector(buttonLeftTouched) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonLeft];
        
        buttonRight = [[UIButton alloc]initWithFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width/2, 64, [[UIScreen mainScreen]bounds].size.width/2, 40)];
        [buttonRight setBackgroundImage:[UIImage imageNamed:@"icon_4s_unpress_right"] forState:UIControlStateNormal];
        [buttonRight addTarget:self action:@selector(buttonRightTouched) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.buttonRight];
    }
    else if([[UIScreen mainScreen]bounds].size.height>567&&[[UIScreen mainScreen]bounds].size.height<570){
        buttonLeft = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen]bounds].size.width/2, 44)];
        [buttonLeft setBackgroundImage:[UIImage imageNamed:@"icon_5s_press_left"] forState:UIControlStateNormal];
        [buttonLeft addTarget:self action:@selector(buttonLeftTouched) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonLeft];
        
        buttonRight = [[UIButton alloc]initWithFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width/2, 64, [[UIScreen mainScreen]bounds].size.width/2, 44)];
        [buttonRight setBackgroundImage:[UIImage imageNamed:@"icon_5s_unpress_right"] forState:UIControlStateNormal];
        [buttonRight addTarget:self action:@selector(buttonRightTouched) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.buttonRight];
    }
    else if ([[UIScreen mainScreen]bounds].size.height>666&&[[UIScreen mainScreen]bounds].size.height<670){
        buttonLeft = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen]bounds].size.width/2, 50)];
        [buttonLeft setBackgroundImage:[UIImage imageNamed:@"icon_6_press_left"] forState:UIControlStateNormal];
        [buttonLeft addTarget:self action:@selector(buttonLeftTouched) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonLeft];
        
        buttonRight = [[UIButton alloc]initWithFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width/2, 64, [[UIScreen mainScreen]bounds].size.width/2, 50)];
        [buttonRight setBackgroundImage:[UIImage imageNamed:@"icon_6_unpress_right"] forState:UIControlStateNormal];
        [buttonRight addTarget:self action:@selector(buttonRightTouched) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.buttonRight];
    }
    else{
        buttonLeft = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen]bounds].size.width/2, 56)];
        [buttonLeft setBackgroundImage:[UIImage imageNamed:@"icon_6_press_left"] forState:UIControlStateNormal];
        [buttonLeft addTarget:self action:@selector(buttonLeftTouched) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonLeft];
        
        buttonRight = [[UIButton alloc]initWithFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width/2, 64, [[UIScreen mainScreen]bounds].size.width/2, 56)];
        [buttonRight setBackgroundImage:[UIImage imageNamed:@"icon_6_unpress_right"] forState:UIControlStateNormal];
        [buttonRight addTarget:self action:@selector(buttonRightTouched) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.buttonRight];
    }

    viewFrame =  CGRectMake(0, 64+buttonLeft.frame.size.height, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64-49-buttonLeft.frame.size.height);
    rightViewFrame = CGRectMake([[UIScreen mainScreen] bounds].size.width,64+buttonRight.frame.size.height, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-(64+buttonRight.frame.size.height+49));
    leftViewFrame = CGRectMake(-[[UIScreen mainScreen] bounds].size.width,64+buttonRight.frame.size.height, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-(64+buttonRight.frame.size.height+49));
    
    self.viewLeft = [[UIView alloc]initWithFrame:viewFrame];//创建左侧视图
    self.viewRight = [[UIView alloc] initWithFrame:rightViewFrame];//创建右侧视图
    [self.view addSubview:self.viewLeft];
    [self.view addSubview:self.viewRight];//将左右视图加入到view中
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bt1Clicked:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bt2Clicked:)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bt3Clicked:)];

    if ([[UIScreen mainScreen]bounds].size.height>479&&[[UIScreen mainScreen]bounds].size.height<481) {
        CGRect pt1Frame = CGRectMake(0, 0, KDeviceWidth, self.viewLeft.frame.size.height/3);
        CGRect pt2Frame = CGRectMake(0, self.viewLeft.frame.size.height/3, KDeviceWidth, self.viewLeft.frame.size.height/3);
        CGRect pt3Frame = CGRectMake(0, 2*self.viewLeft.frame.size.height/3, KDeviceWidth, self.viewLeft.frame.size.height/3);

        bt1 = [[UIImageView alloc]initWithFrame:pt1Frame];
        bt1.image = [UIImage imageNamed:@"4s-抑郁"];
        bt1.tag = 1;
        [bt1 addGestureRecognizer:tap1];
        [bt1 setUserInteractionEnabled:YES];
        [self.view addSubview:bt1];
        
        bt2 = [[UIImageView alloc]initWithFrame:pt2Frame];
        bt2.image = [UIImage imageNamed:@"4s-焦虑"];
        bt2.tag = 2;
        [bt2 addGestureRecognizer:tap2];
        [bt2 setUserInteractionEnabled:YES];
        [self.view addSubview:bt2];
        
        bt3 = [[UIImageView alloc]initWithFrame:pt3Frame];
        bt3.image = [UIImage imageNamed:@"4s-SQL"];
        bt3.tag = 3;
        [bt3 addGestureRecognizer:tap3];
        [bt3 setUserInteractionEnabled:YES];
        [self.view addSubview:bt3];
    }
    else if([[UIScreen mainScreen]bounds].size.height>567&&[[UIScreen mainScreen]bounds].size.height<570){
        CGRect pt1Frame = CGRectMake(0, 0, KDeviceWidth, self.viewLeft.frame.size.height/3);
        CGRect pt2Frame = CGRectMake(0, self.viewLeft.frame.size.height/3, KDeviceWidth, self.viewLeft.frame.size.height/3);
        CGRect pt3Frame = CGRectMake(0, 2*self.viewLeft.frame.size.height/3, KDeviceWidth, self.viewLeft.frame.size.height/3);
        bt1 = [[UIImageView alloc]initWithFrame:pt1Frame];
        bt1.image = [UIImage imageNamed:@"5s-抑郁"];
        bt1.tag = 1;
        [bt1 addGestureRecognizer:tap1];
        [bt1 setUserInteractionEnabled:YES];
        [self.view addSubview:bt1];

        bt2 = [[UIImageView alloc]initWithFrame:pt2Frame];
        bt2.image = [UIImage imageNamed:@"5s-焦虑"];
        bt2.tag = 2;
        [bt2 addGestureRecognizer:tap2];
        [bt2 setUserInteractionEnabled:YES];
        [self.view addSubview:bt2];

        bt3 = [[UIImageView alloc]initWithFrame:pt3Frame];
        bt3.image = [UIImage imageNamed:@"5s-SQL"];
        bt3.tag = 3;
        [bt3 addGestureRecognizer:tap3];
        [bt3 setUserInteractionEnabled:YES];
        [self.view addSubview:bt3];


    }
    else if ([[UIScreen mainScreen]bounds].size.height>666&&[[UIScreen mainScreen]bounds].size.height<670){
        CGRect pt1Frame = CGRectMake(0, 0, KDeviceWidth, self.viewLeft.frame.size.height/3);
        CGRect pt2Frame = CGRectMake(0, self.viewLeft.frame.size.height/3, KDeviceWidth, self.viewLeft.frame.size.height/3);
        CGRect pt3Frame = CGRectMake(0, 2*self.viewLeft.frame.size.height/3, KDeviceWidth, self.viewLeft.frame.size.height/3);
      
        
        bt1 = [[UIImageView alloc]initWithFrame:pt1Frame];
        bt1.image = [UIImage imageNamed:@"6s-抑郁"];
        bt1.tag = 1;
        [bt1 addGestureRecognizer:tap1];
        [bt1 setUserInteractionEnabled:YES];
        [self.view addSubview:bt1];
        
        bt2 = [[UIImageView alloc]initWithFrame:pt2Frame];
        bt2.image = [UIImage imageNamed:@"6s-焦虑"];
        bt2.tag = 2;
        [bt2 addGestureRecognizer:tap2];
        [bt2 setUserInteractionEnabled:YES];
        [self.view addSubview:bt2];
        
        bt3 = [[UIImageView alloc]initWithFrame:pt3Frame];
        bt3.image = [UIImage imageNamed:@"6s-SQL"];
        bt3.tag = 3;
        [bt3 addGestureRecognizer:tap3];
        [bt3 setUserInteractionEnabled:YES];
        [self.view addSubview:bt3];
    }
    else{
        CGRect pt1Frame = CGRectMake(0, 0, KDeviceWidth, self.viewLeft.frame.size.height/3);
        CGRect pt2Frame = CGRectMake(0, self.viewLeft.frame.size.height/3, KDeviceWidth, self.viewLeft.frame.size.height/3);
        CGRect pt3Frame = CGRectMake(0, 2*self.viewLeft.frame.size.height/3, KDeviceWidth, self.viewLeft.frame.size.height/3);
        bt1 = [[UIImageView alloc]initWithFrame:pt1Frame];
        bt1.image = [UIImage imageNamed:@"6+-抑郁"];
        bt1.tag = 1;
        [bt1 addGestureRecognizer:tap1];
        [bt1 setUserInteractionEnabled:YES];
        [self.view addSubview:bt1];
        
        bt2 = [[UIImageView alloc]initWithFrame:pt2Frame];
        bt2.image = [UIImage imageNamed:@"6+-焦虑"];
        bt2.tag = 2;
        [bt2 addGestureRecognizer:tap2];
        [bt2 setUserInteractionEnabled:YES];
        [self.view addSubview:bt2];
        
        bt3 = [[UIImageView alloc]initWithFrame:pt3Frame];
        bt3.image = [UIImage imageNamed:@"6+-SQL"];
        bt3.tag = 3;
        [bt3 addGestureRecognizer:tap3];
        [bt3 setUserInteractionEnabled:YES];
        [self.view addSubview:bt3];
    }

    [self.viewLeft addSubview:bt1];
    [self.viewLeft addSubview:bt2];
    [self.viewLeft addSubview:bt3];
    
    bottomSquare = [[UIImageView alloc]initWithFrame:CGRectMake(0, buttonLeft.frame.origin.y+buttonLeft.frame.size.height-3, [[UIScreen mainScreen] bounds].size.width/2,3)];
    bottomSquare.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:bottomSquare];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *databaseFilePath = [documentDirectory stringByAppendingPathComponent:@"CoreDataQuestions"];
    NSLog(@"databse--->%@",databaseFilePath);

    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)bt1Clicked:(UITapGestureRecognizer *)recognizer{
    UIAlertView *willBeginSASTest = [[UIAlertView alloc]initWithTitle:@"您即将进行抑郁症自我测试" message:@"请根据近期情况准确回答，您的答案将被加密保存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"开始测试", nil];
    willBeginSASTest.tag = 1;
    [willBeginSASTest show];
}

-(void)bt2Clicked:(UITapGestureRecognizer *)recognizer{
    UIAlertView *willBeginSDSTest = [[UIAlertView alloc]initWithTitle:@"您即将进行焦虑症自我测试" message:@"请根据近期情况准确回答，您的答案将被加密保存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"开始测试", nil];
    willBeginSDSTest.tag = 2;
    [willBeginSDSTest show];
}

-(void)bt3Clicked:(UITapGestureRecognizer *)recognizer{
    UIAlertView *willBeginSCLTest = [[UIAlertView alloc]initWithTitle:@"您即将进行SCL90综合测试" message:@"请根据近期情况准确回答，您的答案将被加密保存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"开始测试", nil];
    willBeginSCLTest.tag = 3;
    [willBeginSCLTest show];
}




-(void)change1Color:(UITapGestureRecognizer *)recognizer{
    bt1.backgroundColor = [UIColor grayColor];
}
-(void)change2Color:(UITapGestureRecognizer *)recognizer{
    bt2.backgroundColor = [UIColor grayColor];
}
-(void)change3Color:(UITapGestureRecognizer *)recognizer{
    bt3.backgroundColor = [UIColor grayColor];
}


-(void)buttonRightTouched{
    UIImage *imageLeft = [[UIImage alloc]init];
    UIImage *imageRight = [[UIImage alloc]init];
    if ([[UIScreen mainScreen]bounds].size.height>479&&[[UIScreen mainScreen]bounds].size.height<481) {
        imageLeft = [UIImage imageNamed:@"icon_4s_unpress_left"];
        imageRight = [UIImage imageNamed:@"icon_4s_press_right"];
    }
    else if([[UIScreen mainScreen]bounds].size.height>567&&[[UIScreen mainScreen]bounds].size.height<570){
        imageLeft = [UIImage imageNamed:@"icon_5s_unpress_left"];
        imageRight = [UIImage imageNamed:@"icon_5s_press_right"];
    }
    else{
        imageLeft = [UIImage imageNamed:@"icon_6_unpress_left"];
        imageRight = [UIImage imageNamed:@"icon_6_press_right"];
    }
    [self.buttonLeft setBackgroundImage:imageLeft forState:UIControlStateNormal];
    [self.buttonRight setBackgroundImage:imageRight forState:UIControlStateNormal];
    if (!self.isTableViewExisted) {
        table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen] bounds].size.height-(64+buttonRight.frame.size.height+49))];
        table.delegate = self;
        table.dataSource = self;
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.viewRight addSubview:table];
        self.isTableViewExisted = YES;
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    bottomSquare.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2,buttonLeft.frame.origin.y+buttonLeft.frame.size.height-3, [[UIScreen mainScreen] bounds].size.width/2,3);
    self.viewRight.frame = viewFrame;
    [UIImageView commitAnimations];
    
    self.viewLeft.frame = leftViewFrame;
    
}

-(void)buttonLeftTouched{
    UIImage *imageLeft = [[UIImage alloc]init];
    UIImage *imageRight = [[UIImage alloc]init];
    if ([[UIScreen mainScreen]bounds].size.height>479&&[[UIScreen mainScreen]bounds].size.height<481) {
        imageLeft = [UIImage imageNamed:@"icon_4s_press_left"];
        imageRight = [UIImage imageNamed:@"icon_4s_unpress_right"];
    }
    else if([[UIScreen mainScreen]bounds].size.height>567&&[[UIScreen mainScreen]bounds].size.height<570){
        imageLeft = [UIImage imageNamed:@"icon_5s_press_left"];
        imageRight = [UIImage imageNamed:@"icon_5s_unpress_right"];
    }
    else{
        imageLeft = [UIImage imageNamed:@"icon_6_press_left"];
        imageRight = [UIImage imageNamed:@"icon_6_unpress_right"];
    }
    [self.buttonLeft setBackgroundImage:imageLeft forState:UIControlStateNormal];
    [self.buttonRight setBackgroundImage:imageRight forState:UIControlStateNormal];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    bottomSquare.frame = CGRectMake(0,buttonLeft.frame.origin.y+buttonLeft.frame.size.height-3, [[UIScreen mainScreen] bounds].size.width/2,3);
    self.viewLeft.frame = viewFrame;
    [UIView commitAnimations];
    self.viewRight.frame = rightViewFrame;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex    //设置每个section的cell个数
{
    if ([[UIScreen mainScreen] bounds].size.height < 568){
        return 7;
    }
    else{
        return 9;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }

    if ([[UIScreen mainScreen] bounds].size.height < 568) {//适配4s的屏幕
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"\t腹痛腹泻，呼吸困难，身体酸痛";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"4s-frame1"]]];
                break;
            case 1:
                cell.textLabel.text = @"\t无法摆脱无意义的行为，思想";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"4s-frame2"]]];
                break;
            case 2:
                cell.textLabel.text = @"\t自卑，不自在，消极期待";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"4s-frame3"]]];
                break;
            case 3:
                cell.textLabel.text = @"\t心情苦闷，悲观，想自杀";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"4s-frame4"]]];
                break;
            case 4:
                cell.textLabel.text = @"\t烦躁不安，神经过敏，紧张";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"4s-frame5"]]];
                break;
            case 5:
                cell.textLabel.text = @"\t厌烦感强，不可控的脾气暴发";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"4s-frame6"]]];
                break;
            case 6:
                cell.textLabel.text = @"\t害怕某个特定场所和物体";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"4s-frame7"]]];
                break;
            default:
                break;
        }
    }
    else if([[UIScreen mainScreen]bounds].size.height>=568&&[[UIScreen mainScreen]bounds].size.height<570){//适配iphone5之后的机型
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"\t腹痛腹泻，呼吸困难，头晕眼花";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"5s-frame1"]]];
                break;
            case 1:
                cell.textLabel.text = @"\t头、背、躯干疼痛，肌肉酸痛";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"5s-frame2"]]];
                break;
            case 2:
                cell.textLabel.text = @"\t无法摆脱无意义行为，思想，冲动";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"5s-frame3"]]];
                break;
            case 3:
                cell.textLabel.text = @"\t自卑，不自在，心神不安，消极";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"5s-frame4"]]];
                break;
            case 4:
                cell.textLabel.text = @"\t心情苦闷，悲观失望，想自杀";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"5s-frame5"]]];
                break;
            case 5:
                cell.textLabel.text = @"\t烦躁，坐立不安，神经过敏，紧张";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"5s-frame6"]]];
                break;
            case 6:
                cell.textLabel.text = @"\t厌烦感强，不可控的脾气暴发";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"5s-frame7"]]];
                break;
            case 7:
                cell.textLabel.text = @"\t害怕某个特定场所、物体或事情";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"5s-frame8"]]];
                break;
            case 8:
                cell.textLabel.text = @"\t猜疑心重，妄想，夸大被动体验";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"5s-frame9"]]];
                break;
            default:
                break;
        }
    }
    else if([[UIScreen mainScreen]bounds].size.height>=667&&[[UIScreen mainScreen]bounds].size.height<669){
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"\t  腹痛腹泻，呼吸困难，头晕眼花";
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"6-frame1"]]];
                break;
            case 1:
                cell.textLabel.text = @"\t  头、背、躯干疼痛，肌肉酸痛";
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"6-frame2"]]];
                break;
            case 2:
                cell.textLabel.text = @"\t  无法摆脱无意义行为，思想，冲动";
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"6-frame3"]]];
                break;
            case 3:
                cell.textLabel.text = @"\t  自卑，不自在，心神不安，消极";
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"6-frame4"]]];
                break;
            case 4:
                cell.textLabel.text = @"\t  心情苦闷，悲观失望，想自杀";
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"6-frame5"]]];
                break;
            case 5:
                cell.textLabel.text = @"\t  烦躁，坐立不安，神经过敏，紧张";
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"6-frame6"]]];
                break;
            case 6:
                cell.textLabel.text = @"\t  厌烦感强，不可控的脾气暴发";
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"6-frame7"]]];
                break;
            case 7:
                cell.textLabel.text = @"\t  害怕某个特定场所、物体或事情";
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"6-frame8"]]];
                break;
            case 8:
                cell.textLabel.text = @"\t  猜疑心重，妄想，夸大被动体验";
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"6-frame1"]]];
                break;
            default:
                break;
        }
    }
    else{
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"\t  腹痛腹泻，呼吸困难，头晕眼花";
                cell.textLabel.font = [UIFont systemFontOfSize:18];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"6s-frame1"]]];
                break;
            case 1:
                cell.textLabel.text = @"\t  头、背、躯干疼痛，肌肉酸痛";
                cell.textLabel.font = [UIFont systemFontOfSize:18];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"6s-frame2"]]];
                break;
            case 2:
                cell.textLabel.text = @"\t  无法摆脱无意义行为，思想，冲动";
                cell.textLabel.font = [UIFont systemFontOfSize:18];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"6s-frame3"]]];
                break;
            case 3:
                cell.textLabel.text = @"\t  自卑，不自在，心神不安，消极";
                cell.textLabel.font = [UIFont systemFontOfSize:18];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"6s-frame4"]]];
                break;
            case 4:
                cell.textLabel.text = @"\t  心情苦闷，悲观失望，想自杀";
                cell.textLabel.font = [UIFont systemFontOfSize:18];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"6s-frame5"]]];
                break;
            case 5:
                cell.textLabel.text = @"\t  烦躁，坐立不安，神经过敏，紧张";
                cell.textLabel.font = [UIFont systemFontOfSize:18];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"6s-frame6"]]];
                break;
            case 6:
                cell.textLabel.text = @"\t  厌烦感强，不可控的脾气暴发";
                cell.textLabel.font = [UIFont systemFontOfSize:18];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"6s-frame7"]]];
                break;
            case 7:
                cell.textLabel.text = @"\t  害怕某个特定场所、物体或事情";
                cell.textLabel.font = [UIFont systemFontOfSize:18];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"6s-frame8"]]];
                break;
            case 8:
                cell.textLabel.text = @"\t  猜疑心重，妄想，夸大被动体验";
                cell.textLabel.font = [UIFont systemFontOfSize:18];
                [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"6s-frame9"]]];
                break;
            default:
                break;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIScreen mainScreen] bounds].size.height < 568){
        return tableView.frame.size.height/7;
    }
    else{
        return tableView.frame.size.height/9;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1 && buttonIndex == 1) {
        bt1.backgroundColor = [UIColor whiteColor];
        test = [[YiYuTestViewController alloc]initWithKind:@"SAS"];//创建测试界面视图
        test.view.backgroundColor = [UIColor whiteColor];//设置背景颜色为白色
        test.title = @"抑郁自测";
        test.kind = @"SAS";
        choosedKind = @"SAS";
        [self.navigationController pushViewController:test animated:YES];
        test.delegate = self;
        
        temp = [[NSMutableArray alloc]init];
        NSInteger i =1;
        for (i = 1; i <= 20; i++) {
            NSString *tempString = [NSString stringWithFormat:@"%ld",(long)i];
            [temp addObject:tempString];
        }
        test.tags = temp;
        test.tag = [temp objectAtIndex:0];
    }
    if(alertView.tag == 2 && buttonIndex == 1){
        bt2.backgroundColor = [UIColor whiteColor];
        test = [[YiYuTestViewController alloc]initWithKind:@"SDS"];//创建测试界面视图
        test.view.backgroundColor = [UIColor whiteColor];//设置背景颜色为白色
        test.title = @"焦虑自测";
        test.kind = @"SDS";
        choosedKind = @"SDS";
        test.tag = [[NSMutableString alloc]initWithFormat:@"1"];
        [self.navigationController pushViewController:test animated:YES];
        test.delegate = self;
        
        temp = [[NSMutableArray alloc]init];
        NSInteger i =1;
        for (i = 1; i <= 20; i++) {
            NSString *tempString = [NSString stringWithFormat:@"%ld",(long)i];
            [temp addObject:tempString];
        }
        test.tags = temp;
        test.tag = [temp objectAtIndex:0];
    }
    if(alertView.tag == 3 && buttonIndex == 1){
        bt3.backgroundColor = [UIColor whiteColor];
        test = [[YiYuTestViewController alloc]initWithKind:@"SCL"];//创建测试界面视图
        test.view.backgroundColor = [UIColor whiteColor];//设置背景颜色为白色
        test.title = @"SCL自测";
        test.kind = @"SCL";
        choosedKind = @"SCL";
        choosedSubKind = @"general";
        test.tag = [[NSMutableString alloc]initWithFormat:@"1"];
        [self.navigationController pushViewController:test animated:YES];
        test.delegate = self;
        
        temp = [[NSMutableArray alloc]init];
        NSInteger i =1;
        for (i = 1; i <= 90; i++) {
            NSString *tempString = [NSString stringWithFormat:@"%ld",(long)i];
            [temp addObject:tempString];
        }
        test.tags = temp;
        test.tag = [temp objectAtIndex:0];
    }
}

-(void)submit{
    NSMutableArray *answers = [manager findAnswersbyKind:choosedKind andTags:temp];
    result = [[testAnalysisViewController alloc]initWithAnswers:answers];
    result.tags = temp;
    result.kind = choosedKind;
    result.subKind = choosedSubKind;
    result.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:result animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    test = [[YiYuTestViewController alloc]initWithKind:@"SCL"];//创建测试界面视图
    test.view.backgroundColor = [UIColor whiteColor];//设置背景颜色为白色
    
    test.kind = @"SCL";
    choosedKind = @"SCL";
    
    test.delegate = self;
    [self.navigationController pushViewController:test animated:YES];
    
    temp = [[NSMutableArray alloc]init];
    
    if ([[UIScreen mainScreen] bounds].size.height < 568){
        switch (indexPath.row) {
            case 0:
                [temp addObject:@"1"];[temp addObject:@"4"];[temp addObject:@"12"];[temp addObject:@"27"];[temp addObject:@"40"];[temp addObject:@"42"];[temp addObject:@"48"];[temp addObject:@"49"];[temp addObject:@"52"];
                [temp addObject:@"53"];[temp addObject:@"56"];[temp addObject:@"58"];
                choosedSubKind = @"body";
                break;
            case 1:
                [temp addObject:@"3"];[temp addObject:@"9"];[temp addObject:@"10"];[temp addObject:@"28"];[temp addObject:@"38"];[temp addObject:@"45"];[temp addObject:@"46"];[temp addObject:@"51"];[temp addObject:@"55"];
                [temp addObject:@"65"];
                choosedSubKind = @"obsession";
                break;
            case 2:
                [temp addObject:@"6"];[temp addObject:@"21"];[temp addObject:@"34"];[temp addObject:@"36"];[temp addObject:@"37"];[temp addObject:@"41"];[temp addObject:@"61"];[temp addObject:@"69"];[temp addObject:@"73"];
                choosedSubKind = @"sensitiveInterpersonalRelationship";
                break;
            case 3:
                [temp addObject:@"5"];[temp addObject:@"14"];[temp addObject:@"15"];[temp addObject:@"20"];[temp addObject:@"22"];[temp addObject:@"26"];[temp addObject:@"29"];[temp addObject:@"30"];
                [temp addObject:@"31"];[temp addObject:@"32"];[temp addObject:@"54"];[temp addObject:@"71"];[temp addObject:@"79"];
                choosedSubKind = @"depression";
                break;
            case 4:
                [temp addObject:@"2"];[temp addObject:@"17"];[temp addObject:@"23"];[temp addObject:@"33"];[temp addObject:@"39"];[temp addObject:@"57"];[temp addObject:@"72"];[temp addObject:@"78"];[temp addObject:@"80"];
                [temp addObject:@"86"];
                choosedSubKind = @"anxiety";
                break;
            case 5:
                [temp addObject:@"11"];[temp addObject:@"14"];[temp addObject:@"63"];[temp addObject:@"67"];[temp addObject:@"74"];[temp addObject:@"81"];
                choosedSubKind = @"hostility";
                break;
            case 6:
                [temp addObject:@"13"];[temp addObject:@"25"];[temp addObject:@"47"];[temp addObject:@"50"];[temp addObject:@"70"];[temp addObject:@"75"];[temp addObject:@"82"];
                choosedSubKind = @"horror";
                break;
            default:
                break;
        }
    }
    else{
        switch (indexPath.row) {
            case 0:
                [temp addObject:@"1"];[temp addObject:@"4"];[temp addObject:@"12"];[temp addObject:@"27"];[temp addObject:@"40"];[temp addObject:@"42"];[temp addObject:@"48"];[temp addObject:@"49"];[temp addObject:@"52"];
                [temp addObject:@"53"];[temp addObject:@"56"];[temp addObject:@"58"];
                choosedSubKind = @"body";
                break;
            case 1:
                [temp addObject:@"1"];[temp addObject:@"4"];[temp addObject:@"12"];[temp addObject:@"27"];[temp addObject:@"40"];[temp addObject:@"42"];[temp addObject:@"48"];[temp addObject:@"49"];[temp addObject:@"52"];
                [temp addObject:@"53"];[temp addObject:@"56"];[temp addObject:@"58"];
                choosedSubKind = @"body";
                break;
            case 2:
                [temp addObject:@"3"];[temp addObject:@"9"];[temp addObject:@"10"];[temp addObject:@"28"];[temp addObject:@"38"];[temp addObject:@"45"];[temp addObject:@"46"];[temp addObject:@"51"];[temp addObject:@"55"];
                [temp addObject:@"65"];
                choosedSubKind = @"obsession";
                break;
            case 3:
                [temp addObject:@"6"];[temp addObject:@"21"];[temp addObject:@"34"];[temp addObject:@"36"];[temp addObject:@"37"];[temp addObject:@"41"];[temp addObject:@"61"];[temp addObject:@"69"];[temp addObject:@"73"];
                choosedSubKind = @"sensitiveInterpersonalRelationship";
                break;
            case 4:
                [temp addObject:@"5"];[temp addObject:@"14"];[temp addObject:@"15"];[temp addObject:@"20"];[temp addObject:@"22"];[temp addObject:@"26"];[temp addObject:@"29"];[temp addObject:@"30"];
                [temp addObject:@"31"];[temp addObject:@"32"];[temp addObject:@"54"];[temp addObject:@"71"];[temp addObject:@"79"];
                choosedSubKind = @"depression";
                break;
            case 5:
                [temp addObject:@"2"];[temp addObject:@"17"];[temp addObject:@"23"];[temp addObject:@"33"];[temp addObject:@"39"];[temp addObject:@"57"];[temp addObject:@"72"];[temp addObject:@"78"];[temp addObject:@"80"];[temp addObject:@"86"];
                choosedSubKind = @"anxiety";
                break;
            case 6:
                [temp addObject:@"11"];[temp addObject:@"14"];[temp addObject:@"63"];[temp addObject:@"67"];[temp addObject:@"74"];[temp addObject:@"81"];
                choosedSubKind = @"hostility";
                break;
            case 7:
                [temp addObject:@"13"];[temp addObject:@"25"];[temp addObject:@"47"];[temp addObject:@"50"];[temp addObject:@"70"];[temp addObject:@"75"];[temp addObject:@"82"];
                choosedSubKind = @"horror";
                break;
            case 8:
                [temp addObject:@"8"];[temp addObject:@"18"];[temp addObject:@"43"];[temp addObject:@"68"];[temp addObject:@"76"];[temp addObject:@"83"];
                choosedSubKind = @"stubbornness";
                break;
            default:
                break;
        }
    }
    test.tags = temp;
    test.tag = [temp objectAtIndex:0];
    
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
