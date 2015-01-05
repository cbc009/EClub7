//
//  GroupService.m
//  Club
//
//  Created by MartinLi on 14-10-15.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "GroupService.h"
#import "JSONModelLib.h"
#import "SVProgressHUD.h"
#import "Groups_Goods.h"
#import "Login.h"
#import "SharedData.h"
#import "MyMD5.h"
#import "Status.h"
#import "AdvertPic.h"
#import "MartinLiPageScrollView.h"
#import "GroupsViewController.h"
#import "SharedAction.h"
#import "Index0Service.h"
#import "CreatePayViewController.h"
@implementation GroupService

-(void)groupsGoodsfutureWithToken:(NSString*)token andUser_type:(NSInteger )user_type withDoneObject:(doneWithObject)done
{
    NSString *urlString = [NSString stringWithFormat:Groups_Goods_future_URL,token,user_type,@"1"];
    [Groups_Goods getModelFromURLWithString:urlString completion:^(Groups_Goods *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info withDone:done];
    }];
}
-(void)loadAdverPicFromUrl:(NSString *)urlString inViewController:(GroupsViewController *)viewController{
    NSLog(@"%@",urlString);
    [AdvertPic getModelFromURLWithString:urlString completion:^(AdvertPic *model,JSONModelError *err){
        if (model.status) {
            NSArray *pictures = model.info.picture;
            viewController.pageviewDatas =pictures;
             [viewController.tableview reloadData];
        }else{
            [SharedAction showErrorWithStatus:model.status witViewController:viewController];
        }
    }];
}

-(void)addToGroupInViewController:(GroupDetailViewController *)viewController withPassword:(NSString *)password{
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    NSString *gid = viewController.groupGood.gid;
    NSString *nums =viewController.numbs.text;
    NSString *passwd = [MyMD5 md5:password];
    NSString *urlString = [NSString stringWithFormat:GroupSignUp,user.token,user.user_type,gid,nums,passwd];
    [Status getModelFromURLWithString:urlString completion:^(Status *model,NSError *error){
        if (model.status==2) {
            user.amount = user.amount - [viewController.groupGood.discount floatValue]*[nums integerValue];
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"团购成功" message:@"请到小区所在生活馆及时提取物品" delegate:viewController cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertView.tag=2;
            alertView.alertViewStyle = UIAlertViewStyleDefault;
            [alertView show];
        }else {
            [SharedAction showErrorWithStatus:model.status witViewController:viewController];
        }
    }];
}
//跳到充值页面
-(void)presentCreatePayViewControllerOnViewController:(UIViewController *)viewController{
    NSLog(@"dd");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index3" bundle:nil];
    CreatePayViewController *createPayViewController = [storyboard instantiateViewControllerWithIdentifier:@"CreatePayViewController"];
    [viewController.navigationController pushViewController:createPayViewController animated:YES];
    
}
/*
    秒转化成详细时间
 */
-(NSString *)toDetailTime:(NSInteger)seconds{
    int second = seconds % 60;
    int minute = (seconds-second)/60%60;
    int hour = (seconds-second-minute*60)/60/60%24;
    int day = (seconds-second-minute*60-hour*60*24)/60/60/24%24;
    NSString *detailTime = [NSString stringWithFormat:@"还剩%d天 %d:%d:%d",day,hour,minute,second];
    return detailTime;
}
@end
