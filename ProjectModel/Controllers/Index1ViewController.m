//
//  Index1ViewController.m
//  ProjectModel
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "Index1ViewController.h"
#import "InternetRequest.h"
#import "Index1Service.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "SVProgressHUD.h"
#import "SharedAction.h"
#import "Prize_Lucky_Model.h"
#define HongbaoImg [UIImage imageNamed:@"hongbao.jpg"]
#define CurImg nil
#define endTimerTotal 5
@interface Index1ViewController ()
{
    __weak IBOutlet UIImageView *view1;
    __weak IBOutlet UIImageView *view2;
    __weak IBOutlet UIImageView *view3;
    __weak IBOutlet UIImageView *view4;
    __weak IBOutlet UIImageView *view5;
    __weak IBOutlet UIImageView *view6;
    __weak IBOutlet UIImageView *view7;
    __weak IBOutlet UIImageView *view8;
    __weak IBOutlet UIImageView *view9;
    __weak IBOutlet UIImageView *view10;
    __weak IBOutlet UIImageView *view11;
    __weak IBOutlet UIImageView *view12;
    __weak IBOutlet UIButton *startButton;
    
    __weak IBOutlet UILabel *label1;
    __weak IBOutlet UILabel *label2;
    __weak IBOutlet UILabel *label3;
    __weak IBOutlet UILabel *label4;
    __weak IBOutlet UILabel *label5;
    __weak IBOutlet UILabel *label6;
    __weak IBOutlet UILabel *label7;
    __weak IBOutlet UILabel *label8;
    __weak IBOutlet UILabel *label9;
    __weak IBOutlet UILabel *label10;
    __weak IBOutlet UILabel *label11;
    __weak IBOutlet UILabel *label12;
    
    
    NSArray *array;
    NSTimer *timer;
    UIImageView *currentView;
    float intervalTime;//变换时间差（用来表示速度）
    float accelerate;//减速度
    NSInteger resultValue;
    Index1Service *index1Service;
    NSTimer *timerOut;//超时结束
    float outTime;
    UserInfo *user;
    
}
@end

@implementation Index1ViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        index1Service = [[Index1Service alloc] init];
    }
    return self;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"E小区";
    // Do any additional setup after loading the view, typically from a nib.
    SharedData *sharedData = [SharedData sharedInstance];
    user= sharedData.user;
    self.marqueeLabel.marqueeType = MLContinuous;
    self.marqueeLabel.scrollDuration = 30.0f;
    self.marqueeLabel.fadeLength = 10.0f;
    self.marqueeLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pauseTap:)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.numberOfTouchesRequired = 1;
    [self.marqueeLabel addGestureRecognizer:tapRecognizer];
    array = [[NSArray alloc] initWithObjects:view1,view2,view3,view4,view5,view6,view7,view8,view9,view10,view11,view12,nil];
    NSUInteger count = array.count;
    for (int i=0; i<count; i++) {
        UIImageView *view = array[i];
        view.tag = i;
    }
    resultValue = 13;//
    outTime = 0;
    [index1Service prize_IndexWithToken:user.token andUser_type:user.user_type withTabBarController:self.tabBarController withdone:^(PrizeIndexInfo *model){
        self.prizeIndexInfo = model;
        NSArray *lucky = (NSArray *)model.prize;
        NSArray *rotary = (NSArray *)model.rotary;
        [self loadPrizeDatas:lucky];
        [self loadRotaryDatas:rotary];
         self.tipLabel.text = [NSString stringWithFormat:@"您当前还有%d次机会，已有%ld人参与抽奖",model.nums,model.peoples];
    }];
}

//加载中奖人信息
-(void)loadPrizeDatas:(NSArray *)prizes{
    NSInteger count = prizes.count;
    NSMutableString *content = [[NSMutableString alloc] init];
    for (NSInteger i=0; i<count; i++) {
        Prize *newlucky = [prizes objectAtIndex:i];
        [content appendString:[NSString stringWithFormat:@"恭喜会员%@获得%@红包    ",newlucky.nickname,newlucky.amount_red]];
    }
    self.marqueeLabel.text = content;
}
//加载奖品信息
-(void)loadRotaryDatas:(NSArray *)rotary{
    self.rotaty = rotary;
    [self setLabelWithRotary:rotary];
    
}


//暂停/开始滚动
- (void)pauseTap:(UITapGestureRecognizer *)recognizer {
    MarqueeLabel *continuousLabel2 = (MarqueeLabel *)recognizer.view;
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (!continuousLabel2.isPaused) {
            [continuousLabel2 pauseLabel];
        } else {
            [continuousLabel2 unpauseLabel];
        }
    }
}


-(void)setLabelWithRotary:(NSArray *)rotary{
    NSArray *arr = [[NSArray alloc] initWithObjects:label1,label2,label3,label4,label5,label6,label7,label8,label9,label10,label11,label12, nil];
    NSInteger count = arr.count;
    for (NSInteger i=0; i<count; i++) {
        UILabel *label = [arr objectAtIndex:i];
        Rotary *data = rotary[i];
        label.text = data.cash;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"activityRule"]) {
        UIViewController *viewController = segue.destinationViewController;
        viewController.hidesBottomBarWhenPushed = YES;
    }
}

//抽奖
- (IBAction)drawLotteryAction:(id)sender {
    NSInteger num = self.prizeIndexInfo.nums;
    self.prizeIndexInfo.nums--;
    long peoples = self.prizeIndexInfo.peoples;
    if (num<=0) {
        [SVProgressHUD showErrorWithStatus:@"您今日抽奖次数已用完"];
    }else{
        [self initViews];
        timer = [NSTimer scheduledTimerWithTimeInterval:intervalTime target:self selector:@selector(startChoujiang:) userInfo:currentView repeats:NO];
        timerOut = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerOut) userInfo:nil repeats:YES];
        num--;
        peoples++;
        self.tipLabel.text = [NSString stringWithFormat:@"您当前还有%ld次机会，已有%ld人参与抽奖",(long)num,peoples];
    }
}
- (IBAction)checkRules:(id)sender {
    //    [index1Service loadWebViewWithURLString:RewardRuleURL andTitle:@"活动规则" onViewContrller:self];
}
- (IBAction)rewardRecord:(id)sender {
    [index1Service presentRewardRecordViewControllerInViewController:self];
}

//初始化views的效果
-(void)initViews{
    intervalTime = 0.8;//起始的变换时间差（速度）
    currentView.image = HongbaoImg;
    currentView = [array objectAtIndex:0];
    currentView.image = CurImg;
    startButton.enabled = NO;
}

-(void)startChoujiang:(id)sender{
    NSUInteger count = array.count;
    NSTimer *myTimer = (NSTimer *)sender;
    UIImageView *preView = (UIImageView *)myTimer.userInfo;
    NSUInteger index;
//    static NSUInteger resultValue=13;
    if (preView==nil) {
        index = 0;
    }else{
        index = [array indexOfObject:preView];
    }
    if (index==count-1) {
        currentView = [array objectAtIndex:0];
    }else{
        currentView = [array objectAtIndex:index+1];
    }
    [index1Service moveCurrentView:currentView inArray:array];
    NSLog(@"%f",intervalTime);
    if (intervalTime>0.1) {
        intervalTime = intervalTime - 0.1;
    }else{
        static int rotateCount = 0;
        rotateCount ++;
        if (rotateCount==2*count) {
            if (resultValue==13) {
                resultValue++;//这里设置13，14主要是用来防止在一次抽奖，发送了2次请求
                NSInteger __block serialid;
                [index1Service getPrizeLUckyWithToken:user.token andUser_Type:user.user_type withDone:^(Prize_Model_Info *model){
                    if (model == nil) {
                        serialid=0;
                    }else{
                        serialid= [model.serialid integerValue];
                    }
                    resultValue = serialid;
                    if (resultValue<1||resultValue>12) {
                        //后台有可能会返回0，但是对应的serialid没有0，6是“谢谢参与”
                        resultValue=6;
                    }
                    [self endChoujiang];
                }];
                rotateCount = 0;
            }
        }
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:intervalTime target:self selector:@selector(startChoujiang:) userInfo:currentView repeats:NO];
}


-(void)timerOut{
    outTime += timerOut.timeInterval;
    NSLog(@"outTime:%f  timerOut.timeInterval:%f",outTime,timerOut.timeInterval);
    if (timerOut.valid==YES) {
        if (outTime>20) {
            outTime = 0;
            resultValue = 6;
            [self endChoujiang];
        }
    }
}

-(void)endChoujiang{
    accelerate = [index1Service accelerateSpeedOfTimeMomentWithResultValue:resultValue andEndTimerTotal:endTimerTotal inViews:array whenCurrentView:currentView];
    [self moveToStopWithAccelerate];
}

//减速至停止
-(void)moveToStopWithAccelerate{
    static float timeTotal = 0;
    if (timeTotal<endTimerTotal) {
        intervalTime = intervalTime+accelerate;
        timeTotal = timeTotal+intervalTime;
        currentView = [index1Service nextViewByCurrentView:currentView andArray:array];
        [index1Service moveCurrentView:currentView inArray:array];
        [timer invalidate];
        timer = [NSTimer scheduledTimerWithTimeInterval:intervalTime target:self selector:@selector(moveToStopWithAccelerate) userInfo:nil repeats:NO];
    }else{
        [timer invalidate];
        [timerOut invalidate];
        outTime=0;
        timeTotal = 0;
        [index1Service showAwardViewWithDatas:self.rotaty andCurrentView:currentView andSerialid:resultValue inController:self];
        resultValue=13;
        startButton.enabled = YES;
    }
    
}

#pragma UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
    }else if(buttonIndex==1) {
        [SharedAction shareWithTitle:alertView.title andDesinationUrl:AppDownLoadURL Text:alertView.message andImageUrl:@"hongbao.jpg" InViewController:self];
    }
}
- (IBAction)shareAction:(id)sender {
    [SharedAction shareWithTitle:@"抽奖了" andDesinationUrl:AppDownLoadURL Text:@"E小区每天都有5次免费得抽奖机会哦 赶快加入吧" andImageUrl:@"hongbao.jpg" InViewController:self];
}
@end
