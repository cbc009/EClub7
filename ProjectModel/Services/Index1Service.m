//
//  Index1Service.m
//  ProjectModel
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "Index1Service.h"
#import "WebViewController.h"
#import "RewardRecordsViewController.h"
#import "PrizeDao.h"
#import "SVProgressHUD.h"
#import "SharedData.h"
#import "Login.h"
#import "JSONModelLib.h"
#import "PrizeIndex.h"
#import "SharedData.h"
#import "Login.h"
#import <MarqueeLabel.h>
#define HongbaoImg [UIImage imageNamed:@"hongbao.jpg"]
#define CurImg nil

@implementation Index1Service

-(NSInteger)serialidBytakeLottery{
    NSInteger serialid;
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    PrizeDao *prizedao = [[PrizeDao alloc] init];
    PrizeModel *model = [prizedao takeLotteryWithUser_type:user.user_type andToken:user.token];
    if (model == nil) {
        serialid = 0;
    }else{
        serialid = [model.serialid integerValue];
    }
    return serialid;
}



//得到上一个view
-(UIImageView *)previewByCurrentView:(UIImageView *)curView andArray:(NSArray *)views{
    NSUInteger count = views.count;
    NSUInteger curIndex = [views indexOfObject:curView];
    NSUInteger preIndex;
    if (curIndex==0) {
        preIndex = count-1;
    }else{
        preIndex = curIndex-1;
    }
    return [views objectAtIndex:preIndex];
}

//得到下一个view
-(UIImageView *)nextViewByCurrentView:(UIImageView *)curView andArray:(NSArray *)views{
    NSUInteger count = views.count;
    NSUInteger curIndex = [views indexOfObject:curView];
    NSUInteger nextIndex;
    if (curIndex==count-1) {
        nextIndex = 0;
    }else{
        nextIndex = curIndex+1;
    }
    return [views objectAtIndex:nextIndex];
}

//计算时间的加速度
-(float)accelerateSpeedOfTimeMomentWithResultValue:(NSUInteger)resultValue andEndTimerTotal:(float)endTimerTotal inViews:(NSArray *)views whenCurrentView:(UIImageView *)currentView{
    float a;
    NSUInteger currentIndex = [views indexOfObject:currentView];
    NSUInteger count = views.count;
    float NSUIntegerervalTime = 0.1;
    NSUInteger endLength;
    
    if (resultValue>currentIndex+1) {
        endLength = resultValue-currentIndex+count-1;
    }else{
        endLength = 2*count-currentIndex-1+resultValue;
    }
    a = (2*endTimerTotal/endLength-2*NSUIntegerervalTime)/(endLength-1);
    return a;
}

//红包移动一下
-(void)moveCurrentView:(UIImageView *)curView inArray:(NSArray *)views{
    
    UIImageView *preView = [self previewByCurrentView:curView andArray:views];
    preView.image = HongbaoImg;
    curView.image = CurImg;
}

-(void)showAwardViewWithDatas:(NSArray *)datas andCurrentView:(UIImageView *)currentView andSerialid:(NSUInteger)serialid inController:(UIViewController *)viewController{
    NSUInteger index = serialid;
    Rotary *data = [datas objectAtIndex:index-1];
    serialid = 13;
    NSString *result = nil;
    NSLog(@"%@",data.cash);
    if ([data.cash isEqualToString:@"谢谢参与"]) {
        result = @"这次没有中奖";
    }else{
        result = [NSString stringWithFormat:@"我这次抽奖中了%@元",data.cash];
        SharedData *sharedData = [SharedData sharedInstance];
        UserInfo *user = sharedData.user;
        if ([data.cash hasSuffix:@"币"]) {
            user.point = user.point +[data.cash integerValue];
        }else{
            user.amount_red = user.amount_red+[data.cash floatValue];
        }
        
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"中奖信息" message:result delegate:viewController cancelButtonTitle:@"取消" otherButtonTitles:@"告诉朋友", nil];
    [alertView show];
    NSLog(@"你中了：%@元红包",result);
}

//加载网络webview（活动规则）
-(void)loadWebViewWithURLString:(NSString *)URLString andTitle:(NSString *)title onViewContrller:(UIViewController *)viewController{
    WebViewController *webViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    webViewController.hidesBottomBarWhenPushed = YES;
    webViewController.urlString = URLString;
    webViewController.title = title;
    [viewController.navigationController pushViewController:webViewController animated:YES];
}

//跳至中奖记录
-(void)presentRewardRecordViewControllerInViewController:(UIViewController *)viewController{
   
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RewardRecordsViewController *recordViewController = [storyboard instantiateViewControllerWithIdentifier:@"RewardRecordsViewController"];
    recordViewController.hidesBottomBarWhenPushed = YES;
    [viewController.navigationController pushViewController:recordViewController animated:YES];
}

//加载最新中奖的小伙伴信息
-(void)loadPrizeDataInViewController:(Index1ViewController *)viewController{
    
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    NSString *urlString = [NSString stringWithFormat:PrizeIndexURL,user.token,user.user_type];
    NSLog(@"%@",urlString);
    [SVProgressHUD showWithStatus:@"正在加载今日抽奖信息"];
    [PrizeIndex getModelFromURLWithString:urlString completion:^(PrizeIndex *object,JSONModelError *error){
        
        if (object.status == 2) {
            NSArray *lucky = object.info.prize;
            NSArray *rotary = object.info.rotary;
            viewController.prizeIndexInfo = object.info;
            [self loadPrizeDatas:lucky inViewController:viewController];
            [self loadRotaryDatas:rotary inViewController:viewController];
            viewController.tipLabel.text = [NSString stringWithFormat:@"您当前还有%d次机会，已有%ld人参与抽奖",object.info.nums,object.info.peoples];
            
            [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:@"没有数据"];
        }
    }];
    
}

//加载中奖人信息
-(void)loadPrizeDatas:(NSArray *)prizes inViewController:(Index1ViewController *)viewController{
    NSInteger count = prizes.count;
    NSMutableString *content = [[NSMutableString alloc] init];
    for (NSInteger i=0; i<count; i++) {
        Prize *newlucky = [prizes objectAtIndex:i];
        [content appendString:[NSString stringWithFormat:@"恭喜会员%@获得%@元红包    ",newlucky.nickname,newlucky.amount_red]];
    }
    viewController.marqueeLabel.text = content;
}
//加载奖品信息
-(void)loadRotaryDatas:(NSArray *)rotary inViewController:(Index1ViewController *)viewController{
    viewController.rotaty = rotary;
    [viewController setLabelWithRotary:rotary];
    
}

//-(NSArray *)datasByRotary:(NSArray *)rotary{
//    NSInteger count = rotary.count;
//    NSMutableArray *arr = [[NSMutableArray alloc] init];
//    for (NSInteger i=0; i<count; i++) {
//        Rotary *data = [rotary objectAtIndex:i];
//        NSString *cash = data.cash;
//        [arr addObject:cash];
//    }
//    return arr;
//}

@end
