//
//  LifeHallService.m
//  Club
//
//  Created by MartinLi on 15-1-8.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "LifeHallService.h"
#import "LifehallModel.h"
#import <JSONModelLib.h>
#import "WebViewController.h"
#import <SVProgressHUD.h>
@implementation LifeHallService
//生活馆
-(void)lifehalllifehalllistWithAgent_id:(NSInteger )agent_id andTabbarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done
{
    NSString *urlString =[NSString stringWithFormat:Lifehall_lifehall_list_URL,agent_id];
    [LifehallModel getModelFromURLWithString:urlString completion:^(LifehallModel *model,JSONModelError *error){
       
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
}
//生活馆详情
-(void)presentLifeHallDetailwithToken:(NSString *)token andUser_type:(NSInteger )uesr_type andLifeHall_id:(NSString*)lifehall_id inViewControllerOnViewController:(UIViewController *)viewController{
    WebViewController *target = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    target.urlString = [NSString stringWithFormat:Lifehall_lifehall_info_URL,lifehall_id,token,uesr_type];
    target.title =@"生活馆详情";
//    target.view.frame = CGRectMake(0, 66, DeviceFrame.size.width, DeviceFrame.size.height-100);
    target.hidesBottomBarWhenPushed = YES;
    [viewController.navigationController pushViewController:target animated:YES];
}

@end
