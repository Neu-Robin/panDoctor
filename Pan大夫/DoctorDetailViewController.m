//
//  DoctorDetailViewController.m
//  Pan大夫
//
//  Created by tiny on 15/3/6.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import "DoctorDetailViewController.h"
#import "Doctor.h"
#import "DoctorInfoScrollView.h"
#import "StarRateView.h"
#import "Order.h"
#import "InformationConfirmViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "SettingsViewController.h"
#define KDeviceWidth [[UIScreen mainScreen]bounds].size.width
#define KDeviceHeight [[UIScreen mainScreen]bounds].size.height
#define kInterval 4
#define kTopInterval 0.008802
#define kLeftInterval 0.0125
#define kBasicViewWidth 0.975
#define kBasicViewHeight 0.211267
#define kPicTopInterval 0.012323
#define kPicLeftInterval 0.01875
#define kPicWidth 0.2625
#define kStarHeight 0.035211
#define kNameTopInterval 0.021126
#define kNameDownInterval 0.008802
#define kNameLabelWidth 100/375.0
#define kNameLabelHeight 0.035211
#define kSexLabelwidth 0.04375
#define kAgeLabelWidth 0.05
#define kSecAgeLabelWidth 0.04375
#define kMarkLeftInterval 0.046875
#define kMarkLabelWidth 0.08125
#define kSecMarkWidth 0.15625
#define kTextViewWidth 0.65625
#define kTextViewHeight 0.132042
#define kPicWidthRatio 85.0f/320.0f
#define kButtonWidth 0.24375
#define kButtonHeight 0.056338
#define kScrollViewHeight 0.492957
#define kBasicDownInterval 0.007042
#define kLineViewHeight 0.5
#define kEmptyViewHeight 0.017605
#define kTabBarHeight 100.0/736.0
#define kAppointButtonTop 9.0/736.0
#define kAppointButtonLeft 7.0/414.0
#define kAppointButtonWidth 400/414.0
#define kAppointButtonHeight 48.0/736.0
@interface DoctorDetailViewController ()
@property (strong, nonatomic) Doctor *localDoctor;
@property (strong, nonatomic) UIView *basicInfoView;
@property (strong, nonatomic) UIImageView *docPic;
@property (strong, nonatomic) UILabel *docNameLabel;
@property (strong, nonatomic) UILabel *sexLabel;
@property (strong, nonatomic) UILabel *ageLabel;
@property (strong, nonatomic) UILabel *secAgeLabel;
@property (strong, nonatomic) UILabel *markLabel;
@property (strong, nonatomic) UILabel *secMarkLabel;

@property (strong, nonatomic) UIButton *timeTableButton;
@property (strong, nonatomic) UIButton *docInfoButton;
@property (strong, nonatomic) UIButton *certificateButton;
@property (strong, nonatomic) UIButton *evaluationButton;
@property (strong, nonatomic) UIButton *previousButton;
@property (strong, nonatomic) UIButton *appointButton;

@property (strong, nonatomic) UITextView *introductionTextView;

@property (strong, nonatomic) UIView *appointView;

@property (strong, nonatomic) DoctorInfoScrollView *docScrollView;
@property (strong, nonatomic) LoginViewController *loginView;
@property (strong, nonatomic) InformationConfirmViewController *infoVC;
@property (strong, nonatomic) StarRateView *docStarRate;
@property (strong, nonatomic) NSString *speStr;
@property (strong, nonatomic) MKNetworkOperation *netOp;

@end

@implementation DoctorDetailViewController
@synthesize localDoctor;
@synthesize basicInfoView;
@synthesize docPic;
@synthesize docNameLabel,secAgeLabel,ageLabel,sexLabel,markLabel,secMarkLabel;
@synthesize timeTableButton,docInfoButton,certificateButton,evaluationButton,appointButton;
@synthesize docScrollView;
@synthesize introductionTextView;
@synthesize appointView;
@synthesize docStarRate,speStr;
@synthesize netOp;
@synthesize infoVC,loginView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0];
    self.view.frame = CGRectMake(0, 0, KDeviceWidth, KDeviceHeight);
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
}
//初始化DoctorDetailViewController对象并获取医生对象
- (id)initWithDoctor:(Doctor *)doc DoctorList:(DoctorsListViewController *)docList{
    self = [super init];
    if (self) {
        self.docListView = docList;
        speStr = self.docListView.special;
        localDoctor = doc;
        basicInfoView = [[UIView alloc]initWithFrame:CGRectMake(kLeftInterval*KDeviceWidth, kTopInterval*KDeviceHeight+64, KDeviceWidth*kBasicViewWidth, kBasicViewHeight*KDeviceHeight)];
        basicInfoView.backgroundColor = [UIColor whiteColor];
        basicInfoView.layer.cornerRadius = 5;
        [self.view addSubview:basicInfoView];
        
        [self setMoreInfoButton];
        //初始化下部的scrollView
        if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=567&&KDeviceHeight<=569) {
            docScrollView = [[DoctorInfoScrollView alloc]initWithFrame:CGRectMake(CGRectGetMinX(timeTableButton.frame), CGRectGetMaxY(timeTableButton.frame), kBasicViewWidth*KDeviceWidth,287) AndDoctor:localDoctor];
            docScrollView.userInteractionEnabled = YES;
        }
        if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481) {
            docScrollView = [[DoctorInfoScrollView alloc]initWithFrame:CGRectMake(CGRectGetMinX(timeTableButton.frame), CGRectGetMaxY(timeTableButton.frame), kBasicViewWidth*KDeviceWidth,233) AndDoctor:localDoctor];
            docScrollView.userInteractionEnabled = YES;
        }
        if (KDeviceWidth>=374&&KDeviceWidth<=376) {
            docScrollView = [[DoctorInfoScrollView alloc]initWithFrame:CGRectMake(CGRectGetMinX(timeTableButton.frame), CGRectGetMaxY(timeTableButton.frame), kBasicViewWidth*KDeviceWidth,350) AndDoctor:localDoctor];
            docScrollView.userInteractionEnabled = YES;
        }
        if (KDeviceWidth>=413&&KDeviceWidth<=415) {
            docScrollView = [[DoctorInfoScrollView alloc]initWithFrame:CGRectMake(CGRectGetMinX(timeTableButton.frame), CGRectGetMaxY(timeTableButton.frame), kBasicViewWidth*KDeviceWidth,393) AndDoctor:localDoctor];
            docScrollView.userInteractionEnabled = YES;
        }
        [self.view addSubview:docScrollView];
        
        //创建tabBar
        appointView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(docScrollView.frame)+kTopInterval*KDeviceHeight, KDeviceWidth,kTabBarHeight*KDeviceHeight)];
        appointView.backgroundColor = [UIColor whiteColor];
        
        appointButton = [[UIButton alloc]initWithFrame:CGRectMake(kAppointButtonLeft*KDeviceWidth, kAppointButtonTop*KDeviceHeight, kAppointButtonWidth*KDeviceWidth, kAppointButtonHeight*KDeviceHeight)];
        appointButton.layer.cornerRadius = 5;
        [appointButton setTitle:@"预    约" forState:UIControlStateNormal];
        [appointButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [appointButton setBackgroundColor:[UIColor colorWithRed:0/255.0 green:175/255.0 blue:170/255.0 alpha:1.0]];
        [appointButton addTarget:self action:@selector(appointMentEvents) forControlEvents:UIControlEventTouchUpInside];

        
        UIImageView *LineView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(timeTableButton.frame), CGRectGetMaxY(timeTableButton.frame)-5, 4*kButtonWidth*KDeviceWidth, kLineViewHeight)];
        [LineView setBackgroundColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255 blue:150.0/255.0 alpha:1.0]];
        
        //添加覆盖圆角的View
        UIView *emptyView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(basicInfoView.frame), CGRectGetMaxY(LineView.frame), 4*kButtonWidth*KDeviceWidth, kEmptyViewHeight*KDeviceHeight)];
        emptyView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(timeTableButton.frame), CGRectGetMaxY(timeTableButton.frame)-5, 0.5, 30)];
        [leftView setBackgroundColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255 blue:150.0/255.0 alpha:1.0]];
        
        UIImageView *rightView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(evaluationButton.frame)-0.5, CGRectGetMaxY(timeTableButton.frame)-5, 0.5, 30)];
        [rightView setBackgroundColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255 blue:150.0/255.0 alpha:1.0]];
        
        docPic = [[UIImageView alloc]initWithFrame:CGRectMake(kPicLeftInterval*KDeviceWidth, kPicTopInterval*KDeviceHeight, kPicWidth*KDeviceWidth, kPicWidth*KDeviceWidth)];
        docPic.image = [UIImage imageNamed:@"appCover"];
        
        docNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(docPic.frame)+kPicLeftInterval*KDeviceWidth, KDeviceHeight*kNameTopInterval, kNameLabelWidth*KDeviceWidth, kNameLabelHeight*KDeviceHeight)];
        
        sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(docNameLabel.frame), CGRectGetMinY(docNameLabel.frame), kSexLabelwidth*KDeviceWidth, kNameLabelHeight*KDeviceHeight)];
        
        ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(sexLabel.frame)+kPicLeftInterval*KDeviceWidth, CGRectGetMinY(sexLabel.frame), kAgeLabelWidth*KDeviceWidth, kNameLabelHeight*KDeviceHeight)];
        
        secAgeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(ageLabel.frame), CGRectGetMinY(ageLabel.frame),kSecAgeLabelWidth*KDeviceWidth , kNameLabelHeight*KDeviceHeight)];
        secAgeLabel.text = @"岁";
        
        introductionTextView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMinX(docNameLabel.frame), CGRectGetMaxY(docNameLabel.frame)+kTopInterval*KDeviceHeight, kTextViewWidth*KDeviceWidth, kTextViewHeight*KDeviceHeight)];
        introductionTextView.userInteractionEnabled = NO;
        introductionTextView.editable = NO;
        introductionTextView.textContainerInset = UIEdgeInsetsZero;
        
        if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481){
            docStarRate = [[StarRateView alloc]initWithFrame:CGRectMake(CGRectGetMinX(docPic.frame)+8, CGRectGetMaxY(docPic.frame), 70, 12) numberOfStars:5];
            docStarRate.allowIncompleteStar = YES;
            docStarRate.hasAnimation = NO;
        }
        else{
            docStarRate = [[StarRateView alloc]initWithFrame:CGRectMake(CGRectGetMinX(docPic.frame), CGRectGetMaxY(docPic.frame)+(kPicTopInterval*KDeviceHeight)/2, KDeviceWidth*kPicWidth, kStarHeight*KDeviceHeight) numberOfStars:5];
            docStarRate.allowIncompleteStar = YES;
            docStarRate.hasAnimation = NO;
        }
        
        [self setContentOfLabel];
        [self setFont];
        [self addContentToBasicInfoView];
        [self.view addSubview:emptyView];
        [self.view addSubview:LineView];
        [self.view addSubview:leftView];
        [self.view addSubview:rightView];
        [self.view addSubview:appointView];
        [appointView addSubview:appointButton];
        

    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//填充医生基本信息
- (void)addContentToBasicInfoView{
    [basicInfoView addSubview:docPic];
    [basicInfoView addSubview:docNameLabel];
    [basicInfoView addSubview:sexLabel];
    [basicInfoView addSubview:ageLabel];
    [basicInfoView addSubview:secAgeLabel];
    [basicInfoView addSubview:introductionTextView];
    [basicInfoView addSubview:docStarRate];
}

- (void)setContentOfLabel{
    if (!localDoctor.docName) {
      docNameLabel.text = @"";
    }
    else{
      docNameLabel.text = localDoctor.docName;
    }
    if (!localDoctor.docSex) {
      sexLabel.text = @"";
    }
    else{
      sexLabel.text = localDoctor.docSex;
    }
    if (!localDoctor.docAge) {
      ageLabel.text = @"";
    }
    else{
      ageLabel.text = localDoctor.docAge;
    }
    if (!localDoctor.docIntroduction) {
      introductionTextView.text = @"";
    }
    else{
      introductionTextView.text = localDoctor.docIntroduction;
    }
    if (!localDoctor.docMark) {
      docStarRate.scorePercent = 0/5.0;
    }
    else{
      docStarRate.scorePercent = [localDoctor.docMark floatValue]/5.0;
    }
}

- (void)setFont{
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=567&&KDeviceHeight<=569) {
        docNameLabel.font = [UIFont systemFontOfSize:18];
        sexLabel.font = [UIFont systemFontOfSize:14];
        ageLabel.font = [UIFont systemFontOfSize:14];
        secAgeLabel.font = [UIFont systemFontOfSize:14];
        markLabel.font = [UIFont systemFontOfSize:11];
        secMarkLabel.font = [UIFont systemFontOfSize:11];
        introductionTextView.font = [UIFont systemFontOfSize:12];
        
        timeTableButton.titleLabel.font = [UIFont systemFontOfSize:15];
        docInfoButton.titleLabel.font = [UIFont systemFontOfSize:15];
        certificateButton.titleLabel.font = [UIFont systemFontOfSize:15];
        evaluationButton.titleLabel.font = [UIFont systemFontOfSize:15];
        
        appointButton.titleLabel.font = [UIFont systemFontOfSize:20];
    }
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481){
        docNameLabel.font = [UIFont systemFontOfSize:16];
        sexLabel.font = [UIFont systemFontOfSize:12];
        ageLabel.font = [UIFont systemFontOfSize:12];
        secAgeLabel.font = [UIFont systemFontOfSize:12];
        markLabel.font = [UIFont systemFontOfSize:10];
        secMarkLabel.font = [UIFont systemFontOfSize:10];
        introductionTextView.font = [UIFont systemFontOfSize:11];
        
        timeTableButton.titleLabel.font = [UIFont systemFontOfSize:13];
        docInfoButton.titleLabel.font = [UIFont systemFontOfSize:13];
        certificateButton.titleLabel.font = [UIFont systemFontOfSize:13];
        evaluationButton.titleLabel.font = [UIFont systemFontOfSize:13];
        
        appointButton.titleLabel.font = [UIFont systemFontOfSize:18];
    }
    if (KDeviceWidth>=374&&KDeviceWidth<=376) {
        docNameLabel.font = [UIFont systemFontOfSize:22];
        sexLabel.font = [UIFont systemFontOfSize:16];
        ageLabel.font = [UIFont systemFontOfSize:16];
        secAgeLabel.font = [UIFont systemFontOfSize:16];
        markLabel.font = [UIFont systemFontOfSize:13];
        secMarkLabel.font = [UIFont systemFontOfSize:13];
        introductionTextView.font = [UIFont systemFontOfSize:15];
        
        timeTableButton.titleLabel.font = [UIFont systemFontOfSize:17];
        docInfoButton.titleLabel.font = [UIFont systemFontOfSize:17];
        certificateButton.titleLabel.font = [UIFont systemFontOfSize:17];
        evaluationButton.titleLabel.font = [UIFont systemFontOfSize:17];
        
        appointButton.titleLabel.font = [UIFont systemFontOfSize:26];
    }
    if (KDeviceWidth>=413&&KDeviceWidth<=415) {
        docNameLabel.font = [UIFont systemFontOfSize:24];
        sexLabel.font = [UIFont systemFontOfSize:18];
        ageLabel.font = [UIFont systemFontOfSize:18];
        secAgeLabel.font = [UIFont systemFontOfSize:18];
        markLabel.font = [UIFont systemFontOfSize:14];
        secMarkLabel.font = [UIFont systemFontOfSize:14];
        introductionTextView.font = [UIFont systemFontOfSize:17];
        
        timeTableButton.titleLabel.font = [UIFont systemFontOfSize:19];
        docInfoButton.titleLabel.font = [UIFont systemFontOfSize:19];
        certificateButton.titleLabel.font = [UIFont systemFontOfSize:19];
        evaluationButton.titleLabel.font = [UIFont systemFontOfSize:19];
        
        appointButton.titleLabel.font = [UIFont systemFontOfSize:28];
    }
}

//设置选项卡的按钮
- (void)setMoreInfoButton{
    timeTableButton = [UIButton buttonWithType:UIButtonTypeCustom];
    timeTableButton.frame = CGRectMake(CGRectGetMinX(basicInfoView.frame), CGRectGetMaxY(basicInfoView.frame)+kBasicDownInterval*KDeviceHeight, kButtonWidth*KDeviceWidth, kButtonHeight*KDeviceHeight);
    [timeTableButton setBackgroundColor:[UIColor whiteColor]];
    timeTableButton.selected = YES;
    [timeTableButton setTitleColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [timeTableButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [timeTableButton setTitle:@"预约时间" forState:UIControlStateNormal];
    timeTableButton.layer.cornerRadius = 5;
    timeTableButton.tag = 0;
    [timeTableButton.layer setMasksToBounds:YES];
    [timeTableButton.layer setBorderWidth:0.5];
    CGColorSpaceRef timecolorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef timecolorref = CGColorCreate(timecolorSpace,(CGFloat[]){ 150.0/255.0,150.0/255.0, 150.0/255.0, 1 });
    [timeTableButton.layer setBorderColor:timecolorref];
    [timeTableButton addTarget:self action:@selector(chooseScrollViewPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:timeTableButton];
    
    docInfoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    docInfoButton.frame = CGRectMake(CGRectGetMaxX(timeTableButton.frame), CGRectGetMinY(timeTableButton.frame), kButtonWidth*KDeviceWidth, kButtonHeight*KDeviceHeight);
    [docInfoButton setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255 blue:235.0/255.0 alpha:1.0]];
    [docInfoButton setTitle:@"医师信息" forState:UIControlStateNormal];
    [docInfoButton setTitleColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255 blue:150.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [docInfoButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    docInfoButton.layer.cornerRadius = 5;
    docInfoButton.tag = 1;
    [docInfoButton.layer setMasksToBounds:YES];
    [docInfoButton.layer setBorderWidth:0.5];
    CGColorSpaceRef infoColorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef infoColorref = CGColorCreate(infoColorSpace,(CGFloat[]){ 150.0/255.0,150.0/255.0, 150.0/255.0, 1 });
    [docInfoButton.layer setBorderColor:infoColorref];
    [docInfoButton addTarget:self action:@selector(chooseScrollViewPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:docInfoButton];
    
    certificateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    certificateButton.frame = CGRectMake(CGRectGetMaxX(docInfoButton.frame), CGRectGetMinY(timeTableButton.frame), kButtonWidth*KDeviceWidth, kButtonHeight*KDeviceHeight);
    [certificateButton setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255 blue:235.0/255.0 alpha:1.0]];
    [certificateButton setTitle:@"资质证明" forState:UIControlStateNormal];
    [certificateButton setTitleColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255 blue:150.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [certificateButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    certificateButton.layer.cornerRadius = 5;
    certificateButton.tag = 2;
    [certificateButton.layer setMasksToBounds:YES];
    [certificateButton.layer setBorderWidth:0.5];
    CGColorSpaceRef certColorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef certColorref = CGColorCreate(certColorSpace,(CGFloat[]){ 150.0/255.0,150.0/255.0, 150.0/255.0, 1 });
    [certificateButton.layer setBorderColor:certColorref];
    [certificateButton addTarget:self action:@selector(chooseScrollViewPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:certificateButton];
    
    evaluationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    evaluationButton.frame = CGRectMake(CGRectGetMaxX(certificateButton.frame), CGRectGetMinY(timeTableButton.frame), kButtonWidth*KDeviceWidth, kButtonHeight*KDeviceHeight);
    [evaluationButton setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255 blue:235.0/255.0 alpha:1.0]];
    [evaluationButton setTitle:@"客户评价" forState:UIControlStateNormal];
    [evaluationButton setTitleColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255 blue:150.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [evaluationButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    evaluationButton.layer.cornerRadius = 5;
    evaluationButton.tag = 3;
    [evaluationButton.layer setMasksToBounds:YES];
    [evaluationButton.layer setBorderWidth:0.5];
    CGColorSpaceRef evaColorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef evaColorref = CGColorCreate(evaColorSpace,(CGFloat[]){ 150.0/255.0,150.0/255.0, 150.0/255.0, 1 });
    [evaluationButton.layer setBorderColor:evaColorref];
    [evaluationButton addTarget:self action:@selector(chooseScrollViewPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:evaluationButton];
    
    self.previousButton = timeTableButton;
}
//获取点击按钮的tag值，并且改变选中按钮的背景颜色
- (void)chooseScrollViewPage:(UIButton *)sender{
    [docScrollView getButtonID:sender.tag];
    self.previousButton.selected = NO;
    sender.selected = YES;
    [self.previousButton setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255 blue:235.0/255.0 alpha:1.0]];
    [sender setBackgroundColor:[UIColor whiteColor]];
    self.previousButton = sender;
}
//点击预约按钮触发事件
- (void)appointMentEvents{
    //if语句中判断信息是否完整，否则不做任何处理
    if ([docScrollView.timeTableViewController appointmentButtonClicked]) {
        //检查plist文件
        NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory =[paths objectAtIndex:0];
        NSString *documentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"login.plist"];//plist文件位置
        
        NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:documentPlistPath];
        NSString *isLoggedIn = [plistDictionary objectForKey:@"login"];
        NSLog(@"asd %@",isLoggedIn);
        
        //未登录
        if ([isLoggedIn isEqualToString:@"no"])
        {
            self.view.frame = CGRectMake(0, 0, KDeviceWidth, KDeviceHeight);
            loginView = [[LoginViewController alloc]initWithNav:YES];
            
            loginView.title = @"登录";
            [self.navigationController presentViewController:loginView animated:YES completion:^(void){}];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToInformationConfirmView) name:@"userLogin" object:nil];
        }
        else{
            [self goToInformationConfirmView];
        }
        
    }
}

- (void)pushToOrderConfirmViewWithPrice:(float)price{
    if (price != 0) {
        //正常获取到订单价格数据
        Order *newOrder = [[Order alloc]initWithOrderId:nil Doctorname:localDoctor.docName OrderDate:nil Duration:docScrollView.timeTableViewController.selectedTimeLong PatientName:nil PatientTel:nil DoctorId:localDoctor.docID StartTime:docScrollView.timeTableViewController.outputTimeInterval Special:speStr Address:nil CommentId:nil Description:nil Status:@"wait_for_pay" Price:price Distane:0 Age:0 Sex:nil RejectReason:@""];
        infoVC = [[InformationConfirmViewController alloc]initWithOrder:newOrder DocDetail:self Path:@"in"];
        docScrollView.timeTableViewController.selectedTimeLong = 0;//清空数据
        [self updateOrderInformation:newOrder];
        NSArray *gpsArray = [self.localDoctor.docGPS componentsSeparatedByString:@","];
        infoVC.doctorLng = [[gpsArray objectAtIndex:1]doubleValue];
        infoVC.doctorLat = [[gpsArray objectAtIndex:0]doubleValue];
        infoVC.outputStartPosition = docScrollView.timeTableViewController.outputStartPosition;
        [self.navigationController pushViewController:infoVC animated:YES];
    }
    else{
        //初试订单金额为0
        Order *newOrder = [[Order alloc]initWithOrderId:nil Doctorname:localDoctor.docName OrderDate:nil Duration:docScrollView.timeTableViewController.selectedTimeLong PatientName:nil PatientTel:nil DoctorId:localDoctor.docID StartTime:docScrollView.timeTableViewController.outputTimeInterval Special:speStr Address:nil CommentId:nil Description:nil Status:@"wait_for_pay" Price:0 Distane:0 Age:0 Sex:nil RejectReason:@""];
        infoVC = [[InformationConfirmViewController alloc]initWithOrder:newOrder DocDetail:self Path:@"in"];
        docScrollView.timeTableViewController.selectedTimeLong = 0;//清空数据
        [self updateOrderInformation:newOrder];
        NSArray *gpsArray = [self.localDoctor.docGPS componentsSeparatedByString:@","];
        infoVC.doctorLng = [[gpsArray objectAtIndex:1]doubleValue];
        infoVC.doctorLat = [[gpsArray objectAtIndex:0]doubleValue];
        infoVC.outputStartPosition = docScrollView.timeTableViewController.outputStartPosition;
        [self.navigationController pushViewController:infoVC animated:YES];
    }
}

- (void)updateOrderInformation:(Order *)order{
    
    NSDictionary *defaultPatinet = [self getCurrentPosition];
    if (defaultPatinet) {
        order.patientName = [defaultPatinet objectForKey:@"patientName"];
        if ([[defaultPatinet objectForKey:@"patientSex"] isEqualToString:@"female.jpg"]) {
            order.patientSex = @"女";
        }
        else{
            order.patientSex = @"男";
        }
        order.patientAge = [[defaultPatinet objectForKey:@"patientAge"]intValue];
        order.patientTel = [defaultPatinet objectForKey:@"patientTel"];
        order.address = [defaultPatinet objectForKey:@"patientAddress"];
        infoVC.userLng = [[defaultPatinet objectForKey:@"lng"]doubleValue];
        infoVC.userLat = [[defaultPatinet objectForKey:@"lat"]doubleValue];
    }
}

//从数据库获得病人数据
- (NSDictionary *)getCurrentPosition{
    // NSMutableDictionary *answer = [[NSMutableDictionary alloc]init];
    
    //获取plist字典
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:[self getFilePath]];
    NSMutableArray *patients = [plistDictionary objectForKey:@"patients"];
    if (!patients){
        return nil;
    }
    else{
        for (NSDictionary *patient in patients) {
            if ([[patient objectForKey:@"isDefault"]isEqualToString:@"yes"]) {
                return patient;
            }
        }
    }
    return nil;
}

- (NSString *)getFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory =[paths objectAtIndex:0];
    NSString *documentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"login.plist"];//plist文件位置
    return documentPlistPath;
}

- (NSMutableDictionary *)getDefaultUserPosition{
    //获取plist字典
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory =[paths objectAtIndex:0];
    NSString *documentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"login.plist"];//plist文件位置
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:documentPlistPath];
    NSMutableDictionary *currentPosition = [plistDictionary objectForKey:@"currentPosition"];
    return currentPosition;
}

- (void)goToInformationConfirmView{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSMutableDictionary *userLocation = [self getDefaultUserPosition];
    double userLng = [[userLocation objectForKey:@"lng"]doubleValue];
    double userLat = [[userLocation objectForKey:@"lat"]doubleValue];
    if (userLat == 0 && userLng == 0) {
        //没有用户定位数据
        docScrollView.timeTableViewController.selectedTimeLong = 0;//清空数据
        [self pushToOrderConfirmViewWithPrice:0];
    }
    else{
        NSArray *gpsArray = [self.localDoctor.docGPS componentsSeparatedByString:@","];
        double doctorLng = [[gpsArray objectAtIndex:1]doubleValue];
        double doctorLat = [[gpsArray objectAtIndex:0]doubleValue];
        
        BMKMapPoint doctorPosition = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(doctorLat,doctorLng));
        BMKMapPoint userPosition = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(userLat,userLng));
        
        CLLocationDistance distance = BMKMetersBetweenMapPoints(doctorPosition,userPosition)/1000;
        int intDistance = ceil(distance);
        NSLog(@"int distance = %d",intDistance);
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        NSString *durationString = [NSString stringWithFormat:@"%ld",(long)docScrollView.timeTableViewController.selectedTimeLong];
        NSString *distanceString = [NSString stringWithFormat:@"%d",intDistance];
        [data setValue:durationString forKey:@"duration"];
        [data setValue:distanceString forKey:@"distance"];
        [data setValue:self.localDoctor.docID forKey:@"doctorId"];
        
        netOp = [appDelegate.netEngine operationWithPath:@"/price.php" params:data httpMethod:@"POST"];
        __block DoctorDetailViewController *localSelf = self;
        [netOp addCompletionHandler:^(MKNetworkOperation *operation){
            id json = [operation responseJSON];
            NSDictionary *dic = (NSDictionary *)json;
            NSString *code = [dic objectForKey:@"code"];
            float orderPrice = 0;
            if ([code isEqualToString:@"100"]) {
                orderPrice = [[dic objectForKey:@"price"]floatValue];
                [localSelf pushToOrderConfirmViewWithPrice:orderPrice];
            }
            
        } errorHandler:^(MKNetworkOperation *operation,NSError *error){
            NSLog(@"网络加载失败！");
        }
         ];
        [appDelegate.netEngine enqueueOperation:netOp];
    }
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
