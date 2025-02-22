//
//  Index0Service.m
//  ProjectModel
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "Index0Service.h"
#import "SVProgressHUD.h"

#import "Index0Models.h"
#import "LoginViewController.h"
#import "Index0Models.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "JSONModelLib.h"
#import "SharedAction.h"
#import "AdvertPic.h"
#import "MartinLiPageScrollView.h"
#import "CallPhoneViewController.h"
#import "BalanceModel.h"
#import "BalanceData.h"
#import "Member_Login.h"
#import "BuyService.h"
@implementation Index0Service

-(void)loadUserDefaultsInViewController:(Index0_3ViewController *)viewController witLoginStatus:(NSString *)loginStatus andLongitude:(NSString *)longitude andLatitude:(NSString *)latitude{
    if ([viewController.tabBarController.presentedViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)viewController.tabBarController.presentedViewController;
        if ([nav.viewControllers.firstObject isKindOfClass:[LoginViewController class]]) {
            NSLog(@"用户从登录界面进来，不需要重复加载数据了");
        }
    }else{
        //用户进来需要实时刷新数据。
        SharedData *sharedData = [SharedData sharedInstance];
        NSString *name = sharedData.loginname;
        NSString *password = sharedData.password;
        NSString *urlString;
        if ([loginStatus isEqualToString:@"YES"]) {
            urlString= [NSString stringWithFormat:Login_Member_Login_URL,name,password,longitude,latitude];
        }else{
            urlString= [NSString stringWithFormat:Login_Member_Login_URL,@"",@"",longitude,latitude];
        }
        [SVProgressHUD showWithStatus:@"正在加载用户信息"];
        [Member_Login getModelFromURLWithString:urlString completion:^(Member_Login *model,JSONModelError *error){
            if (model.status==2) {
                sharedData.user=model.info;
                viewController.cityLabel.text=sharedData.user.city_name;
                [SharedAction setUMessageTagsWithUser:model.info];
                [self loadAdverPicWithPos:1 andAgentID:sharedData.user.agent_id inViewController:viewController];
                [self loginIndexWithAgentId:sharedData.user.agent_id andLifeHallId:sharedData.user.lifehall_id inViewCOntroller:viewController];
            }else{
                [SVProgressHUD showErrorWithStatus:model.error];
                [SharedAction presentLoginViewControllerInViewController:viewController];
            }
            NSLog(@"%@",urlString);
            [SVProgressHUD showSuccessWithStatus:@"加载完成"];
        }];
    }
}

-(void)loginIndexWithAgentId:(NSInteger)agent_id andLifeHallId:(NSInteger)lifeHall_id inViewCOntroller:(Index0_3ViewController*)viewController{
    NSString *urlString =[NSString stringWithFormat:Login_Index_URL,agent_id,lifeHall_id];
    [Index0Models getModelFromURLWithString:urlString completion:^(Index0Models *model,JSONModelError *error){
        NSLog(@"%@",urlString);
        if (model.status==2) {
            viewController.objects=model.info;
            [viewController.tableview reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:model.error];
        }
    }];

}

//-(void)loadGoodTypeWithToken:(NSString *)token andUser_type:(NSInteger )user_type

/*
 加载广告图片
 */
-(void)loadAdverPicWithPos:(NSInteger)pos andAgentID:(NSInteger)agent_id inViewController:(Index0_3ViewController *)viewController{
    NSString *urlString = [NSString stringWithFormat:AdPictUrl,agent_id,pos];
    [AdvertPic getModelFromURLWithString:urlString completion:^(AdvertPic *model,JSONModelError *err){
        if (model.status==2) {
            AdvertPicInfo *Info =model.info;
            Picture_Arr_advert *pictures =Info.arr_advert;
            NSArray *pictures1 = pictures.arr_info;
            viewController.pageviewDatas = pictures1;
            [viewController.tableview reloadData];
        }else{
            [SharedAction showErrorWithStatus:model.status andError:model.error witViewController:viewController];
        }
    }];
}
//从数组中添加图片
-(NSArray *)namesFromPictures:(NSArray *)pictures{
    if (pictures) {
        NSMutableArray *names = [[NSMutableArray alloc] init];
        for (int i=0; i<pictures.count; i++) {
            Arr_Advert_info *models = pictures[i];
            NSString *name = [NSString stringWithFormat:@"%@%@",IP,models.picture];
            [names addObject:name];
        }
        return names;
    }else{
        return nil;
    }
}
//从数组中标题
-(NSArray *)titlesFromPictures:(NSArray *)pictures{
    if (pictures) {
        NSMutableArray *titles = [[NSMutableArray alloc] init];
        for (int i=0; i<pictures.count; i++) {
            Arr_Advert_info *picture = pictures[i];
            NSString *title = nil;
            if (picture.title!=nil) {
                title = picture.title;
            }else{
                title = @"";
            }
            [titles addObject:title];
        }
        return titles;
    }else{
        return nil;
    }
}
//从数组中添加链接
-(NSArray *)urlsFromPictures:(NSArray *)pictures{
   if (pictures) {
        NSMutableArray *urls = [[NSMutableArray alloc] init];
        for (int i=0; i<pictures.count; i++) {
            Arr_Advert_info *picture = pictures[i];
            NSString *url = nil;
            if (picture.url!=nil) {
                url = picture.url;
            }else{
                url = @"";
            }
            [urls addObject:url];
        }
        return urls;
    }else{
        return nil;
    }
}
-(void)presentChangeAgentViewControllerIn:(Index0_3ViewController*)viewController{
    UIStoryboard *storBoard =[UIStoryboard storyboardWithName:@"ChangeAgent" bundle:nil];
    ChangeAgentViewController *changeAgentVIewController =[storBoard instantiateViewControllerWithIdentifier:@"ChangeAgentViewController"];
    [viewController presentViewController:changeAgentVIewController animated:YES completion:nil];

}
-(void)presentMorePush_historyIn:(Index0_3ViewController*)viewController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    UIViewController *target = [storyboard instantiateViewControllerWithIdentifier:@"MorePush_history"];
    target.navigationController.navigationItem.leftBarButtonItem.title=@"首页";
    target.hidesBottomBarWhenPushed = YES;
    [viewController.navigationController pushViewController:target animated:YES];
}
-(void)prensentSerchViewControllerIn:(Index0_3ViewController*)viewController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index4" bundle:nil];
    UIViewController *target = [storyboard instantiateViewControllerWithIdentifier:@"SerchViewController"];
    target.hidesBottomBarWhenPushed = YES;
    [viewController.navigationController pushViewController:target animated:YES];
}
@end
