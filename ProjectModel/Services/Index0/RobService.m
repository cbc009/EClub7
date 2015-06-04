//
//  RobService.m
//  Club
//
//  Created by dongway on 14-8-19.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "RobService.h"
#import "SVProgressHUD.h"
#import "Robuy_Goods.h"
#import "NSString+MT.h"
#import "Status.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "Member_History.h"
#import "JSONModelLib.h"
#import "Rob_goods_history.h"
#import "NSString+MT.h"
#import "AdvertPic.h"
#import "MartinLiPageScrollView.h"
#import "Index0Service.h"
#import "SharedAction.h"
#import "Seller_Info.h"
@implementation RobService

-(void)setRobModelWithLifehallid:(NSString *)lifehallid orDetail:(NSString *)detail inRootTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    [SVProgressHUD show];
    NSString *urlString = [NSString stringWithFormat:Robuy_Goods_URL,lifehallid,detail];
    [Robuy_Goods getModelFromURLWithString:urlString completion:^(Robuy_Goods *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
}


/*
 加载广告图片
 */
-(void)loadAdverPicWithPos:(NSInteger)pos inViewController:(RobViewController *)viewController{
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    NSString *urlString = [NSString stringWithFormat:AdPictUrl,user.agent_id,pos];
    NSLog(@"urlString:%@",urlString);
    [self loadAdverPicFromUrl:urlString inViewController:viewController];
}

-(void)loadAdverPicFromUrl:(NSString *)urlString inViewController:(RobViewController *)viewController{
    [AdvertPic getModelFromURLWithString:urlString completion:^(AdvertPic *model,JSONModelError *err){
        if (model.status) {
            AdvertPicInfo *Info =model.info;
            Picture_Arr_advert *pictures =Info.arr_advert;
            NSArray *pictures1 = pictures.arr_info;
            viewController.pageviewDatas = pictures1;
            [viewController.tableView reloadData];
        }else{
            [SharedAction showErrorWithStatus:model.status andError:model.error witViewController:viewController];
        }
    }];
}
-(void)robWithToken:(NSString *)token andLifehallId:(NSString *)lifehall_id andUser_type:(NSInteger )user_type andRobModel:(Robuy_Goods_arr_goods_info *)robModel inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    if ([robModel.starttime compareCurrentTimeWith:robModel.starttime]==NSOrderedDescending) {
        [SVProgressHUD showErrorWithStatus:@"未到抢菜时间"];
    }else{
        [SVProgressHUD showWithStatus:@"正在努力抢菜中......."];
        NSString *gid = robModel.goods_id;
        NSString *urlString = [NSString stringWithFormat:Robuy_Goods_Now_URL,lifehall_id,gid,token,user_type];
        [Status getModelFromURLWithString:urlString completion:^(Status *model,JSONModelError *error){
            [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model inTabBarController:tabBarController withDone:done];
        }];
    }

}


//开抢
-(void)robWithToken:(NSString *)token andUser_type:(NSInteger )user_type andRobModel:(Robuy_Goods_arr_goods_info *)robModel inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    if ([robModel.starttime compareCurrentTimeWith:robModel.starttime]==NSOrderedDescending) {
        [SVProgressHUD showErrorWithStatus:@"未到抢菜时间"];
    }else{
        [SVProgressHUD showWithStatus:@"正在努力抢菜中......."];
        NSString *gid = robModel.goods_id;
        NSString *urlString = [NSString stringWithFormat:Rob_Robuy_Order_URL,token,user_type,gid];
        [Status getModelFromURLWithString:urlString completion:^(Status *model,JSONModelError *error){
            [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model inTabBarController:tabBarController withDone:done];
        }];
    }
}

-(void)presentRobDetailViewControllerIn:(RobViewController*)robViewController and:(Seller_Seller_Goods_arr_goods_info*)robuyGood{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    RobDetailViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"RobDetailViewController"];
    [robViewController.navigationController pushViewController:viewController animated:YES];
    viewController.robGoodsMOdel = robuyGood;
}




@end
