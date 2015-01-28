//
//  PartnerListServise.m
//  Club
//
//  Created by MartinLi on 15-1-19.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "PartnerListServise.h"
#import <JSONModelLib.h>
#import "WebViewController.h"
#import <SVProgressHUD.h>

#import "Partner_list_Model.h"

@implementation PartnerListServise
-(void)partnerPartnerListWithToken:(NSString *)token andUer_type:(NSInteger )user_type andTabbarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done
{
    NSString *urlString =[NSString stringWithFormat:Partner_Partner_List_URL,token,user_type];
    [Partner_list_Model getModelFromURLWithString:urlString completion:^(Partner_list_Model *model,JSONModelError *error){
        [SVProgressHUD show];
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
}
-(void)presentpartnerDetailwithToken:(NSString *)token andUser_type:(NSInteger )uesr_type andPartner_id:(NSString*)partner_id inViewControllerOnViewController:(UIViewController *)viewController{
    WebViewController *target = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    target.urlString = [NSString stringWithFormat:Partner_Partner_Info_URL,partner_id,token,uesr_type];
    target.title =@"生活馆详情";
    target.view.frame = CGRectMake(0, 66, DeviceFrame.size.width, DeviceFrame.size.height-100);;
    target.hidesBottomBarWhenPushed = YES;
    [viewController.navigationController pushViewController:target animated:YES];
}

@end
