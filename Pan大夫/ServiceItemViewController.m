//
//  ViewController.m
//  Demo_homepage
//
//  Created by lf on 15/3/7.
//  Copyright (c) 2015年 lf. All rights reserved.
//

#import "ServiceItemViewController.h"
#import "MyScrollView.h"
#import "TestViewController.h"
#import "DoctorsListViewController.h"
#define IS_IPHONE_4S_SCREEN [[UIScreen mainScreen]bounds].size.height<=485.0f&&[[UIScreen mainScreen]bounds].size.height>=475.0f
#define IS_IPHONE_5S_SCREEN [[UIScreen mainScreen]bounds].size.height<=570.0f&&[[UIScreen mainScreen]bounds].size.height>=565.0f
#define IS_IPHONE_6_SCREEN [[UIScreen mainScreen]bounds].size.height<=670.0f&&[[UIScreen mainScreen]bounds].size.height>=660.0f
#define IS_IPHONE_6plus_SCREEN [[UIScreen mainScreen]bounds].size.height<=740.0f&&[[UIScreen mainScreen]bounds].size.height>=735.0f
#define k_scale_up 220.0/736.0                   //上面scrollView所占屏幕的比例
#define KDeviceWidth [[UIScreen mainScreen]bounds].size.width
#define KDeviceHeight [[UIScreen mainScreen]bounds].size.height
#define kSpecialButtonHeight 75/736.0
#define kSpecialLabelHeight 40/736.0
#define kSpecialLabelTop 18/736.0
#define kSpecialLabelLeft 14/414.0
#define kSpecialLabelWidth 180/414.0
#define kImageViewWidth 138/414.0
#define kImageViewHeight 164/736.0
@interface ServiceItemViewController ()
@property (nonatomic, strong) UIButton *view1;
@property (nonatomic, strong) UIButton *view2;
@property (nonatomic, strong) UIButton *view3;
@property (nonatomic, strong) UIButton *view4;
@property (nonatomic, strong) UIButton *view5;
@property (nonatomic, strong) UIButton *view6;
@property (nonatomic, strong) MyScrollView *myScrollView;
@property (nonatomic, strong) NSArray *specialArray;
@property (nonatomic, strong) NSArray  *imageArray;
@property (nonatomic, strong) UIButton *specialDiseaseButton;
@end

@implementation ServiceItemViewController
@synthesize myScrollView;
@synthesize view1,view2,view3,view4,view5,view6;
@synthesize specialArray,imageArray;
@synthesize specialList;
@synthesize specialDiseaseButton;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;//默认为yes，自动把scrollview默认为全局展开，当myScrollview不铺满整个页面时候，必须设为NO，否则会导致视图偏移
    
    //每个View所对应的special
    specialArray = [[NSArray alloc]initWithObjects:@"marriage",@"education",@"parents",@"interaction",@"pressure",@"AIDS",@"others", nil];
    if (IS_IPHONE_4S_SCREEN) {
        imageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"introduction-4"], [UIImage imageNamed:@"question-4"],[UIImage imageNamed:@"report-4"],nil];
    }
    else{
        imageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"introduction"], [UIImage imageNamed:@"question"],[UIImage imageNamed:@"report"],nil];
    }
    //适配上面的scrollView
    if (IS_IPHONE_5S_SCREEN) {
        myScrollView = [[MyScrollView alloc]initWithFrame:CGRectMake(0, 0, KDeviceWidth, KDeviceHeight*k_scale_up) ImageArray:imageArray isURL:NO TimeInterval:3.0];
        [myScrollView setPageControlWithFrame:CGRectMake(0, -12,[[UIScreen mainScreen]bounds].size.width, 340)];
    }
    if (IS_IPHONE_6_SCREEN) {
        myScrollView = [[MyScrollView alloc]initWithFrame:CGRectMake(0, 0, KDeviceWidth, k_scale_up*KDeviceHeight) ImageArray:imageArray isURL:NO TimeInterval:3.0];
        [myScrollView setPageControlWithFrame:CGRectMake(0, 35,[[UIScreen mainScreen]bounds].size.width, 310)];
    }
    if (IS_IPHONE_6plus_SCREEN) {
        myScrollView = [[MyScrollView alloc]initWithFrame:CGRectMake(0, 0, KDeviceHeight,k_scale_up*KDeviceHeight) ImageArray:imageArray isURL:NO TimeInterval:3.0];
        [myScrollView setPageControlWithFrame:CGRectMake(0, 60,623/455*[[UIScreen mainScreen]bounds].size.width, 300)];
    }
    if (IS_IPHONE_4S_SCREEN) {
        myScrollView = [[MyScrollView alloc]initWithFrame:CGRectMake(0, 0, KDeviceWidth, KDeviceHeight*k_scale_up) ImageArray:imageArray isURL:NO TimeInterval:3.0];
        [myScrollView setPageControlWithFrame:CGRectMake(0, -22,[[UIScreen mainScreen]bounds].size.width, 310)];
    }
    
    //页面跳转
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushNavigationController)];
    singleTap.numberOfTapsRequired = 1;
    [myScrollView addGestureRecognizer:singleTap];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
    doubleTap.numberOfTapsRequired = 2;
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [myScrollView addGestureRecognizer:doubleTap];
    
    [self.view addSubview:myScrollView];
    
    //下面6个imageView
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(into:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(into:)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(into:)];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(into:)];
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(into:)];
    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(into:)];
    UITapGestureRecognizer *tap7 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(into:)];
    
    specialDiseaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    specialDiseaseButton.frame = CGRectMake(0, CGRectGetMaxY(myScrollView.frame), KDeviceWidth, kSpecialButtonHeight*KDeviceHeight);
    [specialDiseaseButton addGestureRecognizer:tap6];
    [specialDiseaseButton setUserInteractionEnabled:YES];
    specialDiseaseButton.tag = 6;
    NSLog(@"specialDisease frame is %f,%f",specialDiseaseButton.frame.size.width,specialDiseaseButton.frame.size.height);
    [self.view addSubview:specialDiseaseButton];
    
    
    UILabel *hotDiseaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSpecialLabelLeft*KDeviceWidth, kSpecialLabelTop*KDeviceHeight-1, kSpecialLabelWidth*KDeviceWidth, kSpecialLabelHeight*KDeviceHeight)];
    hotDiseaseLabel.textAlignment = NSTextAlignmentRight;
    hotDiseaseLabel.text = @"热点病症:";
    hotDiseaseLabel.textColor = [UIColor grayColor];
    [specialDiseaseButton addSubview:hotDiseaseLabel];
    
    UILabel *AIDSLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(hotDiseaseLabel.frame), kSpecialLabelTop*KDeviceHeight-1, KDeviceWidth-kSpecialLabelWidth*KDeviceWidth, kSpecialLabelHeight*KDeviceHeight)];
    AIDSLabel.text = @" 恐艾症";
    AIDSLabel.font = [UIFont systemFontOfSize:24];
    [specialDiseaseButton addSubview:AIDSLabel];
    
    if (IS_IPHONE_5S_SCREEN) {
        view1 = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(specialDiseaseButton.frame), kImageViewWidth*KDeviceWidth, 113.5)];
        
        view2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(view1.frame), CGRectGetMinY(view1.frame), kImageViewWidth*KDeviceWidth, 113.5)];
        
        view3 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(view2.frame),CGRectGetMinY(view1.frame),kImageViewWidth*KDeviceWidth, 113.5)];
        
        view4 = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame),kImageViewWidth*KDeviceWidth, 113.5)];
        
        view5 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(view4.frame), CGRectGetMinY(view4.frame),kImageViewWidth*KDeviceWidth, 113.5)];
        
        view6 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(view5.frame),CGRectGetMinY(view4.frame),kImageViewWidth*KDeviceWidth, 113.5)];
    }
    if (IS_IPHONE_4S_SCREEN) {
        view1 = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(specialDiseaseButton.frame), kImageViewWidth*KDeviceWidth, 87)];
        
        view2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(view1.frame), CGRectGetMinY(view1.frame), kImageViewWidth*KDeviceWidth, 87)];
        
        view3 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(view2.frame),CGRectGetMinY(view1.frame),kImageViewWidth*KDeviceWidth, 87)];
        
        view4 = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame),kImageViewWidth*KDeviceWidth, 87)];
        
        view5 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(view4.frame), CGRectGetMinY(view4.frame),kImageViewWidth*KDeviceWidth, 87)];
        
        view6 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(view5.frame),CGRectGetMinY(view4.frame),kImageViewWidth*KDeviceWidth, 87)];
    }
    if ((IS_IPHONE_6_SCREEN)||(IS_IPHONE_6plus_SCREEN)) {
        view1 = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(specialDiseaseButton.frame), kImageViewWidth*KDeviceWidth, KDeviceHeight*kImageViewHeight)];
    
        view2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(view1.frame), CGRectGetMinY(view1.frame), kImageViewWidth*KDeviceWidth, KDeviceHeight*kImageViewHeight)];
    
        view3 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(view2.frame),CGRectGetMinY(view1.frame),kImageViewWidth*KDeviceWidth, KDeviceHeight*kImageViewHeight)];
    
        view4 = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame),kImageViewWidth*KDeviceWidth, KDeviceHeight*kImageViewHeight)];
    
        view5 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(view4.frame), CGRectGetMinY(view4.frame),kImageViewWidth*KDeviceWidth, KDeviceHeight*kImageViewHeight)];
    
        view6 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(view5.frame),CGRectGetMinY(view4.frame),kImageViewWidth*KDeviceWidth, KDeviceHeight*kImageViewHeight)];
    }
    
    view1.tag = 1;
    view1.backgroundColor = [UIColor whiteColor];
    [view1 addGestureRecognizer:tap1];
    [view1 setUserInteractionEnabled:YES];
    [self.view addSubview:view1];

    view2.tag = 2;
    view2.backgroundColor = [UIColor whiteColor];
    [view2 setUserInteractionEnabled:YES];
    [view2 addGestureRecognizer:tap2];
    [self.view addSubview:view2];
    
    view3.tag = 3;
    view3.backgroundColor = [UIColor whiteColor];
    [view3 setUserInteractionEnabled:YES];
    [view3 addGestureRecognizer:tap3];
    [self.view addSubview:view3];
    
    view4.tag = 4;
    view4.backgroundColor = [UIColor whiteColor];
    [view4 setUserInteractionEnabled:YES];
    [view4 addGestureRecognizer:tap4];
    [self.view addSubview:view4];
    
    view5.tag = 5;
    view5.backgroundColor = [UIColor whiteColor];
    [view5 setUserInteractionEnabled:YES];
    [view5 addGestureRecognizer:tap5];
    [self.view addSubview:view5];
    
    view6.tag = 7;
    view6.backgroundColor = [UIColor whiteColor];
    [view6 setUserInteractionEnabled:YES];
    [view6 addGestureRecognizer:tap7];
    [self.view addSubview:view6];
    
    [self setImageView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushNavigationController
{
    int index = self.myScrollView.contentOffset.x / kScreenWidth;
    if (index + 2 - self.myScrollView.contentSize.width/kScreenWidth >= 0) {
        index = index + 2 - self.myScrollView.contentSize.width/kScreenWidth;
    }   //此时的index对应myscrollView 中第index张图片，从0开始计算
    
    TestViewController *testViewController = [[TestViewController alloc]init];
    [testViewController setIndex:index];
    [myScrollView endTimer];
    [self.pushDelegate.navigationController pushViewController:testViewController animated:YES];
}

-(void)into:(UITapGestureRecognizer *)recognizer{
    //根据imageView的tag值确定要跳转哪一个界面
    switch (recognizer.view.tag) {
        case 1:
            specialList = [[DoctorsListViewController alloc]initWithDelegate:self.pushDelegate Special:[specialArray objectAtIndex:(recognizer.view.tag-1)]];
            break;
        case 2:
            specialList = [[DoctorsListViewController alloc]initWithDelegate:self.pushDelegate Special:[specialArray objectAtIndex:(recognizer.view.tag-1)]];
            break;
        case 3:
            specialList = [[DoctorsListViewController alloc]initWithDelegate:self.pushDelegate Special:[specialArray objectAtIndex:(recognizer.view.tag-1)]];
            break;
        case 4:
            specialList = [[DoctorsListViewController alloc]initWithDelegate:self.pushDelegate Special:[specialArray objectAtIndex:(recognizer.view.tag-1)]];
            break;
        case 5:
            specialList = [[DoctorsListViewController alloc]initWithDelegate:self.pushDelegate Special:[specialArray objectAtIndex:(recognizer.view.tag-1)]];
            break;
        case 6:
            specialList = [[DoctorsListViewController alloc]initWithDelegate:self.pushDelegate Special:[specialArray objectAtIndex:(recognizer.view.tag-1)]];
            break;
        case 7:
            specialList = [[DoctorsListViewController alloc]initWithDelegate:self.pushDelegate Special:[specialArray objectAtIndex:(recognizer.view.tag-1)]];
        default:
            break;
    }
    [self.pushDelegate.navigationController pushViewController:specialList animated:YES];
}

-(id)initWithPushDelegate:(HomeViewController *)Delegate{
    self = [super init];
    if (self) {
        self.pushDelegate = Delegate;
    }
    return self;
}
//判断机型,添加图片至首页
- (void)setImageView{
    if (IS_IPHONE_4S_SCREEN) {
        [specialDiseaseButton setBackgroundImage:[UIImage imageNamed:@"hotspotPlain-4s"] forState:UIControlStateNormal];
        [specialDiseaseButton setBackgroundImage:[UIImage imageNamed:@"hotspot-4S"] forState:UIControlStateHighlighted];
        [view1 setBackgroundImage:[UIImage imageNamed:@"marriagePlain-4s"] forState:UIControlStateNormal];
        [view1 setBackgroundImage:[UIImage imageNamed:@"marriage-4"] forState:UIControlStateHighlighted];
        
        [view2 setBackgroundImage:[UIImage imageNamed:@"studyPlain-4s"] forState:UIControlStateNormal];
        [view2 setBackgroundImage:[UIImage imageNamed:@"study-4"] forState:UIControlStateHighlighted];
        
        [view3 setBackgroundImage:[UIImage imageNamed:@"parentsPlain-4s"] forState:UIControlStateNormal];
        [view3 setBackgroundImage:[UIImage imageNamed:@"parents-4"] forState:UIControlStateHighlighted];
        
        [view4 setBackgroundImage:[UIImage imageNamed:@"interactionPlain-4s"] forState:UIControlStateNormal];
        [view4 setBackgroundImage:[UIImage imageNamed:@"interaction-4"] forState:UIControlStateHighlighted];
        
        [view5 setBackgroundImage:[UIImage imageNamed:@"pressurePlain-4s"] forState:UIControlStateNormal];
        [view5 setBackgroundImage:[UIImage imageNamed:@"pressure-4"] forState:UIControlStateHighlighted];
        
        [view6 setBackgroundImage:[UIImage imageNamed:@"othersPlain-4s"] forState:UIControlStateNormal];
        [view6 setBackgroundImage:[UIImage imageNamed:@"others-4"] forState:UIControlStateHighlighted];
    }
    else{
    [specialDiseaseButton setBackgroundImage:[UIImage imageNamed:@"hotspot-unpressed"] forState:UIControlStateNormal];
    [specialDiseaseButton setBackgroundImage:[UIImage imageNamed:@"hotspot"] forState:UIControlStateHighlighted];
    [view1 setBackgroundImage:[UIImage imageNamed:@"marriage-Unpressed"] forState:UIControlStateNormal];
    [view1 setBackgroundImage:[UIImage imageNamed:@"marriage"] forState:UIControlStateHighlighted];
    
    [view2 setBackgroundImage:[UIImage imageNamed:@"study-Unpressed"] forState:UIControlStateNormal];
    [view2 setBackgroundImage:[UIImage imageNamed:@"study"] forState:UIControlStateHighlighted];
    
    [view3 setBackgroundImage:[UIImage imageNamed:@"parent-Unpressed"] forState:UIControlStateNormal];
    [view3 setBackgroundImage:[UIImage imageNamed:@"parents"] forState:UIControlStateHighlighted];
    
    [view4 setBackgroundImage:[UIImage imageNamed:@"interaction-unpressed"] forState:UIControlStateNormal];
    [view4 setBackgroundImage:[UIImage imageNamed:@"interaction"] forState:UIControlStateHighlighted];
    
    [view5 setBackgroundImage:[UIImage imageNamed:@"pressure-unpressed"] forState:UIControlStateNormal];
    [view5 setBackgroundImage:[UIImage imageNamed:@"pressure"] forState:UIControlStateHighlighted];
    
    [view6 setBackgroundImage:[UIImage imageNamed:@"others-unpressed"] forState:UIControlStateNormal];
    [view6 setBackgroundImage:[UIImage imageNamed:@"others"] forState:UIControlStateHighlighted];
    }
}

@end
